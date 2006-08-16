Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751172AbWHPQgd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751172AbWHPQgd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Aug 2006 12:36:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751170AbWHPQgd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Aug 2006 12:36:33 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:48053 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1751167AbWHPQgX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Aug 2006 12:36:23 -0400
Subject: Re: [RFC][PATCH 5/7] UBC: kernel memory accounting (core)
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Kirill Korotaev <dev@sw.ru>
Cc: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Ingo Molnar <mingo@elte.hu>, Christoph Hellwig <hch@infradead.org>,
       Pavel Emelianov <xemul@openvz.org>, Andrey Savochkin <saw@sw.ru>,
       devel@openvz.org, Rik van Riel <riel@redhat.com>, hugh@veritas.com,
       ckrm-tech@lists.sourceforge.net, Andi Kleen <ak@suse.de>
In-Reply-To: <44E33C8A.6030705@sw.ru>
References: <44E33893.6020700@sw.ru>  <44E33C8A.6030705@sw.ru>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Wed, 16 Aug 2006 17:56:02 +0100
Message-Id: <1155747362.24077.378.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The 

+       ub->ub_parms[UB_KMEMSIZE].limit = 32 * 1024 * 1024

seems a bit arbitary. 32Mb is variously vast amounts of memory and not
enough to boot depending if you are booting a PDA or a 4096 core Itanic
box

