Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262173AbVCEQHb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262173AbVCEQHb (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Mar 2005 11:07:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262956AbVCEQBO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Mar 2005 11:01:14 -0500
Received: from mail-gw0.york.ac.uk ([144.32.128.245]:17586 "EHLO
	mail-gw0.york.ac.uk") by vger.kernel.org with ESMTP id S263130AbVCEP50
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Mar 2005 10:57:26 -0500
Subject: Re: RivaFB and GeForce FX
From: Alan Jenkins <aj504@student.cs.york.ac.uk>
To: ods15 <ods5926@gmail.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <f470889705030505089a4d8df@mail.gmail.com>
References: <1110023602.7572.24.camel@host-172-19-5-120.sns.york.ac.uk>
	 <f470889705030505089a4d8df@mail.gmail.com>
Content-Type: text/plain
Date: Sat, 05 Mar 2005 15:57:12 +0000
Message-Id: <1110038232.7572.44.camel@host-172-19-5-120.sns.york.ac.uk>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.1 
Content-Transfer-Encoding: 7bit
X-York-MailScanner: Found to be clean
X-York-MailScanner-From: aj504@student.cs.york.ac.uk
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Dude you completely forgot the important parts of the code!!
> Sorry I didn't reply to you in that previous e-mail before, I was
> busy, but those vplB and 'format' stuff WAS important, without it, I
> got strange distortions on screen and refreshes were "lagged"... The
> ONLY things you can remove from my patch is the debugging stuff, the
> cursor stuff, and those 2 lines which I commented out in fbdev.c . All
> the rest, HAS to stay, without it rivafb on GeforceFX 5200 (what I
> have) just doesn't work RIGHT. It "works", but it's awful.
> 
> - ods15

Oops.  I defer to your experience.  I didn't notice that much wrong with
it, but definitely something that looked like lagging refreshes - I
described it in more detail in the previous message.

The important parts of the code need reworking to fit in with subsequent
changes.  I'm up for that, but I may need some help in terms of
maintaining good taste; the NV_ARCH_30 case may need to be separated out
a little more than it is at the moment.  I'll post again when I have
something working right.

I owe you an apology; I could not expect you to reply to my query about
the vpllB stuff immediately, and I should have waited until you had.

Also, given that we both tried this on the GeForce FX 5200, and the
single FX card supported under 2.6.11 is a the Mac version of the
GeForce FX GO 5200, it might be a good idea to limit the cards to the
5200 series for the time being.

Yours apologetically,
Alan

PS The email I sent the maintainer bounced anyway


