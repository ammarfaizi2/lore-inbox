Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281682AbRLFRvg>; Thu, 6 Dec 2001 12:51:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281680AbRLFRvR>; Thu, 6 Dec 2001 12:51:17 -0500
Received: from smtp02.web.de ([217.72.192.151]:8222 "EHLO smtp.web.de")
	by vger.kernel.org with ESMTP id <S281690AbRLFRuw>;
	Thu, 6 Dec 2001 12:50:52 -0500
Date: Thu, 6 Dec 2001 18:54:06 +0100
From: =?ISO-8859-1?Q?Ren=E9?= Scharfe <l.s.r@web.de>
To: Marcelo Tosatti <marcelo@conectiva.com.br>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: "Michael H. Warfield" <mhw@commandcorp.com>
Subject: 2.4.17-pre2: unclean cleanup in i2ellis.c
Message-Id: <20011206185406.7873518d.l.s.r@web.de>
X-Mailer: Sylpheed version 0.6.1 (GTK+ 1.2.10; i586-mandrake-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

in 2.4.17-pre2 the definition of iiEllisCleanup() in
drivers/char/i2ellis.c got #if 0'd because it's unused. Problem is,
drivers/char/ip2main.c still calls this function in line 559.

René
