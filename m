Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264839AbSKNLML>; Thu, 14 Nov 2002 06:12:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264854AbSKNLML>; Thu, 14 Nov 2002 06:12:11 -0500
Received: from dp.samba.org ([66.70.73.150]:49317 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S264839AbSKNLMK>;
	Thu, 14 Nov 2002 06:12:10 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: David Brownell <david-b@pacbell.net>
Cc: linux-kernel@vger.kernel.org, greg@kroah.com
Subject: Re: 2.5.47bk2 + current modutils == broken hotplug 
In-reply-to: Your message of "Thu, 14 Nov 2002 00:02:36 -0800."
             <3DD3589C.5000002@pacbell.net> 
Date: Thu, 14 Nov 2002 21:01:41 +1100
Message-Id: <20021114111904.9A5312C25F@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <3DD3589C.5000002@pacbell.net> you write:
> Hotplugging may well change more in 2.5, but I'd rather have it do
> so on a more flexible schedule than "quick, before 2.5.48 ships"!  :)

Hey, I want to get humpty dumpty back together ASAP, too.  But I'm in
Spain without an x86 box (my test box is available though a modem to
IBM's intranet, two ssh's away), so it's a little difficult for me,
too.  And I'm still catching up on mail.

> Is it true that the infrastructure newly in place can easily be
> made to provide (from user-space) the policy of "driver remains
> loaded until the devices it's bound to are all unplugged"?

That should always be true, unless I'm missing something.  What kind
of devices?

> That'd be a user-friendly policy, but we'd still need to handle
> today's developer-oriented "sysadmin can always remove module"
> policy.  (Me, I'd run with the "user friendly" policy except
> when hacking a driver.  Then I'd debug/rmmod/update/modprobe.)

rmmod -f is about as unfriendly as you can get, really 8)

Cheers,
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
