Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932207AbWHVMYN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932207AbWHVMYN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Aug 2006 08:24:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932210AbWHVMYN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Aug 2006 08:24:13 -0400
Received: from e33.co.us.ibm.com ([32.97.110.151]:50592 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S932207AbWHVMYM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Aug 2006 08:24:12 -0400
Date: Tue, 22 Aug 2006 17:53:29 +0530
From: Srivatsa Vaddagiri <vatsa@in.ibm.com>
To: Kirill Korotaev <dev@sw.ru>
Cc: Matt Helsley <matthltc@us.ibm.com>, Rik van Riel <riel@redhat.com>,
       "Chandra S. Seetharaman" <sekharan@us.ibm.com>,
       CKRM-Tech <ckrm-tech@lists.sourceforge.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andi Kleen <ak@suse.de>, Christoph Hellwig <hch@infradead.org>,
       Andrey Savochkin <saw@sw.ru>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       hugh@veritas.com, Ingo Molnar <mingo@elte.hu>, devel@openvz.org,
       Pavel Emelianov <xemul@openvz.org>
Subject: Re: [ckrm-tech] [RFC][PATCH 2/7] UBC: core (structures, API)
Message-ID: <20060822122329.GA7125@in.ibm.com>
Reply-To: vatsa@in.ibm.com
References: <44E33893.6020700@sw.ru> <44E33BB6.3050504@sw.ru> <1155866328.2510.247.camel@stark> <44E5A637.1020407@sw.ru> <1155955116.2510.445.camel@stark> <44E992B9.8080908@sw.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44E992B9.8080908@sw.ru>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 21, 2006 at 03:02:17PM +0400, Kirill Korotaev wrote:
> > Except that you eventually have to lock ub0. Seems that the cache line
> > for that spinlock could bounce quite a bit in such a hot path.
> do you mean by ub0 host system ub which we call ub0
> or you mean a top ub?

If this were used for pure resource management purpose (w/o containers)
then the top ub would be ub0 right? "How bad would the contention on the
ub0->lock be then" is I guess Matt's question.

-- 
Regards,
vatsa
