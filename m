Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751280AbWESJPt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751280AbWESJPt (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 May 2006 05:15:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751271AbWESJPt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 May 2006 05:15:49 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:60427 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1751258AbWESJPt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 May 2006 05:15:49 -0400
Date: Fri, 19 May 2006 11:15:47 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Penshoppe Estrada <penshoppe@linuxmail.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Kernel compile Error
Message-ID: <20060519091547.GA10077@stusta.de>
References: <20060519074536.95542CA0A4@ws5-11.us4.outblaze.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060519074536.95542CA0A4@ws5-11.us4.outblaze.com>
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 19, 2006 at 03:45:36PM +0800, Penshoppe Estrada wrote:
> Hello,
> 
> Good Day!
> 
> Anyone could help me with this error. Thanks in advance.
> 
> 
>   CC      net/netfilter/xt_string.o
>   CC      net/netfilter/xt_tcpmss.o
>   LD      net/netfilter/built-in.o
>   CC      net/netlink/af_netlink.o
> net/netlink/af_netlink.c: In function `netlink_release':
> net/netlink/af_netlink.c:472: error: structure has no member named `protinfo'
> net/netlink/af_netlink.c:472: error: structure has no member named `protinfo'
> net/netlink/af_netlink.c:473: error: structure has no member named `protocol'
> net/netlink/af_netlink.c:474: error: structure has no member named `protinfo'
>...
> [root@ja linux-2.6.16]#
>...

You seem to have a corrupted source tree.

Please try with a fresh linux-2.6.16.16.tar.gz from ftp.kernel.org 
without any additional patches applied.

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

