Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315178AbSEKWTl>; Sat, 11 May 2002 18:19:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315202AbSEKWTk>; Sat, 11 May 2002 18:19:40 -0400
Received: from host194.steeleye.com ([216.33.1.194]:43783 "EHLO
	pogo.mtv1.steeleye.com") by vger.kernel.org with ESMTP
	id <S315178AbSEKWTj>; Sat, 11 May 2002 18:19:39 -0400
Message-Id: <200205112219.g4BMJZp13459@localhost.localdomain>
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
To: linux-kernel@vger.kernel.org
cc: James.Bottomley@HansenPartnership.com
Subject: [PATCH: NEW ARCHITECTURE FOR 2.5.15] support for NCR voyager (3/4/5xxx
 series)
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sat, 11 May 2002 18:19:35 -0400
From: James Bottomley <James.Bottomley@HansenPartnership.com>
X-AntiVirus: scanned for viruses by AMaViS 0.2.1 (http://amavis.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds SMP (and UP) support for voyager which is an (up to 32 way) 
SMP microchannel non-PC architecture.

There's basically nothing different from the 2.5.10 one except for updates and 
changes to the arch-split.

The patch is in two parts:  The i386 sub-architecture split is separated from 
the addition of the voyager components

http://www.hansenpartnership.com/voyager/files/arch-split-2.5.15.diff (144k)
http://www.hansenpartnership.com/voyager/files/voyager-2.5.15.diff (147k)

(The split diff is pretty huge because it's actually moving files about).  You 
must apply the split diff before applying the voyager one.

These two patches are also available as separate bitkeeper trees:

http://linux-voyager.bkbits.net/voyager-2.5
http://linux-voyager.bkbits.net/arch-split-2.5

James Bottomley


