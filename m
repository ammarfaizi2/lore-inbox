Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261724AbTBFBDf>; Wed, 5 Feb 2003 20:03:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261701AbTBFBDf>; Wed, 5 Feb 2003 20:03:35 -0500
Received: from node181b.a2000.nl ([62.108.24.27]:644 "EHLO ddx.a2000.nu")
	by vger.kernel.org with ESMTP id <S261523AbTBFBDc>;
	Wed, 5 Feb 2003 20:03:32 -0500
Date: Thu, 6 Feb 2003 02:13:36 +0100 (CET)
From: Stephan van Hienen <raid@a2000.nu>
To: linux-raid@vger.kernel.org, Peter Chubb <peter@chubb.wattle.id.au>
cc: linux-kernel@vger.kernel.org
Subject: Re: 15 * 180gb in raid5 gives 299.49 GiB ?
In-Reply-To: <Pine.LNX.4.53.0302060123150.6169@ddx.a2000.nu>
Message-ID: <Pine.LNX.4.53.0302060211030.6169@ddx.a2000.nu>
References: <Pine.LNX.4.53.0302060059210.6169@ddx.a2000.nu>
 <Pine.LNX.4.53.0302060123150.6169@ddx.a2000.nu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

argh :

tried to compile with this patch
tried on 2.4.20 , 2.4.21-pre1 and 2.4.21-pre4

        /usr/src/linux-2.4.21-pre1/arch/i386/lib/lib.a
/usr/src/linux-2.4.21-pre1/lib/lib.a
/usr/src/linux-2.4.21-pre1/arch/i386/lib/lib.a \
        --end-group \
        -o vmlinux
drivers/scsi/scsidrv.o: In function `ahc_linux_biosparam':
drivers/scsi/scsidrv.o(.text+0xf9c4): undefined reference to `__udivdi3'
drivers/scsi/scsidrv.o(.text+0xfa0c): undefined reference to `__udivdi3'





On Thu, 6 Feb 2003, Stephan van Hienen wrote:

> hmms found out after posting this msg :
>
> http://www.gelato.unsw.edu.au/patches-index.html
>
>   ³ ³ [*] Support for discs bigger than 2TB?  ³ ³
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-raid" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
