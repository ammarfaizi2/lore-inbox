Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750919AbWISSnV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750919AbWISSnV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Sep 2006 14:43:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750995AbWISSnV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Sep 2006 14:43:21 -0400
Received: from 1wt.eu ([62.212.114.60]:2579 "EHLO 1wt.eu") by vger.kernel.org
	with ESMTP id S1750858AbWISSnU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Sep 2006 14:43:20 -0400
Date: Tue, 19 Sep 2006 20:26:38 +0200
From: Willy Tarreau <w@1wt.eu>
To: David Miller <davem@davemloft.net>
Cc: DJurzitza@harmanbecker.com, linux-kernel@vger.kernel.org,
       sparclinux@vger.kernel.org
Subject: Re: Patch 2.4 kernel / allow to read more than 2048 (1821) Symbols from /boot/System.map
Message-ID: <20060919182638.GD3467@1wt.eu>
References: <DA6197CAE190A847B662079EF7631C06015692C9@OEKAW2EXVS03.hbi.ad.harman.com> <20060917.223512.25476592.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060917.223512.25476592.davem@davemloft.net>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi David,

On Sun, Sep 17, 2006 at 10:35:12PM -0700, David Miller wrote:
> From: "Jurzitza, Dieter" <DJurzitza@harmanbecker.com>
> Date: Mon, 18 Sep 2006 07:23:58 +0200
> 
> > The 2.4 kernel series uses sys32_get_kernel_syms(struct kernel_sym32
> > *table) for reading the kernel symbols (on sparc64). The size of
> > struct kernel_sym is 64 byte on "normal" arches, but 72 byte on
> > sparc64.
> 
> Jurzita, you do not need to post this patch multiple times.
> I was simply on vacation for 2 weeks right after your first
> posting so I had no chance to review the patch.

BTW, did you finally review it (no emergency at all on my side) ?

Regards,
Willy

