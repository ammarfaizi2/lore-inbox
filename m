Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264863AbSKNPYy>; Thu, 14 Nov 2002 10:24:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264885AbSKNPYy>; Thu, 14 Nov 2002 10:24:54 -0500
Received: from to-velocet.redhat.com ([216.138.202.10]:33262 "EHLO
	touchme.toronto.redhat.com") by vger.kernel.org with ESMTP
	id <S264863AbSKNPYx>; Thu, 14 Nov 2002 10:24:53 -0500
Date: Thu, 14 Nov 2002 10:31:47 -0500
From: Benjamin LaHaise <bcrl@redhat.com>
To: dada1 <dada1@cosmosbay.com>
Cc: Christoph Hellwig <hch@infradead.org>,
       Rik van Riel <riel@conectiva.com.br>, Andrew Morton <akpm@digeo.com>,
       linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [patch] remove hugetlb syscalls
Message-ID: <20021114103147.A17468@redhat.com>
References: <Pine.LNX.4.44L.0211132239370.3817-100000@imladris.surriel.com> <08a601c28bbb$2f6182a0$760010ac@edumazet> <20021114141310.A25747@infradead.org> <002b01c28bf0$751a3960$760010ac@edumazet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <002b01c28bf0$751a3960$760010ac@edumazet>; from dada1@cosmosbay.com on Thu, Nov 14, 2002 at 04:13:56PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 14, 2002 at 04:13:56PM +0100, dada1 wrote:
> Thanks Christoph
> 
> If I asked, this is because I tried the obvious and it doesnt work.

It's a file.  You need to use MAP_SHARED.

		-ben
