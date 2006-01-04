Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965012AbWADGCU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965012AbWADGCU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jan 2006 01:02:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965191AbWADGCU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jan 2006 01:02:20 -0500
Received: from nproxy.gmail.com ([64.233.182.204]:7866 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S965012AbWADGCT convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jan 2006 01:02:19 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=lP+g2Cbt0SvWEMRgVHE3pcny9iPwtvhcGRGUu9vlk/E/1Bc19CJXPDp2TL94uTEQgTAI+u7FMV2DOMH58a5/1rB5bYfL3wZTqyTTZAByDUvNeMTQaNFAEsv8Rn5rcWpvkWCnz9HkMBHCtc4oXOdResfuUcX/m/Xe+MJdfyTDmfk=
Message-ID: <2cd57c900601032202y3de62e78m@mail.gmail.com>
Date: Wed, 4 Jan 2006 14:02:18 +0800
From: Coywolf Qi Hunt <coywolf@gmail.com>
To: "Ed L. Cashin" <ecashin@coraid.com>
Subject: Re: [PATCH 2.6.15-rc7] aoe [4/7]: use less confusing driver name
Cc: linux-kernel@vger.kernel.org, Greg K-H <greg@kroah.com>
In-Reply-To: <871wzp10lm.fsf@coraid.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <87hd8l2fb4.fsf@coraid.com> <871wzp10lm.fsf@coraid.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2006/1/4, Ed L. Cashin <ecashin@coraid.com>:
> Signed-off-by: "Ed L. Cashin" <ecashin@coraid.com>
>
> Users were confused by the driver being called "aoe-2.6-$version".
> This form looks less like a Linux kernel version number.
>
> Index: 2.6.15-rc7-aoe/drivers/block/aoe/aoemain.c
> ===================================================================
> --- 2.6.15-rc7-aoe.orig/drivers/block/aoe/aoemain.c     2006-01-02 13:35:13.000000000 -0500
> +++ 2.6.15-rc7-aoe/drivers/block/aoe/aoemain.c  2006-01-02 13:35:14.000000000 -0500
> @@ -89,7 +89,7 @@
>         }
>
>         printk(KERN_INFO
> -              "aoe: aoe_init: AoE v2.6-%s initialised.\n",
> +              "aoe: aoe_init: aoe6-%s initialised.\n",
>                VERSION);

Better simply be `AoE v%s'?

>         discover_timer(TINIT);
>         return 0;
>
>
--
Coywolf Qi Hunt
