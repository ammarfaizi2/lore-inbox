Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131275AbRDPQPZ>; Mon, 16 Apr 2001 12:15:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131289AbRDPQPO>; Mon, 16 Apr 2001 12:15:14 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:7178 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S131275AbRDPQPB>; Mon, 16 Apr 2001 12:15:01 -0400
Subject: Re: Linux 2.4.3-ac7
To: ksi@cyberbills.com (Sergey Kubushin)
Date: Mon, 16 Apr 2001 17:16:58 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.31ksi3.0104160910330.20561-100000@nomad.cyberbills.com> from "Sergey Kubushin" at Apr 16, 2001 09:12:00 AM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14pBgV-0000Vy-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> gcc -D__KERNEL__ -I/tmp/build-kernel/usr/src/linux-2.4.3ac7/include -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer -fno-strict-aliasing -pipe -mpreferred-stack-boundary=2 -march=i586 -DMODULE -DMODVERSIONS -include /tmp/build-kernel/usr/src/linux-2.4.3ac7/include/linux/modversions.h   -c -o cycx_x25.o cycx_x25.c
> cycx_x25.c: In function `new_if':
> cycx_x25.c:364: structure has no member named `port'

Fixed in my working tree. The Sangoma patch Linus merged accidentally backed out
support for a competing product.
