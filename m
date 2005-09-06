Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750891AbVIFUbw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750891AbVIFUbw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Sep 2005 16:31:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750892AbVIFUbw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Sep 2005 16:31:52 -0400
Received: from st.cuni.cz ([195.113.20.8]:13757 "EHLO ss1000.ms.mff.cuni.cz")
	by vger.kernel.org with ESMTP id S1750890AbVIFUbv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Sep 2005 16:31:51 -0400
Date: Tue, 6 Sep 2005 22:31:39 +0200
From: Rudo Thomas <rudo@matfyz.cz>
To: Adam Petaccia <adam@tpetaccia.com>
Cc: Con Kolivas <kernel@kolivas.org>, ck list <ck@vds.kolivas.org>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.13-ck2
Message-ID: <20050906203139.GB10282@ss1000.ms.mff.cuni.cz>
Mail-Followup-To: Adam Petaccia <adam@tpetaccia.com>,
	Con Kolivas <kernel@kolivas.org>, ck list <ck@vds.kolivas.org>,
	linux kernel mailing list <linux-kernel@vger.kernel.org>
References: <200509052344.11665.kernel@kolivas.org> <1126031157.8117.5.camel@pimpmobile>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1126031157.8117.5.camel@pimpmobile>
User-Agent: Mutt/1.5.7i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I think this patch is missing an IFDEF or something (I'm not really a
> programmer, I just like to pretend).  Anyway, I've tried building -ck2
> without swap enabled, and it failed.  Just to make sure, I make'd
> distclean, and I get the following:
> 
>   LD      .tmp_vmlinux1
> mm/built-in.o: In function `zone_watermark_ok':
> mm/page_alloc.c:763: undefined reference to `delay_prefetch'
> mm/built-in.o: In function `swap_setup':
> mm/swap.c:485: undefined reference to `prepare_prefetch'
> make: *** [.tmp_vmlinux1] Error 1

Maybe the mistake will be obvious to the autor (Con:), but it would be
helpful if you included .config from the kernel directory.

Rudo.
