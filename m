Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266416AbRGMBBC>; Thu, 12 Jul 2001 21:01:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266907AbRGMBAv>; Thu, 12 Jul 2001 21:00:51 -0400
Received: from f228.pav2.hotmail.com ([64.4.37.228]:6157 "EHLO hotmail.com")
	by vger.kernel.org with ESMTP id <S266416AbRGMBAl>;
	Thu, 12 Jul 2001 21:00:41 -0400
X-Originating-IP: [198.4.83.53]
From: "Alan Li" <alan_li31@hotmail.com>
To: linux-kernel@vger.kernel.org
Subject: Scsi Driver & Hanging on Writing inode tables for large partitions
Date: Thu, 12 Jul 2001 18:00:37 -0700
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Message-ID: <F2281iRykIl92eEuWut00001a7e@hotmail.com>
X-OriginalArrivalTime: 13 Jul 2001 01:00:38.0152 (UTC) FILETIME=[3AD97080:01C10B37]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I'm very new at this, so here goes:

I'm trying to write a scsi driver, and everything (device detection, 
reading/writing to partition tables) works fine, until I try to mkfs any 
partition larger than 200 megs.  When it's over 200 megs, it would hang on 
writing to the inode tables for ~20 seconds, then spit out many i/o errors.  
Is there a reason why mkfs would work for partitions <200 megs and not for 
partitions larger than that?

Kernel: 2.4.2-2
mke2fs: 1.19
CPU: Pentium Pro 200mhz
Memory: 48mb physical, 256mb swap

I would really appreciate any help, and please cc: any responses to this to 
this email address because I'm not on the mailing list.

Thanks, Alan
_________________________________________________________________
Get your FREE download of MSN Explorer at http://explorer.msn.com

