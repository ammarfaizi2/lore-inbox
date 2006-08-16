Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751170AbWHPQho@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751170AbWHPQho (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Aug 2006 12:37:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750892AbWHPQho
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Aug 2006 12:37:44 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:61619 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1751167AbWHPQhn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Aug 2006 12:37:43 -0400
Subject: Re: [RFC][PATCH 6/7] UBC: kernel memory acconting (mark objects)
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Kirill Korotaev <dev@sw.ru>
Cc: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Ingo Molnar <mingo@elte.hu>, Christoph Hellwig <hch@infradead.org>,
       Pavel Emelianov <xemul@openvz.org>, Andrey Savochkin <saw@sw.ru>,
       devel@openvz.org, Rik van Riel <riel@redhat.com>, hugh@veritas.com,
       ckrm-tech@lists.sourceforge.net, Andi Kleen <ak@suse.de>
In-Reply-To: <44E33CF6.1080809@sw.ru>
References: <44E33893.6020700@sw.ru>  <44E33CF6.1080809@sw.ru>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Wed, 16 Aug 2006 17:57:18 +0100
Message-Id: <1155747439.24077.380.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Mer, 2006-08-16 am 19:42 +0400, ysgrifennodd Kirill Korotaev:
> Mark some kmem caches with SLAB_UBC and some allocations with __GFP_UBC
> to cause charging/limiting of appropriate kernel resources.
> 
> Signed-Off-By: Pavel Emelianov <xemul@sw.ru>
> Signed-Off-By: Kirill Korotaev <dev@sw.ru>

Acked-by: Alan Cox <alan@redhat.com>

(although it will clash slightly with the diffs I just sent Andrew)

