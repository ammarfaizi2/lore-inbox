Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269354AbRIHNBp>; Sat, 8 Sep 2001 09:01:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269372AbRIHNBf>; Sat, 8 Sep 2001 09:01:35 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:54797 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S269354AbRIHNBb>; Sat, 8 Sep 2001 09:01:31 -0400
Subject: Re: 2.4.10-pre5
To: kingsley@wintronics.com.au (Kingsley Foreman)
Date: Sat, 8 Sep 2001 14:05:19 +0100 (BST)
Cc: linux-kernel@vger.kernel.org (linux-kernel)
In-Reply-To: <003001c1382d$f483d9d0$010da8c0@uglypunk> from "Kingsley Foreman" at Sep 08, 2001 03:44:31 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15fhnT-0003np-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> ferred-stack-boundary=2 -march=i586 -DMODULE   -c -o rd.o rd.c
> > rd.c: In function `rd_ioctl':
> > rd.c:262: invalid type argument of `->'
> > rd.c: In function `rd_cleanup':
> > rd.c:375: too few arguments to function `blkdev_put'

2.4.10pre5 doesnt compile for rd. It looks like the same error I got when 
I applied Al's patch to -ac (and thus took it back out)
