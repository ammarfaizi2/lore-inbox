Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750903AbWAaPcX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750903AbWAaPcX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Jan 2006 10:32:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750956AbWAaPcX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Jan 2006 10:32:23 -0500
Received: from uproxy.gmail.com ([66.249.92.202]:58990 "EHLO uproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750899AbWAaPcX convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Jan 2006 10:32:23 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=npOn3BB6lzB1YWUgEQgb+CdcmHGfR1/HebigM6TakBBzL9PpdSl0dx6J+D9XDzqTT4IAPohdF8lhXQW+70/CD9bveSmBl93z0w9LJYZOoK+zU+D8ozx8TN8FmO4OFxk960iRY/ACFavcPaJWmGxzZXON2bkd0nSU6FhciUi39tI=
Message-ID: <4615f4910601310732u79bd1427o9e34ced7baf860c8@mail.gmail.com>
Date: Tue, 31 Jan 2006 16:32:20 +0100
From: Beber <beber.lkml@gmail.com>
To: Con Kolivas <kernel@kolivas.org>
Subject: Re: 2.6.15-ck3
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>,
       ck list <ck@vds.kolivas.org>
In-Reply-To: <200601312319.20403.kernel@kolivas.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <200601312319.20403.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

A chance to have linux-ck under git ?

Beber

On 1/31/06, Con Kolivas <kernel@kolivas.org> wrote:
> These are patches designed to improve system responsiveness and interactivity.
> It is configurable to any workload but the default ck patch is aimed at the
> desktop and cks is available with more emphasis on serverspace.
>
> This includes all patches from 2.6.15.2 so use 2.6.15 as your base.
>
> Apply to 2.6.15
> http://ck.kolivas.org/patches/2.6/2.6.15/2.6.15-ck3/patch-2.6.15-ck3.bz2
>
> or server version
> http://ck.kolivas.org/patches/cks/patch-2.6.15-cks3.bz2
>
> web:
> http://kernel.kolivas.org
>
> all patches:
> http://ck.kolivas.org/patches/
>
> Split patches available.
>
>
> Changes
>
> Added:
>  +sched-staircase13.3_13.4.patch
> Staircase tweaks. Disable use of TASK_NONINTERACTIVE flag. It is not needed
> with staircase and just slows down things waiting on pipes.
>
>  +fix-scsi_cmd_cache_leak.patch
> Fix the scsi_cmd_cache slab leak
>
>
> Modified:
>  -mm-kswapd_inherit_prio.patch
>  +mm-kswapd_inherit_prio-1.patch
> A dud patch merge caused lousy performance once memory was full. This restores
> the patch to its proper state.
>
>  -patch-2.6.15.1.bz2
>  +patch-2.6.15.2.bz2
> Latest stable patch
>
> -2615ck2-version.patch
> +2615ck3-version.patch
> Version update
>
>
> Full patchlist:
>
> sched-staircase13.2.patch
> sched-staircase13.2_13.3.patch
> schedrange-1.diff
> schedbatch-2.11.diff
> sched-iso3.3.patch
> vmsplit-config_options.patch
> defaultcfq.diff
> isobatch_ionice2.diff
> rt_ionice.diff
> pdflush-tweaks.patch
> hz-default_values.patch
> hz-no_default_250.patch
> mm-swap_prefetch-19.patch
> vm-mapped.diff
> vm-lots_watermark.diff
> vm-background_scan-1.diff
> mm-kswapd_inherit_prio-1.patch
> mm-prio_dependant_scan.patch
> mm-batch_prio.patch
> 2.6.15-dynticks-060101.patch
> dynticks-disable_smp_config.patch
> dynticks-i386_only_config.patch
> fix-scsi_cmd_cache_leak.patch
> sched-staircase13.3_13.4.patch
> patch-2.6.15.2.bz2
> 2615ck3-version.patch
>
>
> Cheers,
> Con
>
>
>
