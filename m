Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315536AbSFEQnW>; Wed, 5 Jun 2002 12:43:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315547AbSFEQnV>; Wed, 5 Jun 2002 12:43:21 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:59631 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S315536AbSFEQnU>; Wed, 5 Jun 2002 12:43:20 -0400
Subject: Re: 2.5.20 i2c uses nonexistent linux/i2c-old.h
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Keith Owens <kaos@ocs.com.au>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20279.1023240470@kao2.melbourne.sgi.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 05 Jun 2002 18:35:45 +0100
Message-Id: <1023298545.2442.16.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2002-06-05 at 02:27, Keith Owens wrote:
> drivers/media/video/adv7175.c:#include <linux/i2c-old.h>
> drivers/media/video/bt819.c:#include <linux/i2c-old.h>
> drivers/media/video/bt856.c:#include <linux/i2c-old.h>
> drivers/media/video/i2c-parport.c:#include <linux/i2c-old.h>
> drivers/media/video/i2c-old.c:#include <linux/i2c-old.h>
> drivers/media/video/saa7110.c:#include <linux/i2c-old.h>
> drivers/media/video/saa7111.c:#include <linux/i2c-old.h>
> drivers/media/video/saa7185.c:#include <linux/i2c-old.h>
> drivers/media/video/zr36067.c:#include <linux/i2c-old.h>
> drivers/media/video/zr36120.h:#include <linux/i2c-old.h>
> 
> There is no file called i2c-old.h in 2.5.20.  These only build because
> they pick up i2c-old.h from /usr/include/linux :(.

i2c-old was back compatibility for obsolete code from 2.2 into 2.4. Its
dead its gone, and now folks need to go fix the drivers

