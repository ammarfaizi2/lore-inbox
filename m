Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316753AbSHOLHm>; Thu, 15 Aug 2002 07:07:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316768AbSHOLHm>; Thu, 15 Aug 2002 07:07:42 -0400
Received: from mail-fe71.tele2.ee ([212.107.32.235]:61893 "HELO everyday.com")
	by vger.kernel.org with SMTP id <S316753AbSHOLHl> convert rfc822-to-8bit;
	Thu, 15 Aug 2002 07:07:41 -0400
Date: Thu, 15 Aug 2002 13:11:33 +0200
Message-Id: <200208151111.NAA01608@eday-fe3.tele2.ee>
From: "Thomas Munck Steenholdt" <tmus@get2net.dk>
Cc: linux-kernel@vger.kernel.org
To: "Alan Cox" <alan@lxorguk.ukuu.org.uk>
Subject: Re: promise ultra 133 tx2 lets system standby during use...?
MIME-Version: 1.0
X-EdMessageId: 004d170a1b544f505c4b5553571c5a415e135e1f5d515b5c14114c54525962565d74
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Thu, 2002-08-15 at 11:21, Thomas Munck Steenholdt wrote:
> > I've been having a lot of problems with my Ultra 133 TX2 controller,
> > that if I boot my system a just doesn't touch it for a while, the
> system
> > suspends to complete standby, even though the ext3 data is committed
> > every 5 secs. causing disk activity and thus should disallow standby
> > behaviour (at least that's the way it works on my onboard controller).
> 
> Lots of BIOSes are not bright enough to monitor a second IDE controller.
> You should be able to frob in the APM/ACPI bios and add its IRQ line to
> the monitor list

That would be in the BIOS right (or could it be done from linux) ?

Like i mentioned, my system is an IBM, which means tailored for users, 
which means that it(this particular system) won't let me add IRQ's to
monitor, at least not from within the BIOS setup.
I can select to monitor "Hard Disks" "Serial Ports" that kind
of granularity... But at least, what you are telling me, suggests to me
that actually this is probably a problem in my BIOS rather than the kernel.

Would apm=off bypass this kind of thing?


-- Send gratis SMS og brug gratis e-mail på Everyday.com -- 

