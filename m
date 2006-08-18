Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161027AbWHRPkf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161027AbWHRPkf (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Aug 2006 11:40:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161026AbWHRPkf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Aug 2006 11:40:35 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:47043 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1161027AbWHRPkd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Aug 2006 11:40:33 -0400
Subject: Re: [RFC][PATCH 2/7] UBC: core (structures, API)
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Andrew Morton <akpm@osdl.org>
Cc: Kirill Korotaev <dev@sw.ru>, rohitseth@google.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Ingo Molnar <mingo@elte.hu>, Christoph Hellwig <hch@infradead.org>,
       Pavel Emelianov <xemul@openvz.org>, Andrey Savochkin <saw@sw.ru>,
       devel@openvz.org, Rik van Riel <riel@redhat.com>, hugh@veritas.com,
       ckrm-tech@lists.sourceforge.net, Andi Kleen <ak@suse.de>
In-Reply-To: <20060817223137.ca4951ff.akpm@osdl.org>
References: <44E33893.6020700@sw.ru> <44E33BB6.3050504@sw.ru>
	 <1155751868.22595.65.camel@galaxy.corp.google.com> <44E458C4.9030902@sw.ru>
	 <20060817223137.ca4951ff.akpm@osdl.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Fri, 18 Aug 2006 16:59:40 +0100
Message-Id: <1155916780.28764.18.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Iau, 2006-08-17 am 22:31 -0700, ysgrifennodd Andrew Morton:
> > oh, its a misname. Should be ub_id. it is ID of user_beancounter
> > and has nothing to do with user id.
> 
> But it uses a uid_t.  That's more than a misnaming?

A container id in UBC is an luid which is a type of uid, and uid_t. That
follows setluid() in other operating system environments.

