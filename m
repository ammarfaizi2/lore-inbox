Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932395AbVHIBMr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932395AbVHIBMr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Aug 2005 21:12:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932399AbVHIBMr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Aug 2005 21:12:47 -0400
Received: from rproxy.gmail.com ([64.233.170.197]:35275 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932395AbVHIBMq convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Aug 2005 21:12:46 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=YvogMOvELcMv8tid5Ooi+V4+h/e/FjmmIctLIPU/RfgMcuFXT+zzdqvflVMAjt8g9LD7BBKqCc56XnK0Htnv0Th+DH/6WXDdLmwz8UniKr1BSByBxiLabGaZUAdaxT4UzGsSLgkYRpLsD0+vDnieyKB4AXaclO6/AV1GVYafb8c=
Message-ID: <105c793f0508081812353a07d3@mail.gmail.com>
Date: Mon, 8 Aug 2005 21:12:45 -0400
From: Andrew Haninger <ahaning@gmail.com>
To: Adrian Bunk <bunk@stusta.de>
Subject: Re: Compiling module-init-tools versions after v3.0
Cc: Rusty Russell <rusty@rustcorp.com.au>,
       "Adam J. Richter" <adam@yggdrasil.com>,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>
In-Reply-To: <20050808223209.GL4006@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <105c793f050808150810784ef3@mail.gmail.com>
	 <20050808223209.GL4006@stusta.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/8/05, Adrian Bunk <bunk@stusta.de> wrote:
> Workaround:
> 
> Remove the
> 
>   man_MANS = $(MAN5) $(MAN8)
> 
> line in Makefile.in before running configure.

On 8/8/05, Ken Moffat <ken@kenmoffat.uklinux.net> wrote:
>  per LFS (http://www.linuxfromscratch.org/lfs/) make DOCBOOKTOMAN=""
> (or look at BLFS for the gory details of docbook)

Thank you both. Both of those workarounds seem to work for now.

> But this could be better handled in module-init-tools.
Here's hoping it will be once 3.2 is released.

Thanks again.

-Andy
