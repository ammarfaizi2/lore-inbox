Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314284AbSG2J6U>; Mon, 29 Jul 2002 05:58:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314325AbSG2J6U>; Mon, 29 Jul 2002 05:58:20 -0400
Received: from [195.63.194.11] ([195.63.194.11]:63757 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S314284AbSG2J6T>; Mon, 29 Jul 2002 05:58:19 -0400
Message-ID: <3D45114F.5060704@evision.ag>
Date: Mon, 29 Jul 2002 11:56:31 +0200
From: Marcin Dalecki <dalecki@evision.ag>
Reply-To: martin@dalecki.de
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1b) Gecko/20020722
X-Accept-Language: en-us, en, pl, ru
MIME-Version: 1.0
To: Art Haas <ahaas@neosoft.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] warning fix for ide.h
References: <20020727170246.GA22926@debian>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Art Haas wrote:
> Hi.
> 
> I saw this when building 2.5.29 ...
> 
> make[2]: Entering directory `/mnt/src/linux-2.5.29/drivers/ide'
> gcc -Wp,-MD,./.ide-cd.o.d -D__KERNEL__ -I/mnt/src/linux-2.5.29/include
> -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer
> -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2
> -march=i586 -nostdinc -iwithprefix include -DMODULE
> -DKBUILD_BASENAME=ide_cd   -c -o ide-cd.o ide-cd.c
> ide-cd.c: In function `ide_cdrom_do_request':
> ide-cd.c:1623: warning: implicit declaration of function `ide_stall_queue'
> 
> Adding a prototype to ide.h removes the warning.

Please don't bother - this function is subject to go.

