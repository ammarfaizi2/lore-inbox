Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262646AbSJIXAA>; Wed, 9 Oct 2002 19:00:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262648AbSJIW77>; Wed, 9 Oct 2002 18:59:59 -0400
Received: from pc1-cwma1-5-cust42.swa.cable.ntl.com ([80.5.120.42]:36520 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S262646AbSJIW77>; Wed, 9 Oct 2002 18:59:59 -0400
Subject: Re: Unresolved symbols in ext2/ext3/i2c-elektor in 2.5.41-ac2
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Gregoire Favre <greg@ulima.unil.ch>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20021009211102.GA11645@ulima.unil.ch>
References: <20021009211102.GA11645@ulima.unil.ch>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 10 Oct 2002 00:16:26 +0100
Message-Id: <1034205386.2065.103.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2002-10-09 at 22:11, Gregoire Favre wrote:
> Hello,
> 
> if [ -r System.map ]; then /sbin/depmod -ae -F System.map  2.5.41-ac2;fi
> depmod: *** Unresolved symbols in
> /lib/modules/2.5.41-ac2/kernel/drivers/i2c/i2c-elektor.o
> depmod: 	cli
> depmod: 	sti

This driver has yet to be fixed for 2.5

> depmod: *** Unresolved symbols in
> /lib/modules/2.5.41-ac2/kernel/fs/ext2/ext2.o
> depmod: 	generic_file_aio_read
> depmod: 	generic_file_aio_write
> depmod: *** Unresolved symbols in
> /lib/modules/2.5.41-ac2/kernel/fs/ext3/ext3.o
> depmod: 	do_sync_read
> depmod: 	generic_file_aio_read
> depmod: 	generic_file_aio_write
> depmod: 	do_sync_write

These I will look into tomorrow given time

