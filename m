Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261609AbUKWXCk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261609AbUKWXCk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Nov 2004 18:02:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261620AbUKWXCf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Nov 2004 18:02:35 -0500
Received: from viper.oldcity.dca.net ([216.158.38.4]:51161 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S261610AbUKWXCN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Nov 2004 18:02:13 -0500
Subject: Re: bug in mm/slab.c
From: Lee Revell <rlrevell@joe-job.com>
To: celeron2002@chile.com
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <34591.200.113.104.46.1101247993.squirrel@mail.chile.com>
References: <34591.200.113.104.46.1101247993.squirrel@mail.chile.com>
Content-Type: text/plain
Date: Tue, 23 Nov 2004 18:02:08 -0500
Message-Id: <1101250929.5207.1.camel@krustophenia.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-11-23 at 19:13 -0300, celeron2002@chile.com wrote:
> Problem with chipset nforce in the boot
> Kernel 2.6.9-final in archlinux ( www.archlinux.org ) but compiled by myself.
> 
> nvidia: module license 'NVIDIA' taints kernel.
> ACPI: PCI interrupt 0000:02:00.0[A] -> GSI 11 (level, low) -> IRQ 11
> NVRM: loading NVIDIA Linux x86 NVIDIA Kernel Module  1.0-6111  Tue Jul 27
> 07:55:38 PDT 2004
> kmem_cache_create: duplicate cache sgpool-8
> ------------[ cut here ]------------
> kernel BUG at mm/slab.c:1442!


Not only do you have the nvidia module loaded, but it looks like the
nvidia module caused your oops.

Did you see the line about 'module license NVIDIA taints kernel'?
Google for what this means and you will understand why this bug report
is offtopic.

Lee


