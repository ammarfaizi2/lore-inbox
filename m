Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262260AbTDAKrE>; Tue, 1 Apr 2003 05:47:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262276AbTDAKrD>; Tue, 1 Apr 2003 05:47:03 -0500
Received: from mail.zmailer.org ([62.240.94.4]:15573 "EHLO mail.zmailer.org")
	by vger.kernel.org with ESMTP id <S262260AbTDAKrD>;
	Tue, 1 Apr 2003 05:47:03 -0500
Date: Tue, 1 Apr 2003 13:58:21 +0300
From: Matti Aarnio <matti.aarnio@zmailer.org>
To: shesha bhushan <bhushan_vadulas@hotmail.com>
Cc: linux-kernel@vger.kernel.org, kernelnewbies@nl.linux.org
Subject: Re: Deactivating TCP checksumming
Message-ID: <20030401105821.GV29167@mea-ext.zmailer.org>
References: <F28fCuayVxYPtqpymRi000013e5@hotmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <F28fCuayVxYPtqpymRi000013e5@hotmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 01, 2003 at 09:47:30AM +0000, shesha bhushan wrote:
> Hello all,
>  I am trying to de-activate the TCP checksumming and allow hardware (GBE to 
> compute it for me). But can any one let me know how to do it.

GBE ?  Likely device feature flags are wrong -- See examples
from   drivers/net/sunhme.c,  acenic.c,  tg3.c  for various ways
to use  NETIF_F_*_CSUM  feature flags.

For (some of) explanations:  include/linux/netdevice.h
(for NETIF_F_* flags)

> All suggestion are highly apperciated.
> 
> Thanking You
> Shesha

/Matti Aarnio
