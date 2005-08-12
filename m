Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750914AbVHLSkM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750914AbVHLSkM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Aug 2005 14:40:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750916AbVHLSkM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Aug 2005 14:40:12 -0400
Received: from linux01.gwdg.de ([134.76.13.21]:8641 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S1750914AbVHLSkL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Aug 2005 14:40:11 -0400
Date: Fri, 12 Aug 2005 20:39:59 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Shaun Jackman <sjackman@gmail.com>
cc: Jeff Garzik <jgarzik@pobox.com>, Tejun Heo <htejun@gmail.com>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: Trouble shooting a ten minute boot delay (SiI3112)
In-Reply-To: <7f45d93905081210441e209e31@mail.gmail.com>
Message-ID: <Pine.LNX.4.61.0508122039390.16845@yvahk01.tjqt.qr>
References: <7f45d939050809163136a234a@mail.gmail.com>  <42FC0DD4.9060905@gmail.com>
  <7f45d93905081201001a51d51b@mail.gmail.com>  <42FC57EC.2060204@pobox.com>
 <7f45d93905081210441e209e31@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>Thanks for the hint. I tried edd=off but sadly the boot delay
>persists. It looks as though edd was already disabled, as my .config
>contains CONFIG_EDD=m and the edd module is not loaded. If it helps
>troubleshooting I can post my .config here.

Maybe you can get something using EARLY_PRINTK and/or Sysrq+T?


Jan Engelhardt
-- 
