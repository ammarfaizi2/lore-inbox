Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263776AbUDMVdW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Apr 2004 17:33:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263775AbUDMVdW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Apr 2004 17:33:22 -0400
Received: from ns.suse.de ([195.135.220.2]:35297 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S263774AbUDMVdQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Apr 2004 17:33:16 -0400
Date: Tue, 13 Apr 2004 23:33:14 +0200
From: Andi Kleen <ak@suse.de>
To: Mikael Pettersson <mikpe@csd.uu.se>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.6.5-bk1 on x86-64 linkage error
Message-Id: <20040413233314.6c99faa5.ak@suse.de>
In-Reply-To: <200404132132.i3DLWFml005032@harpo.it.uu.se>
References: <200404132132.i3DLWFml005032@harpo.it.uu.se>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 13 Apr 2004 23:32:15 +0200 (MEST)
Mikael Pettersson <mikpe@csd.uu.se> wrote:

> Andi,
> 
> 2.6.5-bk1 on x86-64 with CONFIG_GART_IOMMU=n fails to
> link due to undefined references to iommu_aperture_allowed
> and iommu_aperture_disabled. Fixed by the patch below.

Thanks. I had already fixed that earlier in a slightly different way,
but the fix didn't make it in 2.6.5.

-Andi

