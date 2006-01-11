Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750813AbWAKVhO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750813AbWAKVhO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jan 2006 16:37:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750826AbWAKVhO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jan 2006 16:37:14 -0500
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:35789
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1750825AbWAKVhM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jan 2006 16:37:12 -0500
Date: Wed, 11 Jan 2006 13:37:18 -0800 (PST)
Message-Id: <20060111.133718.132876106.davem@davemloft.net>
To: cate@debian.org
Cc: linux-kernel@vger.kernel.org
Subject: Re: linker error in 2.6.15-git:
 drivers/media/video/tuner.o:(.bss+0x0): multiple definition of `debug'
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <43C57875.3080404@debian.org>
References: <43C57875.3080404@debian.org>
X-Mailer: Mew version 4.2.53 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Giacomo A. Catenazzi" <cate@debian.org>
Date: Wed, 11 Jan 2006 22:28:21 +0100

> drivers/media/video/tuner.o:(.bss+0x0): multiple definition of `debug'
> drivers/media/video/msp3400.o:(.bss+0x0): first defined here
> drivers/media/video/cx25840/built-in.o:(.bss+0x0): multiple definition 
> of `debug'
> drivers/media/video/msp3400.o:(.bss+0x0): first defined here

I just hit this as well, "make allyesconfig" is enough to trigger
it.
