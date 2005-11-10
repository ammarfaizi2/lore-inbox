Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750827AbVKJMue@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750827AbVKJMue (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Nov 2005 07:50:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750828AbVKJMue
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Nov 2005 07:50:34 -0500
Received: from taurus.voltaire.com ([193.47.165.240]:49544 "EHLO
	taurus.voltaire.com") by vger.kernel.org with ESMTP
	id S1750827AbVKJMud (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Nov 2005 07:50:33 -0500
Date: Thu, 10 Nov 2005 14:49:49 +0200
From: Gleb Natapov <gleb@minantech.com>
To: "Michael S. Tsirkin" <mst@mellanox.co.il>
Cc: Hugh Dickins <hugh@veritas.com>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Petr Vandrovec <vandrove@vc.cvut.cz>,
       Nick Piggin <nickpiggin@yahoo.com.au>,
       Badari Pulavarty <pbadari@us.ibm.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Nick's core remove PageReserved broke vmware...
Message-ID: <20051110124949.GM8942@minantech.com>
References: <20051110123538.GL8942@minantech.com> <20051110124853.GD16589@mellanox.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051110124853.GD16589@mellanox.co.il>
X-OriginalArrivalTime: 10 Nov 2005 12:50:31.0309 (UTC) FILETIME=[55702BD0:01C5E5F5]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 10, 2005 at 02:48:53PM +0200, Michael S. Tsirkin wrote:
> > Also perhapse we should skip VM_SHARED VMAs?
> 
> Why?
> 
They will work correctly across fork(). 

--
			Gleb.
