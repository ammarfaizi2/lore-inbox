Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261675AbVGDNIv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261675AbVGDNIv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Jul 2005 09:08:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261668AbVGDNIv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Jul 2005 09:08:51 -0400
Received: from gate.nucleusys.com ([217.79.38.164]:62336 "EHLO
	zztop.nucleusys.com") by vger.kernel.org with ESMTP id S261685AbVGDNE6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Jul 2005 09:04:58 -0400
Date: Mon, 4 Jul 2005 16:04:36 +0300 (EEST)
From: Petko Manolov <petkan@nucleusys.com>
To: Adrian Bunk <bunk@stusta.de>
cc: petkan@users.sourceforge.net, linux-usb-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] drivers/usb/net/: remove two unused multicast_filter_limit
 variables
In-Reply-To: <20050702215431.GG5346@stusta.de>
Message-ID: <Pine.LNX.4.63.0507041604230.1950@bender.nucleusys.com>
References: <20050702215431.GG5346@stusta.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ok, looks all right to me.


 		Petko



On Sat, 2 Jul 2005, Adrian Bunk wrote:

> The only uses of both variables were recently removed.
>
> Signed-off-by: Adrian Bunk <bunk@stusta.de>
>
> ---
>
> drivers/usb/net/pegasus.c |    1 -
> drivers/usb/net/rtl8150.c |    2 --
> 2 files changed, 3 deletions(-)
>
> --- linux-2.6.13-rc1-mm1-full/drivers/usb/net/pegasus.c.old	2005-07-02 22:44:10.000000000 +0200
> +++ linux-2.6.13-rc1-mm1-full/drivers/usb/net/pegasus.c	2005-07-02 22:44:19.000000000 +0200
> @@ -59,7 +59,6 @@
>
> static int loopback = 0;
> static int mii_mode = 0;
> -static int multicast_filter_limit = 32;
>
> static struct usb_eth_dev usb_dev_id[] = {
> #define	PEGASUS_DEV(pn, vid, pid, flags)	\
> --- linux-2.6.13-rc1-mm1-full/drivers/usb/net/rtl8150.c.old	2005-07-02 22:44:31.000000000 +0200
> +++ linux-2.6.13-rc1-mm1-full/drivers/usb/net/rtl8150.c	2005-07-02 22:44:35.000000000 +0200
> @@ -167,8 +167,6 @@
>
> typedef struct rtl8150 rtl8150_t;
>
> -static unsigned long multicast_filter_limit = 32;
> -
> static void fill_skb_pool(rtl8150_t *);
> static void free_skb_pool(rtl8150_t *);
> static inline struct sk_buff *pull_skb(rtl8150_t *);
>
>
