Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264895AbUFRBIB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264895AbUFRBIB (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Jun 2004 21:08:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264910AbUFRBIB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Jun 2004 21:08:01 -0400
Received: from rproxy.gmail.com ([64.233.170.192]:59888 "HELO mproxy.gmail.com")
	by vger.kernel.org with SMTP id S264895AbUFRBH5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Jun 2004 21:07:57 -0400
Message-ID: <77709e76040617180749cd1f09@mail.gmail.com>
Date: Thu, 17 Jun 2004 21:07:57 -0400
From: thinkliberty <thinkliberty@gmail.com>
To: 4Front Technologies <dev@opensound.com>
Subject: Re: Stop the Linux kernel madness
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <40D232AD.4020708@opensound.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <40D232AD.4020708@opensound.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Can't you just supply SUSE users with a new kernel RPM or patch that
you package to work with your program or kernel module?

It's not the best situation, but what other choice do you have? Other
companies do it.
See:
http://www.netraverse.com/member/downloads/kernel_download.php

On Thu, 17 Jun 2004 17:09:17 -0700, 4Front Technologies
<dev@opensound.com> wrote:
> 
> Hi Folks,
> 
> I am writing this message to bring a huge problem to light. SuSE has been systematically
> forking the linux kernel and shipping all kinds of modifications and still call their
> kernels 2.6.5 (for example).
> 
> Either they ship the stock Linux kernel sources or they stop calling their distributions
> as Linux-2.6.x based.
> 
> Kernel headers are being changed willy-nilly and SuSE are completely running rough-shod
> over the linux kernel with the result ONLY software from SuSE works.
> 
> Enclosed is a simple diff between SuSE's so-called Linux 2.6.5-7.75-bigsmp
> and the Linux 2.6.5 kernel sources from www.kernel.org:
> 
> Files linux-2.6.5/arch/i386/boot98/setup.S and linux-2.6.5-7.75/arch/i386/boot98/setup.S differ
> Files linux-2.6.5/arch/i386/defconfig and linux-2.6.5-7.75/arch/i386/defconfig differ
> Only in linux-2.6.5-7.75/arch/i386: defconfig.bigsmp
> Only in linux-2.6.5-7.75/arch/i386: defconfig.debug
> Only in linux-2.6.5-7.75/arch/i386: defconfig.default
> Only in linux-2.6.5-7.75/arch/i386: defconfig.smp
> Only in linux-2.6.5-7.75/arch/i386: defconfig.um
> 
> I would invite anybody to do a diff between the Linux 2.6.5 from kernel.org and
> SuSE 9.1's Linux 2.6.5 kernels.
> 
> This is absolutely not our problem and we don't know who to contact at SuSE to fix
> this problem. Our software works perfectly with Fedora/Debian/Gentoo/Mandrake/Redhat/etc.
> 
> I think SuSE's lying when they call their Linux kernel a 2.6.5 kernel when there are
> massive differences. They aren't even compatible with Linux 2.6.6.
> 
> I urge all those who have the power to sway distributions to immediately fix their
> kernels so that small developers like us don't have to keep updating our software.
> This is worse than Microsoft's practices.
> 
> best regards
> 
> Dev Mazumdar
> President
> ---------------------------------------------------------------------
> 4Front Technologies
> 4035 Lafayette Place, Unit F, Culver City, CA 90232, USA
> Tel: 310 202 8530   Fax: 310 202 0496   URL: http://www.opensound.com
> ---------------------------------------------------------------------
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
