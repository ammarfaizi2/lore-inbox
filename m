Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265532AbTABElp>; Wed, 1 Jan 2003 23:41:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265541AbTABElp>; Wed, 1 Jan 2003 23:41:45 -0500
Received: from air-2.osdl.org ([65.172.181.6]:8843 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S265532AbTABElo>;
	Wed, 1 Jan 2003 23:41:44 -0500
Date: Wed, 1 Jan 2003 20:47:26 -0800 (PST)
From: "Randy.Dunlap" <rddunlap@osdl.org>
X-X-Sender: <rddunlap@dragon.pdx.osdl.net>
To: David Parrish <david@dparrish.com>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.53 compile error
In-Reply-To: <20030102044543.GA13786@david.optusnet.com.au>
Message-ID: <Pine.LNX.4.33L2.0301012046230.21318-100000@dragon.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2 Jan 2003, David Parrish wrote:

| Hi there!
|
| I'm trying to compile 2.5.53, getting the following error:
|
| drivers/media/video/bttv-cards.c: In function `miro_pinnacle_gpio':
| drivers/media/video/bttv-cards.c:1742: `AUDC_CONFIG_PINNACLE' undeclared (first use in this function)
| drivers/media/video/bttv-cards.c:1742: (Each undeclared identifier is reported only once
| drivers/media/video/bttv-cards.c:1742: for each function it appears in.)
| make[3]: *** [drivers/media/video/bttv-cards.o] Error 1
| make[2]: *** [drivers/media/video] Error 2
| make[1]: *** [drivers/media] Error 2
| make: *** [drivers] Error 2
|
|
| david:/usr/src/linux-2.5.53# grep -r AUDC_CONFIG_PINNACLE *
| drivers/media/video/bttv-cards.c:               bttv_call_i2c_clients(btv,AUDC_CONFIG_PINNACLE,&id);
|
| Turning off BT848 support fixes this.

Yes, this is old news.  :(
Patches for media/video/ are available at
  http://bytesex.org/patches/2.5/

-- 
~Randy

