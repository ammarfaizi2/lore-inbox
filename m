Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272373AbRIFBlf>; Wed, 5 Sep 2001 21:41:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272374AbRIFBlZ>; Wed, 5 Sep 2001 21:41:25 -0400
Received: from rj.SGI.COM ([204.94.215.100]:56536 "EHLO rj.sgi.com")
	by vger.kernel.org with ESMTP id <S272373AbRIFBlP>;
	Wed, 5 Sep 2001 21:41:15 -0400
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: Samium Gromoff <_deepfire@mail.ru>
Cc: linux-kernel@vger.kernel.org, alan@lxorguk.ukuu.org.uk
Subject: Re: more fruits, though not probably fresh 
In-Reply-To: Your message of "Thu, 06 Sep 2001 03:02:11 GMT."
             <200109060302.f8632BP02164@vegae.deep.net> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 06 Sep 2001 11:40:45 +1000
Message-ID: <6739.999740445@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 6 Sep 2001 03:02:11 +0000 (UTC), 
Samium Gromoff <_deepfire@mail.ru> wrote:
>make[4]: Entering directory `/usr/src/linux-stest/drivers/scsi/aic7xxx/aicasm'
>*** Install db development libraries
>gcc -I/usr/include -I. -ldb aicasm_gram.c aicasm_scan.c aicasm.c aicasm_symbol.c -o aicasm
>aicasm_symbol.c:39: aicdb.h: No such file or directory

Turn off CONFIG_AIC7XXX_BUILD_FIRMWARE, you do not have the required
libraries.

