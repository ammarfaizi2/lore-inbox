Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310897AbSBRRPj>; Mon, 18 Feb 2002 12:15:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310904AbSBRRPT>; Mon, 18 Feb 2002 12:15:19 -0500
Received: from [217.89.50.104] ([217.89.50.104]:61454 "EHLO
	NOTES.INTERCOPE.COM") by vger.kernel.org with ESMTP
	id <S310897AbSBRRPL>; Mon, 18 Feb 2002 12:15:11 -0500
Subject: Re: scsi abort 0x2002 and eth0: too much work on a dual amd 760mpx system
To: linux-kernel@vger.kernel.org
X-Mailer: Lotus Notes Release 5.0.6a  January 17, 2001
Message-ID: <OF23B5BA7B.127AB1D9-ONC1256B64.005D4BCF@INTERCOPE.COM>
From: "Michael Kwasigroch" <mkwasigr@intercope.com>
Date: Mon, 18 Feb 2002 18:12:06 +0100
X-MIMETrack: Serialize by Router on ICHH1G02/INTERCOPE/DE(Release 5.0.3 (Intl)|21 March
 2000) at 18.02.2002 18:14:24
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 2002-02-13 20:26:46 "kelley eicher <carde@astro.umn.edu>" wrote:

> rik-
>
> i have done extensive cpu load + i/o testing on the 760mp machine. it
handles
> perfectly under very high cpu activity. one thing i should mention though
is
> that neither of these chipsets, amd 760mp and amd760mpx, work with multi-
> processor specification 1.4 under linux. i had several problems using
m.p.s.
> 1.4 on the 760mp in dual processor mode and the 760mpx wouldn't even boot
> with m.p.s. 1.4 enabled.
>
> as an fyi to anyone listening, the 760mpx crashed while loading any smp
linux
> kernel during apic timer calibration.
>
> so my suggestion rik, if you haven't done this already, is to change the
> multi- processor specification in your bios from 1.4 to 1.1.
>
> -kelley

I've got the Tyan Tiger MPX (S2466N) running SMP flawlessly with both
2.2.19 (io_apic.c patched) and 2.4.17 (w/ide-patch) ... and Windows 2000
Pro SP2 (;-).

In the BIOS I've left the setting to ACPI (which is the default).

- Why should one want to change that to MPS 1.1/1.4?
- What 760mpx board do you use?

I'm using an old Adaptec 2940 PCI SCSI adaptor for my DAT streamer and it
also works flawlessly (although I feel there is a little bit of improvement
possible by tweaking the PCI latency).

You might want to check http://www.2cpu.com for tips & tricks getting a
dual athlon system running. I'm not connected to this site but it gave me
all the help I needed while choosing the components for my nice new system.
It is #1 for duallies!!!


P.S.: Please cc me directly on any replies since I'm not subscribed to
linux-kernel. TIA.


Mit freundlichen Gruessen / best regards


"The sooner you fall behind, the more time you'll have to catch up."

Michael Kwasigroch
FaxPlus/Open Development
________________________________________

e-mail:        mkwasigr@intercope.com

INTERCOPE
International Communication Products Engineering GmbH

www.intercope.com


