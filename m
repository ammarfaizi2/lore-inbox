Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316192AbSETSah>; Mon, 20 May 2002 14:30:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316194AbSETSag>; Mon, 20 May 2002 14:30:36 -0400
Received: from smtp-out-2.wanadoo.fr ([193.252.19.254]:35749 "EHLO
	mel-rto2.wanadoo.fr") by vger.kernel.org with ESMTP
	id <S316192AbSETSag>; Mon, 20 May 2002 14:30:36 -0400
Message-ID: <3CE94096.3020205@wanadoo.fr>
Date: Mon, 20 May 2002 20:29:42 +0200
From: Pierre Rousselet <pierre.rousselet@wanadoo.fr>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0rc2) Gecko/20020510
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
CC: Martin Dalecki <dalecki@evision-ventures.com>,
        linux-kernel@vger.kernel.org
Subject: Re: HPT366 hangs up at boot
In-Reply-To: <87adquda7b.fsf@devron.myhome.or.jp>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

OGAWA Hirofumi wrote:
> diff -u /home/hirofumi/hpt366.c.orig /home/hirofumi/hpt366.c
> --- /home/hirofumi/hpt366.c.orig	Tue May 21 01:48:58 2002
> +++ /home/hirofumi/hpt366.c	Tue May 21 01:49:28 2002
> @@ -863,7 +863,7 @@
>  	byte ultra66		= eighty_ninty_three(drive);
>  	int  rval;
>  
> -	config_chipset_for_pio(drive);
> +//	config_chipset_for_pio(drive);
>  	drive->init_speed = 0;
>  
>  	if ((drive->type != ATA_DISK) && (speed < XFER_SW_DMA_0))

I just want to confirmed it allows 2.5.16 to boot on the BE6. DMA bios 
settings are correctly reported.

Pierre
-- 
------------------------------------------------
  Pierre Rousselet <pierre.rousselet@wanadoo.fr>
------------------------------------------------

