Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132166AbRCVT7H>; Thu, 22 Mar 2001 14:59:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132176AbRCVT65>; Thu, 22 Mar 2001 14:58:57 -0500
Received: from newscon07-ext.news.prodigy.com ([207.115.63.147]:4 "EHLO
	newscon07.news.prodigy.com") by vger.kernel.org with ESMTP
	id <S132166AbRCVT6o>; Thu, 22 Mar 2001 14:58:44 -0500
Date: Thu, 22 Mar 2001 14:57:58 -0500 (EST)
From: Owner of NEWS <root@prodigy.com>
Reply-To: Usenet News Admin <news@prodigy.net>
To: <linux-kernel@vger.kernel.org>
Subject: pcnet32 broken in 2.4.3-pre6
Message-ID: <Pine.LNX.4.30.0103221456130.15606-100000@newscon07.news.prodigy.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On modules_install:

cd /lib/modules/2.4.3-pre6; \
mkdir -p pcmcia; \
find kernel -path '*/pcmcia/*' -name '*.o' | xargs -i -r ln -sf ../{}
pcmcia
if [ -r System.map ]; then /sbin/depmod -ae -F System.map  2.4.3-pre6; fi
depmod: *** Unresolved symbols in
/lib/modules/2.4.3-pre6/kernel/drivers/net/pcnet32.o
depmod:         is_valid_ether_addr


Note: if you need more info, use davidsen@tmr.com

