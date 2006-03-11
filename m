Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932434AbWCKIz0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932434AbWCKIz0 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Mar 2006 03:55:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932435AbWCKIz0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Mar 2006 03:55:26 -0500
Received: from smtp.osdl.org ([65.172.181.4]:10664 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932434AbWCKIzZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Mar 2006 03:55:25 -0500
Date: Sat, 11 Mar 2006 00:53:16 -0800
From: Andrew Morton <akpm@osdl.org>
To: Chris Leech <christopher.leech@intel.com>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH 1/8] [I/OAT] DMA memcpy subsystem
Message-Id: <20060311005316.61368bac.akpm@osdl.org>
In-Reply-To: <20060311022919.3950.43835.stgit@gitlost.site>
References: <20060311022759.3950.58788.stgit@gitlost.site>
	<20060311022919.3950.43835.stgit@gitlost.site>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Leech <christopher.leech@intel.com> wrote:
>
> +void dma_async_device_cleanup(struct kref *kref);
>

Declarations go in header files, please.  Or give it static scope.

