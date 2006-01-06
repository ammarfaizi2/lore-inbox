Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751384AbWAFMuE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751384AbWAFMuE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jan 2006 07:50:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751478AbWAFMuE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jan 2006 07:50:04 -0500
Received: from hulk.jobsahead.com ([202.138.125.174]:1224 "EHLO
	hulk.jobsahead.com") by vger.kernel.org with ESMTP id S1751384AbWAFMuC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jan 2006 07:50:02 -0500
Subject: Re: High load
From: Aniruddh Singh <aps@jobsahead.com>
To: Con Kolivas <kernel@kolivas.org>
Cc: linux <linux-kernel@vger.kernel.org>
In-Reply-To: <200601052100.45107.kernel@kolivas.org>
References: <1136454597.6016.7.camel@aps.monsterindia.noida>
	 <200601052100.45107.kernel@kolivas.org>
Content-Type: text/plain
Date: Fri, 06 Jan 2006 18:06:11 +0530
Message-Id: <1136550971.5557.2.camel@aps.monsterindia.noida>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-4.asl) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

there is a raid 0 and raid controller is Smart Array 64xx (rev 01)

hdparm -tT /dev/cciss/c0d0p2 returns the following

/dev/cciss/c0d0p2:
 Timing buffer-cache reads:   2660 MB in  2.00 seconds = 1329.92 MB/sec
 Timing buffered disk reads:  248 MB in  3.00 seconds =  82.55 MB/sec

if i try to hdparm -I /dev/cciss/c0d0 it returns 
/dev/cciss/c0d0:
 operation not supported on SCSI disks






On Thu, 2006-01-05 at 21:00 +1100, Con Kolivas wrote:
> On Thursday 05 January 2006 20:49, Aniruddh Singh wrote:
> > HI all,
> >
> > I have one compaq server with 4 Intel(R) Xeon cpu's (3.1GHZ), 4GB RAM.
> > OS:- Fedora Core 2
> > Kernel:- 2.6.14
> >
> > when i compile a new kernel, during th compilation process load goes
> > very high (10 and little above). i can not understand why does this
> > happen, while if i compile the same kernel on my P4 machine with 1GB ram
> > and 3GHZ, it remains under 3.
> >
> > can somebody tell me what is wrong?
> > -
> 
> Sounds suspiciously like DMA is not working on your drives. Check your dmesg 
> logs and what hdparm returns.
> 
> Con
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
-- 
Regards
Aniruddh Singh
System Administrator
Monster.com India Pvt. Ltd.
FC 23, Block B, 1st Floor, Sector 16A
Film City Noida 201301 U.P.


