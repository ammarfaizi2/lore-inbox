Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750942AbVKJOJn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750942AbVKJOJn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Nov 2005 09:09:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750946AbVKJOJn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Nov 2005 09:09:43 -0500
Received: from [194.90.237.34] ([194.90.237.34]:61625 "EHLO
	mtlex01.yok.mtl.com") by vger.kernel.org with ESMTP
	id S1750941AbVKJOJm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Nov 2005 09:09:42 -0500
Date: Thu, 10 Nov 2005 16:12:58 +0200
From: "Michael S. Tsirkin" <mst@mellanox.co.il>
To: Hugh Dickins <hugh@veritas.com>
Cc: Gleb Natapov <gleb@minantech.com>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Petr Vandrovec <vandrove@vc.cvut.cz>,
       Nick Piggin <nickpiggin@yahoo.com.au>,
       Badari Pulavarty <pbadari@us.ibm.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Nick's core remove PageReserved broke vmware...
Message-ID: <20051110141258.GJ16589@mellanox.co.il>
Reply-To: "Michael S. Tsirkin" <mst@mellanox.co.il>
References: <Pine.LNX.4.61.0511101349200.7699@goblin.wat.veritas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0511101349200.7699@goblin.wat.veritas.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Hugh Dickins <hugh@veritas.com>:
> > Maybe MADV_FORK_INHERIT/MADV_FORK_DONT_INHERIT then?
> 
> Those names are a lot longer than the others in that file.
> I still prefer MADV_DONTFORK etc. myself.

We'll do MADV_DONTFORK then.

-- 
MST
