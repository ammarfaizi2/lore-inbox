Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262421AbRE0VsX>; Sun, 27 May 2001 17:48:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262420AbRE0VsO>; Sun, 27 May 2001 17:48:14 -0400
Received: from mta7.pltn13.pbi.net ([64.164.98.8]:17087 "EHLO
	mta7.pltn13.pbi.net") by vger.kernel.org with ESMTP
	id <S262415AbRE0VsD>; Sun, 27 May 2001 17:48:03 -0400
Date: Sun, 27 May 2001 14:47:57 -0700 (PDT)
From: Chris Rankin <rankinc@pacbell.net>
Subject: Hard lockup switching to X from vc; Matrox G400 AGP
To: linux-kernel@vger.kernel.org
Message-id: <200105272147.f4RLlv300461@twopit.underworld>
MIME-version: 1.0
X-Mailer: ELM [version 2.5 PL3]
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

REF: Linux 2.4.5, 2.4.4, 2.4.3 (and probably earlier);
     devfs;
     SMP (dual PIII);
     < 1GB main memory

Hi,

Has anyone noticed their Linux box lock up hard (as in cannot even be
pinged from the local network) when switching from a text vc to a vc
running X? This has happened for me even without the mga.o and
agpgart.o modules being loaded. My current workaround has been to swap
out the Matrox-supplied mga_drv.o and mga_hal_drv.o modules and
replace them with the ones from the standard X 4.03 distribution, but
these are userspace objects and shouldn't be capable of bringing the
kernel down. (Like I said, the machine can't even be pinged.)

My best guess is that the mga_hal_drv.o object is ticking an obscure
kernel bug. I am raising this with the Matrox support line as well.

Cheers,
Chris
