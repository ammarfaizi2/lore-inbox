Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263941AbTKJQdW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Nov 2003 11:33:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263950AbTKJQdW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Nov 2003 11:33:22 -0500
Received: from mail.g-housing.de ([62.75.136.201]:60899 "EHLO mail.g-house.de")
	by vger.kernel.org with ESMTP id S263941AbTKJQdU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Nov 2003 11:33:20 -0500
Message-ID: <3FAFAFBC.2090202@g-house.de>
Date: Mon, 10 Nov 2003 16:33:16 +0100
From: Christian <evil@g-house.de>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.5) Gecko/20030924 Thunderbird/0.3
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Stan Benoit <sab7@mail.ptd.net>
CC: linux-kernel@vger.kernel.org
Subject: Re: sparc 20 problem ver test9
References: <20031110083716.A32096@mail.ptd.net>
In-Reply-To: <20031110083716.A32096@mail.ptd.net>
X-Enigmail-Version: 0.81.7.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stan Benoit wrote:
[...]
> include/asm/hardirq.h: In function `release_irqlock':
> include/asm/hardirq.h:147: warning: implicit declaration of function `br_write_unlock'
> include/asm/hardirq.h:147: `BR_GLOBALIRQ_LOCK' undeclared (first use in this function)
> In file included from init/main.c:33:
> include/linux/kernel_stat.h: In function `kstat_irqs':
> include/linux/kernel_stat.h:47: warning: implicit declaration of function `cpu_possible'
> make[1]: *** [init/main.o] Error 1
> make: *** [init] Error 2
> 
> shouldn't this be pointing to:
> 
> include/asm-sparc/hardirg.h  ???

it does not? for ppc it gives:

/usr/src/linux-2.6/include/asm -> asm-ppc

so if ./asm is not ./asm-sparc on your machine, something *is* wrong....


Christian.
-- 
BOFH excuse #213:

Change your language to Finnish.

