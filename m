Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751197AbWAUJNL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751197AbWAUJNL (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Jan 2006 04:13:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751199AbWAUJNL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Jan 2006 04:13:11 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:47494 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S1751197AbWAUJNK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Jan 2006 04:13:10 -0500
Date: Sat, 21 Jan 2006 10:13:02 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Michael Loftis <mloftis@wgops.com>
cc: dtor_core@ameritech.net, James Courtier-Dutton <James@superbug.co.uk>,
       linux-kernel@vger.kernel.org
Subject: Re: Development tree, PLEASE?
In-Reply-To: <30D11C032F1FC0FE9CA1CDFD@d216-220-25-20.dynip.modwest.com>
Message-ID: <Pine.LNX.4.61.0601211008320.21704@yvahk01.tjqt.qr>
References: <D1A7010C56BB90C4FA73E6DD@dhcp-2-206.wgops.com> 
 <43D10FF8.8090805@superbug.co.uk>  <6769FDC09295B7E6078A5089@d216-220-25-20.dynip.modwest.com>
 <d120d5000601200850w611e8af8v41a0786b7dc973d9@mail.gmail.com>
 <30D11C032F1FC0FE9CA1CDFD@d216-220-25-20.dynip.modwest.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> Ok, so you agree that there was an ample warning that devfs is going
>> away... Now, what would be different if 2.8.0 released tomorrow
>> without devfs and your vendor would require you to build new Debian
>> installer and kernel?
>
> Because that would be expected.  That constitutes a major release, and should
> theoretically have had a development tree corresponding before it.

So let's rename 2.6.16 to 2.7.0, plus:

 - (implicitly with the *rename*) stop the 2.6.x series

 - never use 2.<even>.x again
   (some people still don't seem to get that <even> does not mean
   "stable" in the 2.4 sense)
   - or start 3.x with an overall new counting scheme

 - follow the current development model as usual

> I really understand atleast some of the reasons from the kernel development
> standpoint, and can see many really good reasons for running a development tree
> like this, and as a method of development I like and agree with it.
> However...for the general consumption there still needs to be some sort of
> stable target that can be used that's 'blessed' with that mark, and will get
> atleast some attention by developers for security updates and (mostly major)
> bugfixes, and that people can contribute these sorts of things to, probably
> with the proviso that they also contribute it to the mainline dev kernel maybe
> IE if you're going to add new supported device to 'stable' 2.6.16.x then you've
> got to add it to whatever the current 'dev' line is say 2.6.22 or whatever.
> The placing of the .'s is just symbolic.  It could be 2.6.x and 2.7.x just as
> in the past or it could be 3.0.0.x and 3.0.0+n


Jan Engelhardt
-- 
