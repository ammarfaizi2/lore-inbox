Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263244AbTDCCnt>; Wed, 2 Apr 2003 21:43:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263247AbTDCCnt>; Wed, 2 Apr 2003 21:43:49 -0500
Received: from sj-core-2.cisco.com ([171.71.177.254]:28808 "EHLO
	sj-core-2.cisco.com") by vger.kernel.org with ESMTP
	id <S263244AbTDCCnp>; Wed, 2 Apr 2003 21:43:45 -0500
From: "Hua Zhong" <hzhong@cisco.com>
To: "Robert White" <rwhite@casabyte.com>, "Christoph Rohland" <cr@sap.com>,
       "Daniel Egger" <degger@fhm.edu>
Cc: <linux-kernel@vger.kernel.org>
Subject: RE: PATCH: allow percentile size of tmpfs (2.5.66 / 2.4.20-pre2)
Date: Wed, 2 Apr 2003 18:54:24 -0800
Message-ID: <CDEDIMAGFBEBKHDJPCLDCEGEDGAA.hzhong@cisco.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.6604 (9.0.2911.0)
In-Reply-To: <PEEPIDHAKMCGHDBJLHKGKEOLCFAA.rwhite@casabyte.com>
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4920.2300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Yes, you are absolutely right...

> I presume the below was a typo and In the second mount it should be
> 
> "mount -t ext2 -o loop /mnt/tmp/A /mnt/loopback"
> 
> instead of just
> 
> "mount -t ext2 -o loop /mnt/tmp /mnt/loopback"
> 
> Else wise the directory name "/mnt/tmp" would most certainly be a 
> bad target
> for a loopback mount.
> 
> Rob.
> 
> 
> -----Original Message-----
> From: linux-kernel-owner@vger.kernel.org
> [mailto:linux-kernel-owner@vger.kernel.org]On Behalf Of Hua Zhong
> Sent: Tuesday, April 01, 2003 11:55 PM
> To: Christoph Rohland; Daniel Egger
> Cc: linux-kernel@vger.kernel.org
> Subject: RE: PATCH: allow percentile size of tmpfs (2.5.66 /
> 2.4.20-pre2)
> 
> 
> mount -t tmpfs tmpfs /mnt/tmp
> extract file A to /mnt/tmp/A
> mount -t ext2 -o loop /mnt/tmp /mnt/loopback
> 
> You'll get "ioctl: LOOP_SET_FD: Invalid argument".
> 
> 
