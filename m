Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288797AbSAEMV1>; Sat, 5 Jan 2002 07:21:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288795AbSAEMVR>; Sat, 5 Jan 2002 07:21:17 -0500
Received: from ns2.auctionwatch.com ([64.14.24.2]:38409 "EHLO
	whitestar.auctionwatch.com") by vger.kernel.org with ESMTP
	id <S288793AbSAEMVB>; Sat, 5 Jan 2002 07:21:01 -0500
Date: Sat, 5 Jan 2002 04:20:47 -0800
From: Petro <petro@auctionwatch.com>
To: "Henning P. Schmiedehausen" <hps@intermeta.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Two hdds on one channel - why so slow?
Message-ID: <20020105122047.GC29003@auctionwatch.com>
In-Reply-To: <B51F07F0080AD511AC4A0002A52CAB445B2A5A@ottonexc1.ottawa.loran.com> <a16ppd$shs$1@forge.intermeta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a16ppd$shs$1@forge.intermeta.de>
User-Agent: Mutt/1.3.24i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 05, 2002 at 11:58:37AM +0000, Henning P. Schmiedehausen wrote:
> If you need more than say, three or four disks, your solution is
> SCSI. Or FibreChannel.

    Which points up another dimension to this issue, that of "host
    controller v.s. drive electronics". 

    Most of the FW drives I've seen use a FW->IDE bridge and have IDE
    drives inside. This overcomes the biggest problem with IDE IMO, the
    limit of one (or two if you'll accept the performance degradation)
    drive per channel leading to lots of cables to fuss with. 

    I've got a 1.8T Exabyte disk box that has 24 IDE drives in it. It
    attaches to the host computer via FC. 

-- 
Share and Enjoy. 
