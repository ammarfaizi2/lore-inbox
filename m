Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268336AbUHQQac@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268336AbUHQQac (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Aug 2004 12:30:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266138AbUHQQab
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Aug 2004 12:30:31 -0400
Received: from email-out1.iomega.com ([147.178.1.82]:50625 "EHLO
	email.iomega.com") by vger.kernel.org with ESMTP id S268336AbUHQQaM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Aug 2004 12:30:12 -0400
Mime-Version: 1.0 (Apple Message framework v619)
Content-Type: text/plain;
	charset=US-ASCII;
	delsp=yes;
	format=flowed
Message-Id: <C63C080F-F06A-11D8-9368-00039398BB5E@ieee.org>
Content-Transfer-Encoding: 7bit
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
From: Pat LaVarre <p.lavarre@ieee.org>
Subject: Re: Linux Serial ATA (SATA) status report
Date: Tue, 17 Aug 2004 10:30:39 -0600
To: Andreas Jellinghaus <aj@dungeon.inka.de>
X-Mailer: Apple Mail (2.619)
X-OriginalArrivalTime: 17 Aug 2004 16:30:11.0228 (UTC) FILETIME=[7764B5C0:01
	C48477]
X-imss-version: 2.0
X-imss-result: Passed
X-imss-scores: Clean:18.38799 C:20 M:1 S:5 R:5
X-imss-settings: Baseline:1 C:1 M:1 S:1 R:1 (0.0000 0.0000)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

// Andreas J:

 > > Date: 2004-07-09 8:17:21
 > > IIRC Plextor is shipping dvd burners with SATA
 > > interface.
 > ...
 >  
http://www.plextor.be/products/dvd_recorders/px-712sa.asp?choice=PX 
-712SA
 > ...
 > > Any idea whether or not these will work?

Will Linux find and name a SATAPI device?

Every 2.4 Linux I've tried connects with the SATAPI device I have.   
Knoppix Linux 2.4, my own kernel, etc.  Seemingly the 2.4 cdrom and  
ide-cd driver modules connect to SATAPI, same as PATAPI.  But 2.6  
introduces CONFIG_BLK_IDE_SATA.  drivers/ide/Kconfig explains why.

In my newbie ignorance, me, I think that explanation means to say that,  
by make defconfig, as yet you don't get SATAPI in 2.6, but you can  
still ask for it to work as well in 2.6 as in 2.4, except if you do ask  
for SATAPI you might lose SATAPI anyhow by losing support for the  
unusual SATA host you have.  However, I'm confident other people here  
in linux-ide understand this far far better than I.

Pat LaVarre
http://linux-pel.blog-city.com/read/742498.htm

P.S. What effects the ide-scsi and ide-floppy driver modules might have  
with SATAPI, I do not know.

