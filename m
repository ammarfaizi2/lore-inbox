Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262821AbSKNOGX>; Thu, 14 Nov 2002 09:06:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264890AbSKNOGX>; Thu, 14 Nov 2002 09:06:23 -0500
Received: from phoenix.infradead.org ([195.224.96.167]:47364 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S262821AbSKNOGW>; Thu, 14 Nov 2002 09:06:22 -0500
Date: Thu, 14 Nov 2002 14:13:10 +0000
From: Christoph Hellwig <hch@infradead.org>
To: dada1 <dada1@cosmosbay.com>
Cc: Rik van Riel <riel@conectiva.com.br>, Benjamin LaHaise <bcrl@redhat.com>,
       Andrew Morton <akpm@digeo.com>, linux-mm@kvack.org,
       linux-kernel@vger.kernel.org
Subject: Re: [patch] remove hugetlb syscalls
Message-ID: <20021114141310.A25747@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	dada1 <dada1@cosmosbay.com>, Rik van Riel <riel@conectiva.com.br>,
	Benjamin LaHaise <bcrl@redhat.com>, Andrew Morton <akpm@digeo.com>,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <Pine.LNX.4.44L.0211132239370.3817-100000@imladris.surriel.com> <08a601c28bbb$2f6182a0$760010ac@edumazet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <08a601c28bbb$2f6182a0$760010ac@edumazet>; from dada1@cosmosbay.com on Thu, Nov 14, 2002 at 09:52:33AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 14, 2002 at 09:52:33AM +0100, dada1 wrote:
> I beg to differ.
> 
> I already use the syscalls.

For what?

> How one is supposed to use hugetlbfs ? That's not documented.

mount -t hugetlbfs whocares /huge

fd = open("/huge/nose", ..)

mmap(.., fd, ..)

