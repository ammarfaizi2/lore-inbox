Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279995AbRKDN4l>; Sun, 4 Nov 2001 08:56:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279993AbRKDN4b>; Sun, 4 Nov 2001 08:56:31 -0500
Received: from mail124.mail.bellsouth.net ([205.152.58.84]:55056 "EHLO
	imf24bis.bellsouth.net") by vger.kernel.org with ESMTP
	id <S279995AbRKDN4T>; Sun, 4 Nov 2001 08:56:19 -0500
Message-ID: <3BE548FA.DEC6C2B3@mandrakesoft.com>
Date: Sun, 04 Nov 2001 08:56:10 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.13-2mdksmp i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Anton Altaparmakov <aia21@cam.ac.uk>
CC: Sean Middleditch <elanthis@awesomeplay.com>, linux-kernel@vger.kernel.org
Subject: Re: Via Onboard Audio - Round #2
In-Reply-To: <3BE4CC20.5FFEC4B5@mandrakesoft.com>
	 <1004849558.457.15.camel@stargrazer>
	 <3BE4CC20.5FFEC4B5@mandrakesoft.com>
	 <5.1.0.14.2.20011104131312.02bd8ae8@pop.cus.cam.ac.uk> <5.1.0.14.2.20011104134957.00bb5b60@pop.cus.cam.ac.uk>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Anton Altaparmakov wrote:
> 
> At 13:44 04/11/2001, Jeff Garzik wrote:
> >Anton Altaparmakov wrote:
> > > Linux is not
> > > a PNP OS and hence problems like yours often get fixed by setting in the
> > > BIOS that you are not using a PNP OS.
> >
> >Incorrect.  PCI IRQ routing (net effect of "PNP OS: Yes") works fine for
> >everybody except those with Sean's type of PCI IRQ routing table.
> 
> Well, if I reboot set it to YES and boot into Linux my SB Live stops
> working. As does my wintv pci (or my network card, can't remember)... If I
> reboot, set it to NO and boot again then all is fine. Fully reproducible.

Can you do the same thing requested of Sean?

Set PNP OS: Yes in BIOS, enable debugging in
arch/i386/kernel/pci-i386.h, reboot, and post the 'dmesg' output.

-- 
Jeff Garzik      | Only so many songs can be sung
Building 1024    | with two lips, two lungs, and one tongue.
MandrakeSoft     |         - nomeansno

