Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264646AbTBTOe5>; Thu, 20 Feb 2003 09:34:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264657AbTBTOe5>; Thu, 20 Feb 2003 09:34:57 -0500
Received: from noodles.codemonkey.org.uk ([213.152.47.19]:34481 "EHLO
	noodles.internal") by vger.kernel.org with ESMTP id <S264646AbTBTOe4>;
	Thu, 20 Feb 2003 09:34:56 -0500
Date: Thu, 20 Feb 2003 14:57:19 +0000
From: Dave Jones <davej@codemonkey.org.uk>
To: Song Zhao <song.zhao@nuix.com.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Supermicro X5DL8-GG (ServerWorks Grandchampion LE chipset) slow
Message-ID: <20030220145719.GC13507@codemonkey.org.uk>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	Song Zhao <song.zhao@nuix.com.au>, linux-kernel@vger.kernel.org
References: <200302202034.28676.song.zhao@nuix.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200302202034.28676.song.zhao@nuix.com.au>
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 20, 2003 at 08:34:28PM -0500, Song Zhao wrote:

 > Dual 2.8GHz Xeon, 3ware Escalade 7850 (7500-8) 12 port IDE RAID controller, 
 > RAID 10, 4x 1GB DDR SDRAM Registered ECC, 2x 80GB WD HDD, 10x 120GB WD HDD, 
 > ServerWorks Grand Champion LE. 
 > I am running RH7.3 with 2.4.20 kernel. The performance of this box is about 
 > half of an almost identical box (Supermicro X5DP8-G2 mobo, E7501 chipset)

You mentioned nothing about what sort of performance you were measuring.
Disk, network, memory bandwidth etc.., however at a complete guess you
are hitting this..

mtrr: Serverworks LE detected. Write-combining disabled.

This workaround was for older sewerworks chipsets which were
buggy. Rumour has it that revisions 6 and above are ok.
I have a patch pending for 2.5, if it turns out to be stable,
it should also get merged back to 2.4

		Dave

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
