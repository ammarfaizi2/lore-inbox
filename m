Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315345AbSDWVYX>; Tue, 23 Apr 2002 17:24:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315347AbSDWVYW>; Tue, 23 Apr 2002 17:24:22 -0400
Received: from tolkor.sgi.com ([192.48.180.13]:4841 "EHLO tolkor.sgi.com")
	by vger.kernel.org with ESMTP id <S315345AbSDWVYV>;
	Tue, 23 Apr 2002 17:24:21 -0400
Message-ID: <3CC5D19D.5000006@sgi.com>
Date: Tue, 23 Apr 2002 16:26:53 -0500
From: Stephen Lord <lord@sgi.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.7) Gecko/20011226
X-Accept-Language: en-us
MIME-Version: 1.0
To: Miles Lane <miles@megapathdsl.net>
CC: LKML <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.9 -- Build error -- scsidrv.o: In function `ahc_linux_halt':	undefined reference to `ahc_tailq'
In-Reply-To: <1019529784.24480.14.camel@turbulence.megapathdsl.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Miles Lane wrote:

>I searched on http://marc.theaimsgroup.com/?l=linux-kernel
>and didn't find this mentioned.
>
>drivers/scsi/scsidrv.o: In function `ahc_linux_halt':
>drivers/scsi/scsidrv.o(.text+0x78cd): undefined reference to `ahc_tailq'
>drivers/scsi/scsidrv.o(.text+0x78e2): undefined reference to
>`ahc_shutdown'
>drivers/scsi/scsidrv.o: In function `ahc_linux_detect':
>drivers/scsi/scsidrv.o(.text+0x7fb7): undefined reference to `ahc_tailq'
>drivers/scsi/scsidrv.o: In function `ahc_linux_register_host':
>drivers/scsi/scsidrv.o(.text+0x80c6): undefined reference to
>`ahc_set_unit'
>drivers/scsi/scsidrv.o(.text+0x8109): undefined reference to
>`ahc_set_name'
>
>and so on.
>
>Excerpts from my .config file info:
>

I reverted the makefile in the aic directory to the 2.5.8 version and it 
builds.

Steve


