Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286171AbRLZI0t>; Wed, 26 Dec 2001 03:26:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286172AbRLZI0k>; Wed, 26 Dec 2001 03:26:40 -0500
Received: from smtp3.libero.it ([193.70.192.53]:43189 "EHLO smtp3.libero.it")
	by vger.kernel.org with ESMTP id <S286171AbRLZI0e>;
	Wed, 26 Dec 2001 03:26:34 -0500
Date: Wed, 26 Dec 2001 09:26:33 +0100
From: Luca Amigoni <al.net@libero.it>
To: linux-kernel@vger.kernel.org
Subject: Davicom DM910x (dfme) doesn't link
Message-ID: <20011226092633.A9287@mater.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
Content-Transfer-Encoding: 7BIT
X-Mailer: Balsa 1.2.3
X-Advice: Debian GNU/Linux user
X-Signature: Magis usu discantur quam scripto
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've tried to compile kernel version 2.4.17 with static dfme support,
but ld fails to link. Here is the error I get:

drivers/net/net.o(.data+0x434): undefined reference to `local symbols \
      in discarded section .text.exit'
make: *** [vmlinux] Error 1

Setting dfme as module is ok. Same problem with 2.4.16-pre1; I've found
references about a dfme problem in 2.4.7 kernel, but nothing for new
ones.

I've used gcc 2.95.4 and ld version 2.11.92.0.12.3.


Luca Amigoni
