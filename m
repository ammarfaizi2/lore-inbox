Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286887AbRLWN3p>; Sun, 23 Dec 2001 08:29:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286885AbRLWN3f>; Sun, 23 Dec 2001 08:29:35 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:3855 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S286884AbRLWN3X>; Sun, 23 Dec 2001 08:29:23 -0500
Subject: Re: file corruption in 2.4.16/17
To: andre@linux-ide.org (Andre Hedrick)
Date: Sun, 23 Dec 2001 13:39:07 +0000 (GMT)
Cc: chr.ohm@gmx.net (Christian Ohm), linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.10.10112222218220.8976-100000@master.linux-ide.org> from "Andre Hedrick" at Dec 22, 2001 10:48:35 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16I8qJ-0000bm-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> So I suggest you use a corrected driver found at www.linuxdiskcert.org.

I don't think its remotely related to the IDE layer

A number of VIA boards have hardware/bios problems that cause corruption
under certain very high PCI loads. Current 2.4 should set the registers
to do the work arounds needed on the various boards we know have the 
problems as do the VIA 4in1 drivers for windows in most afflicted cases.

The description sounds extremely like that is the problem with this board.


Alan
