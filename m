Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292629AbSBZB1o>; Mon, 25 Feb 2002 20:27:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292604AbSBZB1V>; Mon, 25 Feb 2002 20:27:21 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:3080 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S292605AbSBZB01>; Mon, 25 Feb 2002 20:26:27 -0500
Subject: Re: Patch for sd cleanup
To: zaitcev@redhat.com (Pete Zaitcev)
Date: Tue, 26 Feb 2002 01:41:05 +0000 (GMT)
Cc: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20020225202255.A3526@devserv.devel.redhat.com> from "Pete Zaitcev" at Feb 25, 2002 08:22:55 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16fWc5-00078O-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Marcelo's 2.4.18 does not have this:
> 
> --- linux-2.4.18/drivers/scsi/sd.c	Mon Feb 25 11:38:04 2002
> +++ linux-2.4.18-p3/drivers/scsi/sd.c	Mon Feb 25 17:09:59 2002
> @@ -279,7 +279,7 @@
>   	target = DEVICE_NR(dev);
>  
>  	dpnt = &rscsi_disks[target];
> -	if (!dpnt)
> +	if (!dpnt->device)

In my pile Marcelo is about to get bombed with 8)
