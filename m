Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293131AbSB1CKT>; Wed, 27 Feb 2002 21:10:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293133AbSB1CI3>; Wed, 27 Feb 2002 21:08:29 -0500
Received: from c007-h011.c007.snv.cp.net ([209.228.33.217]:49892 "HELO
	c007.snv.cp.net") by vger.kernel.org with SMTP id <S293149AbSB1CG7>;
	Wed, 27 Feb 2002 21:06:59 -0500
X-Sent: 28 Feb 2002 02:06:52 GMT
Message-ID: <3C7D90BC.394C1E2A@bigfoot.com>
Date: Wed, 27 Feb 2002 18:06:52 -0800
From: Tim Moore <timothymoore@bigfoot.com>
Organization: Yoyodyne Propulsion Systems, Inc.
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.2.21pre2-Ole i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: disk transfer speed problem
In-Reply-To: <3C7D4666.6D35B124@pcnet.ro>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>  #dmesg|grep UDMA
> hda: 14668290 sectors (7510 MB) w/418KiB Cache, CHS=913/255/63, UDMA(66)
> (this is the boot disk)
> 
> hdc: 156301488 sectors (80026 MB) w/2048KiB Cache, CHS=155061/16/63,
> UDMA(100
> hdd: 156301488 sectors (80026 MB) w/2048KiB Cache, CHS=155061/16/63,
> UDMA(100)

Please post dmesg, /proc/pci and chipset info from /proc/ide.  Also,
what is result from 'hdparm -tT /dev/hda'?

rgds,
tim.
--
