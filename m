Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263431AbRFAJ1F>; Fri, 1 Jun 2001 05:27:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263433AbRFAJ0z>; Fri, 1 Jun 2001 05:26:55 -0400
Received: from phoenix.datrix.co.za ([196.37.220.5]:46704 "EHLO
	phoenix.datrix.co.za") by vger.kernel.org with ESMTP
	id <S263431AbRFAJ0l>; Fri, 1 Jun 2001 05:26:41 -0400
Date: Fri, 1 Jun 2001 11:27:32 +0200 (SAST)
From: Marcin Kowalski <kowalski@datrix.co.za>
To: alan@lxorguk.ukuu.org.uk
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.5 VM
In-Reply-To: <Pine.LNX.4.10.10106011028150.6653-100000@webman.medikredit.co.>
Message-ID: <Pine.LNX.4.10.10106011121460.6653-100000@webman.medikredit.co.za>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Relating to Huge Dcache and InodeCache Entries and < 2xMem Swap.
I have a server with > 1.1gig of RAM which I have limited to 1gig (due to
stability - BUG at HIGHMEM.c: 155 crashes)...

The size of the Swap space is 620mb... my memory usage is below :

Mem:        900008     892748       7260          0      14796     171796
-/+ buffers/cache:     706156     193852
Swap:       641016       1792     639224

The extract out of slabinfo is:
inode_cache       903876 930840    480 116355 116355    1 :  124   62
bdev_cache          1160   1357     64   23   23    1 :  252  126
sigqueue             261    261    132    9    9    1 :  252  126
dentry_cache      775520 934560    128 31152 31152    1 :  252  126

As you can see the usage is crazy....bearing in mind a number of things.
The system is running hardware raid5, reiserfs and massive amount of files
> 500000 in >2000 directories..

It is a 2x933mhz PIII + 1.1gig of ram NEtservers

What I really want to know is DOES THIS REALLY Matter. IE If memory is
needed by and application are these entries simply purged then.. In which
case there is no problem????

Regards
and THanks
MarCin


 -------------------------------------
#    Marcin Kowalski                # 
      On_Linux Developer.
       ->Datrix Solutions.<-
	
	Tel. 770-6146
#	Cel. 082-400-7603           #
-------------------------------------


