Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261351AbUD3VKE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261351AbUD3VKE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Apr 2004 17:10:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261244AbUD3VE5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Apr 2004 17:04:57 -0400
Received: from zero.aec.at ([193.170.194.10]:28685 "EHLO zero.aec.at")
	by vger.kernel.org with ESMTP id S261375AbUD3VA7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Apr 2004 17:00:59 -0400
To: Jonathan Corbet <corbet@lwn.net>
cc: linux-kernel@vger.kernel.org
Subject: Re: [MICROPATCH] Make x86_64 build work without GART_IOMMU
References: <1QMlc-5kS-39@gated-at.bofh.it>
From: Andi Kleen <ak@muc.de>
Date: Fri, 30 Apr 2004 23:00:55 +0200
In-Reply-To: <1QMlc-5kS-39@gated-at.bofh.it> (Jonathan Corbet's message of
 "Fri, 30 Apr 2004 22:00:18 +0200")
Message-ID: <m3ad0t9o54.fsf@averell.firstfloor.org>
User-Agent: Gnus/5.110002 (No Gnus v0.2) Emacs/21.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jonathan Corbet <corbet@lwn.net> writes:

> If you try to build a 2.6.6-rc3 kernel with CONFIG_GART_IOMMU turned off,
> the link fails because bad_dma_address is undefined.  This little hack just
> defines the variable in pci-nommu.c as well.  It may not be an optimal fix,
> but it does make the kernel build.
>
> Why do I care?  My Radeon 9200SE goes nuts if I build a GART-enabled
> kernel.  Haven't figured out why...

Define 'nuts' and supply full boot log (with GART enabled)

-Andi

