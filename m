Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263270AbSJJHER>; Thu, 10 Oct 2002 03:04:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263279AbSJJHER>; Thu, 10 Oct 2002 03:04:17 -0400
Received: from e33.co.us.ibm.com ([32.97.110.131]:10641 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S263270AbSJJHEQ>; Thu, 10 Oct 2002 03:04:16 -0400
Date: Thu, 10 Oct 2002 00:11:04 -0700
From: Mike Anderson <andmike@us.ibm.com>
To: Patrick Mochel <mochel@osdl.org>
Cc: Alexander Viro <viro@math.psu.edu>,
       Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: [bk/patch] driver model update: device_unregister()
Message-ID: <20021010071104.GA1355@beaverton.ibm.com>
Mail-Followup-To: Patrick Mochel <mochel@osdl.org>,
	Alexander Viro <viro@math.psu.edu>,
	Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
References: <Pine.GSO.4.21.0210091550150.8980-100000@weyl.math.psu.edu> <Pine.LNX.4.44.0210091612140.16276-100000@cherise.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0210091612140.16276-100000@cherise.pdx.osdl.net>
User-Agent: Mutt/1.4i
X-Operating-System: Linux 2.0.32 on an i486
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Patrick Mochel [mochel@osdl.org] wrote:
> This has been tested on IDE only, as the driver for my SCSI controller 
> (qla1280.o) has stopped working...

I pulled and ran with an aic, ips, and scsi_debug scsi hosts. I looks
better, outside of the cleanups I am currently working on for SCSI
related nodes.

/sys/root/pci1
|-- 01:05.0
|   `-- scsi2
|       |-- 2:0:0:0
|       |   |-- 2:0:0:0:gen
|       |   `-- disk
|       |       `-- partition1
|       |-- 2:0:1:0
|       |   |-- 2:0:1:0:gen
|       |   `-- disk
|       `-- 2:0:5:0
|           `-- 2:0:5:0:gen


-andmike
--
Michael Anderson
andmike@us.ibm.com

