Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287816AbSBMXF3>; Wed, 13 Feb 2002 18:05:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289062AbSBMXFT>; Wed, 13 Feb 2002 18:05:19 -0500
Received: from ppp1238-cwdsl.fr.cw.net ([62.210.116.215]:49426 "EHLO
	calvin.paulbristow.lan") by vger.kernel.org with ESMTP
	id <S287816AbSBMXFG>; Wed, 13 Feb 2002 18:05:06 -0500
Message-ID: <3C6AF196.4060206@paulbristow.net>
Date: Thu, 14 Feb 2002 00:07:02 +0100
From: Paul Bristow <paul@paulbristow.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.7) Gecko/20011221
X-Accept-Language: en-us
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Align removeable media behaviour?
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

During the 2.5 cycle, I see we are going to remove ide-scsi.  This means 
Iomega are going to have to accept that ide-floppy works for ATAPI 
Zip/PocketZip drives and they may wish to consider not trying to force 
people to use ide-scsi any more.  I guess they will want some IOCTLs 
implemented to do this.

Rather than add yet more code to ide-floppy, (yes I know it needs 
cleaning - if I ever get a 2.5.x to compile I may be able to do so), 
should we consider aligning the behaviour of all removeable devices?  I 
know Jens is working on the ATAPI CD burning and MO drives, but we have 
parallel port drives, USB, Firewire, ATAPI, SCSI, floppy and god knows 
what else out there, all in different subsystems with different 
maintainers.  Should we attempt to have a common set of IOCTLs for ll 
format, lock, unlock, eject, validate, grok_partitions etc etc?

It might be a lot easier for userland utilities to have a set of 
expected behaviours and supported IOCTLs from the drivers.

-- 

Paul Bristow

Email: 
paul@paulbristow.net
Web: 
http://paulbristow.net
ICQ: 
11965223

