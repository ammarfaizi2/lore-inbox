Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751236AbVHLTO0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751236AbVHLTO0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Aug 2005 15:14:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751248AbVHLTO0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Aug 2005 15:14:26 -0400
Received: from linux01.gwdg.de ([134.76.13.21]:63901 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S1751236AbVHLTOZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Aug 2005 15:14:25 -0400
Date: Fri, 12 Aug 2005 21:14:20 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Shaun Jackman <sjackman@gmail.com>
cc: Jeff Garzik <jgarzik@pobox.com>, Tejun Heo <htejun@gmail.com>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: Trouble shooting a ten minute boot delay (SiI3112)
In-Reply-To: <7f45d93905081212087ea5910a@mail.gmail.com>
Message-ID: <Pine.LNX.4.61.0508122113510.16845@yvahk01.tjqt.qr>
References: <7f45d939050809163136a234a@mail.gmail.com>  <42FC0DD4.9060905@gmail.com>
  <7f45d93905081201001a51d51b@mail.gmail.com>  <42FC57EC.2060204@pobox.com>
  <7f45d93905081210441e209e31@mail.gmail.com>  <Pine.LNX.4.61.0508122039390.16845@yvahk01.tjqt.qr>
 <7f45d93905081212087ea5910a@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>I tried earlyprintk=vga, but it didn't provide any extra information.
>Although, CONFIG_EARLY_PRINTK is disabled in my .config. Does it need
>to be set to CONFIG_EARLY_PRINTK=y for earlyprintk=vga to work?

I think yes, otherwise there would not be a .config entry at all.

>I haven't tried Sysrq+T yet. I'll report back.

Mind that it is unlikely to get a good trace at this stage, but it's worth the 
try.


Jan Engelhardt
-- 
