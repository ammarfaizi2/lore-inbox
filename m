Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271926AbRH2INP>; Wed, 29 Aug 2001 04:13:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271927AbRH2INF>; Wed, 29 Aug 2001 04:13:05 -0400
Received: from h24-64-71-161.cg.shawcable.net ([24.64.71.161]:45302 "EHLO
	webber.adilger.int") by vger.kernel.org with ESMTP
	id <S271926AbRH2IM4>; Wed, 29 Aug 2001 04:12:56 -0400
From: Andreas Dilger <adilger@turbolabs.com>
Date: Wed, 29 Aug 2001 02:13:04 -0600
To: VDA <VDA@port.imtp.ilyichevsk.odessa.ua>
Cc: linux-kernel@vger.kernel.org
Subject: Re: fsck root fs: fsck, devfs, /proc/mounts miscooperate.
Message-ID: <20010829021304.D24270@turbolinux.com>
Mail-Followup-To: VDA <VDA@port.imtp.ilyichevsk.odessa.ua>,
	linux-kernel@vger.kernel.org
In-Reply-To: <22075604.20010829095413@port.imtp.ilyichevsk.odessa.ua>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <22075604.20010829095413@port.imtp.ilyichevsk.odessa.ua>
User-Agent: Mutt/1.3.20i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Aug 29, 2001  09:54 +0300, VDA wrote:
> # fsck /dev/scsi/host0/bus0/target1/lun0/part1
> Parallelizing fsck version 1.15 (18-Jul-1999)
> e2fsck 1.15, 18-Jul-1999 for EXT2 FS 0.5b, 95/08/09
> /dev/scsi/host0/bus0/target1/lun0/part1 is mounted.
> 
> WARNING!!!  Running e2fsck on a mounted filesystem may cause
> SEVERE filesystem damage...

Get a new version of e2fsprogs (at http://sf.net/projects/e2fsprogs).
The detection of mounted root filesystems has changed in recent releases,
so it _should_ be fixed - let us know if it is not.

Cheers, Andreas
-- 
Andreas Dilger  \ "If a man ate a pound of pasta and a pound of antipasto,
                 \  would they cancel out, leaving him still hungry?"
http://www-mddsp.enel.ucalgary.ca/People/adilger/               -- Dogbert

