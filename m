Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265474AbTF1Xh3 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Jun 2003 19:37:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265483AbTF1Xh3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Jun 2003 19:37:29 -0400
Received: from 82-43-130-207.cable.ubr03.mort.blueyonder.co.uk ([82.43.130.207]:641
	"EHLO efix.biz") by vger.kernel.org with ESMTP id S265474AbTF1XhX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Jun 2003 19:37:23 -0400
Subject: Re: Linux 2.4.22-pre2 and AthlonMP
From: Edward Tandi <ed@efix.biz>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <1056842271.6753.19.camel@dhcp22.swansea.linux.org.uk>
References: <1056833424.30265.39.camel@wires.home.biz>
	 <1056837060.6778.2.camel@dhcp22.swansea.linux.org.uk>
	 <1056840603.30264.45.camel@wires.home.biz>
	 <1056842271.6753.19.camel@dhcp22.swansea.linux.org.uk>
Content-Type: text/plain
Message-Id: <1056844328.2315.22.camel@wires.home.biz>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.0 
Date: 29 Jun 2003 00:52:08 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2003-06-29 at 00:17, Alan Cox wrote:
> On Sad, 2003-06-28 at 23:50, Edward Tandi wrote:
> > > > using option 'pci=noacpi' or even 'acpi=off'
> > > > Jun 28 18:27:46 machine kernel: BIOS failed to enable PCI standards
> > > > compliance, fixing this error.
> > > 
> > > Start by upgrading to their current BIOS
> > 
> > Believe or not, it _is_ the latest bios for that board
> > (Tyan S2460 BIOS v1.05, 2nd Jan 2003).
> 
> Then I guess you have a problem. We try and fix up BIOS problems but there
> is a limit to what we can do, and if it has problems like the one that is
> logged I'd be worried what else it might do - eg I suspect Nvidia 4x AGP cards
> aren't too solid on it.

It does have an AGP NVidia card in it. I'm using the standard XFree
drivers with it at the moment but I have played UT on it for hours
before (using NVidia drivers) without problems. It might be an AGP x2
card though. The computer is now mostly a back-end server and I haven't
really pushed it on the graphics side recently.

Could the problem be caused by some BIOS setting? I could spend some
time looking at them.

> The APIC errors also suggest something isn't happy at all at the hardware
> layer. Are you using MP processors ?

Yes, MP processors. This is not a new machine, It has been running quite
nicely for nearly two years. There have been some kernel releases in the
past that have shown some instability, but I can usually find a fairly
recent version and tweak the kernel-build settings so that it becomes
stable.

The version running prior to this one was 2.4.21-rc3. This version
allowed me to specify noapic.

Ed-T.

> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

