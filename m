Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263790AbUDOGMM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Apr 2004 02:12:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263828AbUDOGMM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Apr 2004 02:12:12 -0400
Received: from dragnfire.mtl.istop.com ([66.11.160.179]:57539 "EHLO
	dsl.commfireservices.com") by vger.kernel.org with ESMTP
	id S263790AbUDOGMJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Apr 2004 02:12:09 -0400
Date: Thu, 15 Apr 2004 02:12:29 -0400 (EDT)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Matt Mackall <mpm@selenic.com>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>, Jens Axboe <axboe@suse.de>,
       "Randy.Dunlap" <rddunlap@osdl.org>
Subject: Re: [PATCH] conditionalize some boring buffer_head checks
In-Reply-To: <20040414213336.GC30663@havoc.gtf.org>
Message-ID: <Pine.LNX.4.58.0404150206270.18930@montezuma.fsmlabs.com>
References: <407CEB91.1080503@pobox.com> <20040414005832.083de325.akpm@osdl.org>
 <20040414010240.0e9f4115.akpm@osdl.org> <407CF201.408@pobox.com>
 <20040414011653.22c690d9.akpm@osdl.org> <407CFFF9.5010500@pobox.com>
 <20040414212539.GE1175@waste.org> <20040414213336.GC30663@havoc.gtf.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 14 Apr 2004, Jeff Garzik wrote:

> On Wed, Apr 14, 2004 at 04:25:39PM -0500, Matt Mackall wrote:
> > Sticking this in arch/*/Kconfig seems silly (as does much of the
> > duplication in said files). Can we stick this and other debug bits
> > under the kallsyms option in init/Kconfig instead? Or alternately move
> > debugging bits into their own file that gets included as appropriate.
>
> I would rather have an arch/generic/Kconfig.debug file that gets
> included.  init/Kconfig may be generic, but its name hardly implies its
> purpose as used.
>
> There are clearly two classes of debug options, one arch-specific, and
> one not.

This sounds like lib/Kconfig
