Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261429AbVAMDIK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261429AbVAMDIK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jan 2005 22:08:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261445AbVAMDII
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jan 2005 22:08:08 -0500
Received: from av7-1-sn1.fre.skanova.net ([81.228.11.113]:28827 "EHLO
	av7-1-sn1.fre.skanova.net") by vger.kernel.org with ESMTP
	id S261429AbVAMDH7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jan 2005 22:07:59 -0500
Date: Thu, 13 Jan 2005 04:07:57 +0100
From: Voluspa <lista1@telia.com>
To: Terence Ripperda <tripperda@nvidia.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.6.11-rc1
Message-Id: <20050113040757.265de0ba.lista1@telia.com>
In-Reply-To: <20050113012159.GB15008@hygelac>
References: <20050112095238.32a89245.lista1@telia.com>
	<20050113021328.137435b8.lista1@telia.com>
	<20050113012159.GB15008@hygelac>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 12 Jan 2005 19:21:59 -0600
Terence Ripperda wrote:

> the x86_64 change in bk is here, but the only thing you really need is
> the 'get_page' fix. you should be able to manually edit
> linux/arch/i386/mm/pageattr.c:__change_page_attr(), update that single
> line and be fine:

Not being a coder I was unable to change that function correctly.
replacing "struct page *page" with a "unsigned long pfn" craved other
changes further down - if that even is how you begin hacking... I'll
just wait for the real implementation.

-- 
Mvh
Mats Johannesson
