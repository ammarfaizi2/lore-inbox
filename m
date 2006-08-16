Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932102AbWHPQcP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932102AbWHPQcP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Aug 2006 12:32:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932100AbWHPQcP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Aug 2006 12:32:15 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:41909 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S932104AbWHPQcO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Aug 2006 12:32:14 -0400
Subject: Re: [RFC][PATCH 3/7] UBC: ub context and inheritance
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Kirill Korotaev <dev@sw.ru>
Cc: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Ingo Molnar <mingo@elte.hu>, Christoph Hellwig <hch@infradead.org>,
       Pavel Emelianov <xemul@openvz.org>, Andrey Savochkin <saw@sw.ru>,
       devel@openvz.org, Rik van Riel <riel@redhat.com>, hugh@veritas.com,
       ckrm-tech@lists.sourceforge.net, Andi Kleen <ak@suse.de>
In-Reply-To: <44E33C04.50803@sw.ru>
References: <44E33893.6020700@sw.ru>  <44E33C04.50803@sw.ru>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Wed, 16 Aug 2006 17:51:18 +0100
Message-Id: <1155747079.24077.372.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Mer, 2006-08-16 am 19:38 +0400, ysgrifennodd Kirill Korotaev:
> Contains code responsible for setting UB on task,
> it's inheriting and setting host context in interrupts.
> 
> Task references three beancounters:
>   1. exec_ub  current context. all resources are
>               charged to this beancounter.
>   2. task_ub  beancounter to which task_struct is
>               charged itself.
>   3. fork_sub beancounter which is inherited by
>               task's children on fork
> 
> Signed-Off-By: Pavel Emelianov <xemul@sw.ru>
> Signed-Off-By: Kirill Korotaev <dev@sw.ru>

Acked-by: Alan Cox <alan@redhat.com>


