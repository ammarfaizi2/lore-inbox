Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751581AbWADG4M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751581AbWADG4M (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jan 2006 01:56:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932522AbWADG4M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jan 2006 01:56:12 -0500
Received: from smtp.osdl.org ([65.172.181.4]:53672 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751581AbWADG4L (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jan 2006 01:56:11 -0500
Date: Tue, 3 Jan 2006 22:55:27 -0800
From: Andrew Morton <akpm@osdl.org>
To: Manfred Spraul <manfred@dbl.q-ag.de>
Cc: jgarzik@pobox.com, aabdulla@nvidia.com, afu@fugmann.net,
       linux-kernel@vger.kernel.org, netdev@vger.kernel.org, torvalds@osdl.org
Subject: Re: [PATCH] forcedeth: TSO fix for large buffers
Message-Id: <20060103225527.0e7c4ac0.akpm@osdl.org>
In-Reply-To: <200512251451.jBPEpgNe018712@dbl.q-ag.de>
References: <200512251451.jBPEpgNe018712@dbl.q-ag.de>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Manfred Spraul <manfred@dbl.q-ag.de> wrote:
>
> This patch contains a bug fix for large buffers. Originally, if a tx 
>  buffer to be sent was larger then the maximum size of the tx descriptor,
> 
>  it would overwrite other control bits. In this patch, the buffer is 
>  split over multiple descriptors. Also, the fragments are now setup in 
>  forward order.
> 
>  Signed-off-by: Ayaz Abdulla <aabdulla@nvidia.com>
> 
>  Rediffed against forcedeth 0.48
>  Signed-Off-By: Manfred Spraul <manfred@colorfullife.com>

I've assumed that this patch if From: Ayaz.   Please confirm.

If so, it should have had

	From: Ayaz Abdulla <aabdulla@nvidia.com>

at the top of the changlog, thanks.
