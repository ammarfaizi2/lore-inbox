Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262529AbTIHOtx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Sep 2003 10:49:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262541AbTIHOtx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Sep 2003 10:49:53 -0400
Received: from paiol.terra.com.br ([200.176.3.18]:59603 "EHLO
	paiol.terra.com.br") by vger.kernel.org with ESMTP id S262529AbTIHOtw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Sep 2003 10:49:52 -0400
Message-ID: <3F5C9706.7030809@terra.com.br>
Date: Mon, 08 Sep 2003 11:49:42 -0300
From: Marcelo Abreu <skewer@terra.com.br>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030624
X-Accept-Language: pt-br, en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Cc: Ottavio Campana <ottavio@campana.vi.it>
Subject: Re: linux 2.4.22 compile error
References: <20030908084036.GA30850@campana.vi.it>
In-Reply-To: <20030908084036.GA30850@campana.vi.it>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ottavio Campana wrote:
> I just downloaded  linux 2.4.22 and applied the  following patches: xfs,
> i2c 2.8.0 and lm_sensors 2.8.0 .
> 
> The kernel is failing to compile, here's the error:
> 
> gcc -D__KERNEL__ -I/usr/src/linux-2.4.22/include -Wall -Wstrict-prototypes 
> -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -fomit-frame-pointer 
> -pipe -mpreferred-stack-boundary=2 -march=i686 -malign-functions=4 
> -DMODULE -DMODVERSIONS -include /usr/src/linux-2.4.22/include/linux/modversions.h
> -nostdinc -iwithprefix include -DKBUILD_BASENAME=bttv_if  -DEXPORT_SYMTAB 
> -c bttv-if.c
> bttv-if.c:244: unknown field `inc_use' specified in initializer
> bttv-if.c:244: warning: initialization from incompatible pointer type
> ...

	I think you need the patches available here:

	http://www.ensicaen.ismra.fr/~delvare/devel/i2c/

	...and maybe you should get i2c from CVS.


	Marcelo



