Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282844AbRLLWoH>; Wed, 12 Dec 2001 17:44:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282848AbRLLWn5>; Wed, 12 Dec 2001 17:43:57 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:15378 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S282844AbRLLWnw>; Wed, 12 Dec 2001 17:43:52 -0500
Subject: Re: 2.4.16 not booting with Athlon optimisations
To: lakeland@atlas.otago.ac.nz (Corrin Lakeland)
Date: Wed, 12 Dec 2001 22:51:44 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.OSF.4.21.0112130954120.517863-100000@atlas.otago.ac.nz> from "Corrin Lakeland" at Dec 13, 2001 10:01:37 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16EIE4-0002jn-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> went largely as expected until I decided to recompile the kernel (2.4.16)
> for the Duron rather than a generic PII.  Immediatly after booting with
> the new kernel I got oopses.  Changing kernel parameters doesn't seem to
> have any effect -- Duron optimisation -> !boot.

Congratulations. You probably have a VIA chipset and a BIOS that misconfigures
MWQ. 2.4.17pre8 might work for you, as might a BIOS update

