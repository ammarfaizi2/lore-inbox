Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265099AbTBTKLW>; Thu, 20 Feb 2003 05:11:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265126AbTBTKLW>; Thu, 20 Feb 2003 05:11:22 -0500
Received: from smtpzilla3.xs4all.nl ([194.109.127.139]:7434 "EHLO
	smtpzilla3.xs4all.nl") by vger.kernel.org with ESMTP
	id <S265099AbTBTKLV>; Thu, 20 Feb 2003 05:11:21 -0500
Date: Thu, 20 Feb 2003 11:21:15 +0100
From: Jurriaan <thunder7@xs4all.nl>
To: Song Zhao <song.zhao@nuix.com.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Supermicro X5DL8-GG (ServerWorks Grandchampion LE chipset) slow
Message-ID: <20030220102115.GA5217@middle.of.nowhere>
Reply-To: thunder7@xs4all.nl
References: <200302202034.28676.song.zhao@nuix.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200302202034.28676.song.zhao@nuix.com.au>
X-Message-Flag: Still using Outlook? Please Upgrade to real software!
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Song Zhao <song.zhao@nuix.com.au>
Date: Thu, Feb 20, 2003 at 08:34:28PM -0500
> Hi, 
> 
> I've been doing some benchmarks with this board, it is terribly disppointing. 
> Has anyone had similar experiences?

How many people do you guess own such hardware? Not me :-(

> 
> The hardware spec is:
> Dual 2.8GHz Xeon, 3ware Escalade 7850 (7500-8) 12 port IDE RAID controller, 
> RAID 10, 4x 1GB DDR SDRAM Registered ECC, 2x 80GB WD HDD, 10x 120GB WD HDD, 
> ServerWorks Grand Champion LE. 
> 
> I am running RH7.3 with 2.4.20 kernel. The performance of this box is about 
> half of an almost identical box (Supermicro X5DP8-G2 mobo, E7501 chipset)

what does

cat /proc/mtrr

say?

> 
> Also, this board can't even boot with 8x 1GB memory modules plugged in (8 DIMM 
> slots in total). This is a relative new board and I can't find anything 
> relevant on the net. 
> 
"can't boot" as in crashes halfway during linux or doesn't even start
lilo?

HTH,
Jurriaan
-- 
We are lost, we are freaks
We are crippled, we are weak
We are the heirs, we are the true heirs to all the world.
        New Model Army - Ballad of Bodmin Pill
GNU/Linux 2.5.61 SMP/ReiserFS 2x2105 bogomips load av: 0.93 1.05 0.60
