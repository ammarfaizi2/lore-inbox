Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261394AbRE0KD2>; Sun, 27 May 2001 06:03:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261434AbRE0KDJ>; Sun, 27 May 2001 06:03:09 -0400
Received: from A6b93.pppool.de ([213.6.107.147]:20228 "EHLO linux.zuhause.de")
	by vger.kernel.org with ESMTP id <S261394AbRE0KDH>;
	Sun, 27 May 2001 06:03:07 -0400
Content-Type: text/plain; charset=US-ASCII
From: Guido Stepken <stepken@little-idiot.de>
Reply-To: stepken@little-idiot.de
Organization: Stepken & Partner IT - Unternehmensberatung
To: linux-kernel@vger.kernel.org
Subject: Solved ?: IDE Performance lack !
Date: Sun, 27 May 2001 12:06:41 +0200
X-Mailer: KMail [version 1.2]
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <01052712064100.02124@linux.zuhause.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi !

My performance problemes have disappeared. I recompiled the kernel with:

(Direct) PCI access mode
APIC and IOApic   == OFF
SCSI competely == OFF
NE1000/2000 Modules compiled in as Module (directly compiled in did not work)
Changed BIOS PCI Mode to AUTO (perhaps useless)

Now my performance is normal, with and without hdparm optimisations (tnx to 
posters)

IMHO, there are still problems with interrupts (is thre still one 
interrupt/IP paket ??)

regards, Guido Stepken
