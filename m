Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314544AbSDZXyF>; Fri, 26 Apr 2002 19:54:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314545AbSDZXyE>; Fri, 26 Apr 2002 19:54:04 -0400
Received: from zcamail05.zca.compaq.com ([161.114.32.105]:16390 "EHLO
	zcamail05.zca.compaq.com") by vger.kernel.org with ESMTP
	id <S314544AbSDZXyE>; Fri, 26 Apr 2002 19:54:04 -0400
From: jmerkey@vger.timpanogas.org
Message-ID: <DEMEXG11jDbVyRYg14s00001582@demexg11.emea.cpqcorp.net>
X-OriginalArrivalTime: 26 Apr 2002 23:53:54.0523 (UTC) FILETIME=[9F7822B0:01C1ED7D]
Date: 27 Apr 2002 01:53:54 +0200
To: undisclosed-recipients:;
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In-Reply-To: <Pine.LNX.4.33L2.0204261416040.14014-100000@dragon.pdx.osdl.net>; from rddunlap@osdl.org on Fri, Apr 26, 2002 at 02:17:53PM -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List:	linux-kernel@vger.kernel.org
Return-Path: linux-kernel-owner+sebastien.cabaniols=40compaq.com@vger.kernel.org
X-OriginalArrivalTime: 26 Apr 2002 23:13:41.0359 (UTC) FILETIME=[011C87F0:01C1ED78]


If you are using a 3Ware adapter, you will need to upgrade 
the firmware to enable 48 bit lba.  Ditto other RAID controllers.

Jeff


On Fri, Apr 26, 2002 at 02:17:53PM -0700, Randy.Dunlap wrote:
> On Fri, 26 Apr 2002, Wakko Warner wrote:
> 
> | Just bought a maxtor 160gb disk and it shows upt as a 137gb disk.  I thought
> | this might be the system board's ide chipset limitation so I put a scsi->ide
> | adapter on the drive.  Same situation occurs.  I'm looking at what the kernel
> | reports when it finds the drive.  /proc/partitions shows this drive as:
> |    8     0  134217727 sda
> | /proc/scsi/scsi shows:
> | Attached devices:
> | Host: scsi0 Channel: 00 Id: 00 Lun: 00
> |   Vendor: Maxtor 4 Model: G160J8           Rev: GAK8
> |   Type:   Direct-Access                    ANSI SCSI revision: 02
> |
> | I tried kernel 2.4.14 and 2.4.18.  Any ideas?
> 
> Hi,
> 
> There was a thread on this 2-3 months back.
> IDE in 2.4 doesn't have a 48-bit block address interface IIRC,
> although Andre has some patches for this.
> This is necessary to go above 137 GB.
> 
> -- 
> ~Randy
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/
