Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314526AbSD0AOr>; Fri, 26 Apr 2002 20:14:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314550AbSD0AOq>; Fri, 26 Apr 2002 20:14:46 -0400
Received: from dialin-145-254-130-055.arcor-ip.net ([145.254.130.55]:32260
	"EHLO dale.home") by vger.kernel.org with ESMTP id <S314526AbSD0AOp>;
	Fri, 26 Apr 2002 20:14:45 -0400
Date: Sat, 27 Apr 2002 02:14:37 +0200
From: Alex Riesen <fork0@users.sourceforge.net>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.10(bk r1.558): oops on mount cdrom (scsi emulation)
Message-ID: <20020427021437.A360@steel>
Reply-To: Alex Riesen <fork0@users.sourceforge.net>
In-Reply-To: <20020427020320.A181@steel>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.23i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 27, 2002 at 02:03:20AM +0200, Alex Riesen wrote:
> That is. Just tried. Details below.
> 
> mount options:
> 
> /dev/scd0	/mnt/cdrom  iso9660 noauto,user,gid=100,unhide,mode=0444,ro
> 
> Device is a cd-recorder:
> 
> SCSI subsystem driver Revision: 1.00
> Uniform CD-ROM driver unloaded
> SCSI subsystem driver Revision: 1.00
> ide: unexpected interrupt 1 15
> scsi0 : SCSI host adapter emulation for IDE ATAPI devices
>   Vendor: AOPEN     Model: CD-RW CRW2440     Rev: 1.00
>   Type:   CD-ROM                             ANSI SCSI revision: 02
> Attached scsi CD-ROM sr0 at scsi0, channel 0, id 0, lun 0
> sr0: scsi3-mmc drive: 40x/40x writer cd/rw xa/form2 cdda tray
> 
> 
> Oops is the oops below (slightly formatted). It's reproducable, though
> i'd like to avoid the reproduction.

Sorry, did some quick lookup in archives and found that this problem
was already reported by Sebastian Droege.

 Subject: [2.5.9/2.5.10] ide-scsi oops
 Date: 2002-04-24 14:20:57 PST

Waiting for news, then.

-alex


