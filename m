Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264325AbTL3COn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Dec 2003 21:14:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264333AbTL3COn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Dec 2003 21:14:43 -0500
Received: from smtp2.att.ne.jp ([165.76.15.138]:9215 "EHLO smtp2.att.ne.jp")
	by vger.kernel.org with ESMTP id S264325AbTL3COl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Dec 2003 21:14:41 -0500
Message-ID: <00d401c3ce7a$a302fd80$98ee4ca5@DIAMONDLX60>
From: "Norman Diamond" <ndiamond@wta.att.ne.jp>
To: "Thomas Molina" <tmolina@cablespeed.com>
Cc: <dan@eglifamily.dnsalias.net>, <linux-kernel@vger.kernel.org>
References: <007101c3cdbc$046a58d0$2fee4ca5@DIAMONDLX60> <Pine.LNX.4.58.0312291741530.5409@localhost.localdomain>
Subject: Re: Blank Screen in 2.6.0
Date: Tue, 30 Dec 2003 11:14:07 +0900
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1158
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thomas Molina wrote:
> On Mon, 29 Dec 2003, Norman Diamond wrote:
> > Dan wrote:
> >
> > > Upgraded to the lastest module-init-tools, and disabled the
> > > frame buffer support in the kernel. So the only graphic option enabled is
> > > text mode selection. But when I boot I still get a blank screen!
> > > My lilo.conf contains a line: vga=773, which works beautifully under
> > > RedHat's stock 2.4.20-8.
> >
> > In my experience the vga= option worked with every 2.4 kernel in every
> > distro that I had used, continued working with 2.6 test* and 0 in Red Hat
> > 7.3, but blanked the screen with 2.6 test* and 0 in SuSE 8.1 and SuSE 8.2.
> > Haven't tried other configurations with 2.6.
> >
> > But now you're getting the same with a Red Hat distro, so it's looking
> > pretty random.
> >
> > The decision to release 2.6.0 with the same broken vga= option that was
> > reported many times in 2.6.0-test* makes me think that vga= is not intended
> > to work.
>
> Maybe it has something to do with RedHat 7.3.

Are you serious?  It really is true that vga= isn't supposed to work in
2.6.0, but there is something to do with RedHat 7.3 which caused vga= to
continue to work in 2.6.0 with that distro only?  Then why hasn't the vga=
parameter been removed entirely?

> I've used RH8, RH9, and  Fedora Core 1 and haven't had a problem with vga=
> in any of them during the 2.5/2.6 series, right up through the current one.

I forgot if Dan is using RH8 or RH9.  Whichever, you're getting different
results than he did, because his failed with one of these and yours works
with both.  At least my failures with SuSE are consistent.  I'd say the
overall inconsistency points to a bug in 2.6.0-test* and .0.  Especially
when no one seems to be reporting similar failures in the 2.4 series.

