Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030566AbVKQAGs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030566AbVKQAGs (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Nov 2005 19:06:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030567AbVKQAGs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Nov 2005 19:06:48 -0500
Received: from e34.co.us.ibm.com ([32.97.110.152]:193 "EHLO e34.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S1030566AbVKQAGr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Nov 2005 19:06:47 -0500
Date: Wed, 16 Nov 2005 16:06:26 -0800
From: Mike Kravetz <kravetz@us.ibm.com>
To: Andy Whitcroft <apw@shadowen.org>
Cc: Anton Blanchard <anton@samba.org>, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org
Subject: Re: [PATCH 0/3] SPARSEMEM: pfn_to_nid implementation
Message-ID: <20051117000626.GD5628@w-mikek2.ibm.com>
References: <20051115221003.GA2160@w-mikek2.ibm.com> <exportbomb.1132181992@pinky>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <exportbomb.1132181992@pinky>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 16, 2005 at 10:59:53PM +0000, Andy Whitcroft wrote:
> Following this message are three patches:
> 
> kvaddr_to_nid-not-used-in-common-code: removes the unused interface
> kvaddr_to_nid().
> 
> pfn_to_pgdat-not-used-in-common-code: removes the unused interface
> pfn_to_pgdat().
> 
> sparse-provide-pfn_to_nid: provides pfn_to_nid() for SPARSEMEM.
> Note that this implmentation assumes the pfn has been validated
> prior to use.  The only intree user of this call does this.
> We perhaps need to make this part of the signature for this function.
> 
> Mike, how does this look to you?

I like the idea of getting rid of unused interfaces as well as getting
the node information from the page structs.  It works for me on powerpc.

-- 
Mike
