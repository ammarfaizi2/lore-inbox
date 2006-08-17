Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932348AbWHQRt4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932348AbWHQRt4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Aug 2006 13:49:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932556AbWHQRtz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Aug 2006 13:49:55 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.142]:8101 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S932348AbWHQRtz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Aug 2006 13:49:55 -0400
Subject: Re: [ckrm-tech] [RFC][PATCH 5/7] UBC: kernel memory accounting
	(core)
From: Dave Hansen <haveblue@us.ibm.com>
To: Andi Kleen <ak@suse.de>
Cc: rohitseth@google.com, Rik van Riel <riel@redhat.com>,
       ckrm-tech@lists.sourceforge.net,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Kirill Korotaev <dev@sw.ru>, Christoph Hellwig <hch@infradead.org>,
       Andrey Savochkin <saw@sw.ru>, devel@openvz.org, hugh@veritas.com,
       Ingo Molnar <mingo@elte.hu>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Pavel Emelianov <xemul@openvz.org>
In-Reply-To: <200608172043.12468.ak@suse.de>
References: <44E33893.6020700@sw.ru> <44E488EF.4090803@redhat.com>
	 <1155835700.14617.55.camel@galaxy.corp.google.com>
	 <200608172043.12468.ak@suse.de>
Content-Type: text/plain
Date: Thu, 17 Aug 2006 10:49:23 -0700
Message-Id: <1155836963.9274.66.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-08-17 at 20:43 +0200, Andi Kleen wrote:
> -Andi (who still doesn't see what's so bad about a separate table)

Not much wrong with that, as long as we do something more like sparsemem
than mem_map[]. ;)

-- Dave

