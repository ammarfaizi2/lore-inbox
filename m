Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263186AbTC1Wvb>; Fri, 28 Mar 2003 17:51:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263190AbTC1Wvb>; Fri, 28 Mar 2003 17:51:31 -0500
Received: from [12.47.58.223] ([12.47.58.223]:9089 "EHLO
	pao-ex01.pao.digeo.com") by vger.kernel.org with ESMTP
	id <S263186AbTC1WvZ>; Fri, 28 Mar 2003 17:51:25 -0500
Date: Fri, 28 Mar 2003 15:02:34 -0800
From: Andrew Morton <akpm@digeo.com>
To: Andries Brouwer <aebr@win.tue.nl>
Cc: davej@codemonkey.org.uk, linux-kernel@vger.kernel.org, jgarzik@pobox.com,
       aeb@cwi.nl
Subject: Re: NICs trading places ?
Message-Id: <20030328150234.7f73d916.akpm@digeo.com>
In-Reply-To: <20030328224843.GA11980@win.tue.nl>
References: <20030328221037.GB25846@suse.de>
	<20030328224843.GA11980@win.tue.nl>
X-Mailer: Sylpheed version 0.8.10 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 28 Mar 2003 23:02:34.0993 (UTC) FILETIME=[1EB92610:01C2F57E]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andries Brouwer <aebr@win.tue.nl> wrote:
>
> Cause? eth discovery order is not well-defined.

It's a continual irritation.

> +	if (retval == 0) {
> +		int i;
> +		printk("%s: 3c59x, address", dev->name);
> +		for (i = 0; i < 6; i++)
> +			printk("%c%2.2x", i ? ':' : ' ', dev->dev_addr[i]);
> +		printk("\n");
>  		return 0;
> +	}

hm.  typing `ifconfig' shows this information.

