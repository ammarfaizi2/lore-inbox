Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265541AbSKKFKK>; Mon, 11 Nov 2002 00:10:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265537AbSKKFKK>; Mon, 11 Nov 2002 00:10:10 -0500
Received: from pointblue.com.pl ([62.121.131.135]:58122 "EHLO pointblue.com.pl")
	by vger.kernel.org with ESMTP id <S265541AbSKKFKJ>;
	Mon, 11 Nov 2002 00:10:09 -0500
Subject: second error, bttv 2.5.47
From: Grzegorz Jaskiewicz <gj@pointblue.com.pl>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.5 
Date: 11 Nov 2002 05:03:15 +0000
Message-Id: <1036990995.24251.7.camel@flat41>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Sorry, it's not saa 7146 this time:

drivers/media/video/bttv-cards.c: In function `miro_pinnacle_gpio':
drivers/media/video/bttv-cards.c:1742: `AUDC_CONFIG_PINNACLE' undeclared
(first use in this function)


root@flat41:/usr/src/linux-2.5.47# fgrep -r AUDC_CONFIG_PINNACLE *
drivers/media/video/bttv-cards.c:              
bttv_call_i2c_clients(btv,AUDC_CONFIG_PINNACLE,&id);
root@flat41:/usr/src/linux-2.5.47#

I'll try to fix those my self, but i want to let you know anyway.


--
Greg Iaskievitch

