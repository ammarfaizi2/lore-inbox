Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751003AbWBWJAq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751003AbWBWJAq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Feb 2006 04:00:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751630AbWBWJAq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Feb 2006 04:00:46 -0500
Received: from fnoeppeil48.netpark.at ([217.175.205.176]:64778 "EHLO
	roarinelk.homelinux.net") by vger.kernel.org with ESMTP
	id S1751003AbWBWJAq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Feb 2006 04:00:46 -0500
Date: Thu, 23 Feb 2006 10:00:43 +0100
From: Manuel Lauss <mano@roarinelk.homelinux.net>
To: Fabio Comolli <fabio.comolli@gmail.com>
Cc: kernel list <linux-kernel@vger.kernel.org>, mdharm-usb@one-eyed-alien.net,
       usb-storage@lists.one-eyed-alien.net,
       linux-usb-users@lists.sourceforge.net
Subject: Re: Problems with USB MMC/SD card reader
Message-ID: <20060223090043.GA28761@roarinelk.homelinux.net>
References: <b637ec0b0602230042s1736ed73lb54022a3dae70a0d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b637ec0b0602230042s1736ed73lb54022a3dae70a0d@mail.gmail.com>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,
> logical block 248367
> Feb 23 08:44:22 kepler kernel: sd 2:0:0:0: SCSI error: return code = 0x8000002
> Feb 23 08:44:22 kepler kernel: sdb: Current: sense key=0x3
> Feb 23 08:44:22 kepler kernel:     ASC=0x11 ASCQ=0x0
> Feb 23 08:44:22 kepler kernel: Info fld=0x1e5271
> Feb 23 08:44:22 kepler kernel: end_request: I/O error, dev sdb, sector 1987185
> Feb 23 08:44:22 kepler kernel: Buffer I/O error on device sdb1,
> logical block 248367
> -------------------
> Kernel is vanilla 2.6.16-rc4; output of /proc/bus/usb/devices and

> .config are attached.

wild guess: enable the CONFIG_SCSI_MULTI_LUN config option.

-- 
 ml.


