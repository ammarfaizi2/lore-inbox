Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317531AbSFEB2A>; Tue, 4 Jun 2002 21:28:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317532AbSFEB17>; Tue, 4 Jun 2002 21:27:59 -0400
Received: from zok.SGI.COM ([204.94.215.101]:31678 "EHLO zok.sgi.com")
	by vger.kernel.org with ESMTP id <S317531AbSFEB16>;
	Tue, 4 Jun 2002 21:27:58 -0400
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: linux-kernel@vger.kernel.org
Subject: 2.5.20 i2c uses nonexistent linux/i2c-old.h
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 05 Jun 2002 11:27:50 +1000
Message-ID: <20279.1023240470@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

drivers/media/video/adv7175.c:#include <linux/i2c-old.h>
drivers/media/video/bt819.c:#include <linux/i2c-old.h>
drivers/media/video/bt856.c:#include <linux/i2c-old.h>
drivers/media/video/i2c-parport.c:#include <linux/i2c-old.h>
drivers/media/video/i2c-old.c:#include <linux/i2c-old.h>
drivers/media/video/saa7110.c:#include <linux/i2c-old.h>
drivers/media/video/saa7111.c:#include <linux/i2c-old.h>
drivers/media/video/saa7185.c:#include <linux/i2c-old.h>
drivers/media/video/zr36067.c:#include <linux/i2c-old.h>
drivers/media/video/zr36120.h:#include <linux/i2c-old.h>

There is no file called i2c-old.h in 2.5.20.  These only build because
they pick up i2c-old.h from /usr/include/linux :(.

