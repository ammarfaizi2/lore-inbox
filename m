Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261723AbUC1NDS (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Mar 2004 08:03:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261744AbUC1NDS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Mar 2004 08:03:18 -0500
Received: from uslink-66.173.43-133.uslink.net ([66.173.43.133]:56468 "EHLO
	dingdong.cryptoapps.com") by vger.kernel.org with ESMTP
	id S261723AbUC1NDR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Mar 2004 08:03:17 -0500
Date: Sun, 28 Mar 2004 05:03:17 -0800
From: Chris Wedgwood <cw@f00f.org>
To: Willy TARREAU <willy@w.ods.org>
Cc: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       linux-kernel@vger.kernel.org, chas@cmf.nrl.navy.mil
Subject: Re: [PATCH-2.4.26] ATM cleanup
Message-ID: <20040328130317.GA8775@dingdong.cryptoapps.com>
References: <20040328042608.GA17969@logos.cnet> <20040328125852.GH24421@pcw.home.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040328125852.GH24421@pcw.home.local>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 28, 2004 at 02:58:52PM +0200, Willy TARREAU wrote:

> +++ ./net/atm/mpoa_proc.c	Sun Mar 28 14:52:34 2004
> @@ -102,7 +102,7 @@
>  			     size_t count, loff_t *pos){
>          unsigned long page = 0;
>  	unsigned char *temp;
> -        ssize_t length  = 0;
> +        int length  = 0;
>  	int i = 0;
>  	struct mpoa_client *mpc = mpcs;
>  	in_cache_entry *in_entry;

no tabs?


   --cw
