Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284285AbRL1XXI>; Fri, 28 Dec 2001 18:23:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284360AbRL1XXD>; Fri, 28 Dec 2001 18:23:03 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:46861 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S284301AbRL1XWt>; Fri, 28 Dec 2001 18:22:49 -0500
Subject: Re: Sound stops while playing DVD with via82cxxx_audio driver
To: andre.dahlqvist@telia.com (=?iso-8859-1?Q?Andr=E9?= Dahlqvist)
Date: Fri, 28 Dec 2001 23:28:13 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20011228192700.GA7346@telia.com> from "=?iso-8859-1?Q?Andr=E9?= Dahlqvist" at Dec 28, 2001 08:27:00 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16K6Q9-0002Db-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 00:07.5 Multimedia audio controller: VIA Technologies, Inc. AC97 Audio Controller (rev 21)
> 	Subsystem: Sigmatel Inc: Unknown device 7600
> 	Flags: medium devsel, IRQ 9
> 	I/O ports at dc00 [size=256]
> 	I/O ports at e000 [size=4]
> 	I/O ports at e400 [size=4]
> 	Capabilities: [c0] Power Management version 2
> 
> It is 100% reproducable, and it usually happens around 4-6 minutes into
> a DVD. After that has happened sounds in other programs will be silent

Random guess of the week. Disable ACPI support and turn off APM in the BIOS
then repeat the test. If that stops it then it sounds like some kind of
power management is turning off the codec.

Let us know what it shows 

Alan
