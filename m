Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932474AbWCKJCf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932474AbWCKJCf (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Mar 2006 04:02:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932479AbWCKJCe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Mar 2006 04:02:34 -0500
Received: from smtp.osdl.org ([65.172.181.4]:41385 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932474AbWCKJCd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Mar 2006 04:02:33 -0500
Date: Sat, 11 Mar 2006 01:00:23 -0800
From: Andrew Morton <akpm@osdl.org>
To: Chris Leech <christopher.leech@intel.com>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH 3/8] [I/OAT] Setup the networking subsystem as a DMA
 client
Message-Id: <20060311010023.5919ec44.akpm@osdl.org>
In-Reply-To: <20060311022924.3950.33580.stgit@gitlost.site>
References: <20060311022759.3950.58788.stgit@gitlost.site>
	<20060311022924.3950.33580.stgit@gitlost.site>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Leech <christopher.leech@intel.com> wrote:
>
>  +#ifdef CONFIG_NET_DMA
>  +#include <linux/dmaengine.h>
>  +#endif

There are still a number of instances of this in the patch series.  Did you
decide to keep the ifdefs in there for some reason?
