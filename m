Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275087AbSITFtu>; Fri, 20 Sep 2002 01:49:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275094AbSITFtu>; Fri, 20 Sep 2002 01:49:50 -0400
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:65031
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S275087AbSITFtt>; Fri, 20 Sep 2002 01:49:49 -0400
Date: Thu, 19 Sep 2002 22:51:37 -0700 (PDT)
From: Andre Hedrick <andre@linux-ide.org>
To: Reg Clemens <reg@dwf.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Dont understand hdc=ide-scsi behaviour.
In-Reply-To: <200209192108.g8JL8iT6010419@orion.dwf.com>
Message-ID: <Pine.LNX.4.10.10209192249440.25090-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Because only the lastest code base under -ac and maybe 2.5 is beginning to
to be device selectable.

hdc=scsi
insmod ide-cd
insmod ide-scsi

Be done

Cheers,

Andre Hedrick
LAD Storage Consulting Group

On Thu, 19 Sep 2002, Reg Clemens wrote:

> 
> I dont understand the behaviour of kernel 2.4.18 (and probably all others) when
> I put the line
> 		hdc=ide-scsi
> on the load line.
> 
> I would EXPECT to get the ide-scsi driver for hdc (my cdwriter) but instead 
> get it for BOTH hdc and hdd, the cdwriter and the zip drive.
> 
> After starting this way (with hdc=ide-scsi), I find that 
> 	/dev/cdrom2 -> /dev/scd0
> and that to access the zip drive I have to use /dev/sda1 (or /dev/sda4)
> 
> I would EXPECT to get to them via /dev/hdd1 or /dev/hdd4.
> 
> Did I miss something or is this a bug????
> 
> 				Reg.Clemens
> 				reg@dwf.com
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

