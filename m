Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264586AbRFUGEg>; Thu, 21 Jun 2001 02:04:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264847AbRFUGE1>; Thu, 21 Jun 2001 02:04:27 -0400
Received: from mail-ffm-p.arcor-ip.de ([145.253.2.10]:43653 "EHLO
	mail.arcor-ip.de") by vger.kernel.org with ESMTP id <S264586AbRFUGEW>;
	Thu, 21 Jun 2001 02:04:22 -0400
Message-ID: <3b318e663bdab56a@mail.arcor-ip.de> (added by mail.arcor-ip.de)
Content-Type: text/plain; charset=US-ASCII
From: =?iso-8859-1?q?J=F6rg=20Str=F6ttchen?= 
	<joerg.stroettchen@arcormail.de>
To: linux-kernel@vger.kernel.org
Subject: ide-floppy fails on ApolloPro 133A-based MB
Date: Thu, 21 Jun 2001 08:04:28 +0200
X-Mailer: KMail [version 1.2.3]
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hello,

a few days ago I replaced my old MB by a QDI Advance 10F-board (VT82C694X 
+ VT82C686B). Since that time I am running into trouble when writing on my 
IDE-Floppy (/dev/hdb), read-access is ok, all other IDE-devices are working 
fine.

/var/log/messages reports:

cosanostra kernel: hdb: ATAPI reset complete
Jun 20 14:45:29 cosanostra kernel: hdb: lost interrupt
Jun 20 14:45:29 cosanostra kernel: ide-floppy: CoD != 0 in idefloppy_pc_intr

These problems occurr running 2.4.5-ac15 as well as W98. QDI seems to know 
about this problem because they recommend to upgrade to the latest 
VIA-chipset-drivers, which did not help (W98). At this point I am not sure 
wether the "ide-floppy"-issue is MB-specific or chipset-related. Could anyone 
familiar with the VIA-chipset-driver comment on that, maybe its a 
development-aspect for the via-driver ?


Thanks in advance

J. Stroettchen 

