Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751012AbWHPQjJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751012AbWHPQjJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Aug 2006 12:39:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751179AbWHPQjI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Aug 2006 12:39:08 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:64691 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1751012AbWHPQjH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Aug 2006 12:39:07 -0400
Subject: Re: [RFC][PATCH 2/7] UBC: core (structures, API)
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Kirill Korotaev <dev@sw.ru>
Cc: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Ingo Molnar <mingo@elte.hu>, Christoph Hellwig <hch@infradead.org>,
       Pavel Emelianov <xemul@openvz.org>, Andrey Savochkin <saw@sw.ru>,
       devel@openvz.org, Rik van Riel <riel@redhat.com>, hugh@veritas.com,
       ckrm-tech@lists.sourceforge.net, Andi Kleen <ak@suse.de>
In-Reply-To: <44E33BB6.3050504@sw.ru>
References: <44E33893.6020700@sw.ru>  <44E33BB6.3050504@sw.ru>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Wed, 16 Aug 2006 17:58:52 +0100
Message-Id: <1155747532.24077.382.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Mer, 2006-08-16 am 19:37 +0400, ysgrifennodd Kirill Korotaev:
> + * UB_MAXVALUE is essentially LONG_MAX declared in a cross-compiling safe form.
> + */
> +#define UB_MAXVALUE	( (1UL << (sizeof(unsigned long)*8-1)) - 1)
> +

Whats wrong with using the kernels LONG_MAX ?

