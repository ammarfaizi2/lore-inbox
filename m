Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750834AbVKJNNP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750834AbVKJNNP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Nov 2005 08:13:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750838AbVKJNNP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Nov 2005 08:13:15 -0500
Received: from [194.90.237.34] ([194.90.237.34]:16029 "EHLO
	mtlex01.yok.mtl.com") by vger.kernel.org with ESMTP
	id S1750834AbVKJNNO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Nov 2005 08:13:14 -0500
Date: Thu, 10 Nov 2005 15:16:30 +0200
From: "Michael S. Tsirkin" <mst@mellanox.co.il>
To: Gleb Natapov <gleb@minantech.com>
Cc: Hugh Dickins <hugh@veritas.com>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Petr Vandrovec <vandrove@vc.cvut.cz>,
       Nick Piggin <nickpiggin@yahoo.com.au>,
       Badari Pulavarty <pbadari@us.ibm.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Nick's core remove PageReserved broke vmware...
Message-ID: <20051110131630.GF16589@mellanox.co.il>
Reply-To: "Michael S. Tsirkin" <mst@mellanox.co.il>
References: <20051110124949.GM8942@minantech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051110124949.GM8942@minantech.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Gleb Natapov <gleb@minantech.com>:
> Subject: Re: Nick's core remove PageReserved broke vmware...
> 
> On Thu, Nov 10, 2005 at 02:48:53PM +0200, Michael S. Tsirkin wrote:
> > > Also perhapse we should skip VM_SHARED VMAs?
> > 
> > Why?
> > 
> They will work correctly across fork(). 

So why would I call madvise on such a VMA?

-- 
MST
