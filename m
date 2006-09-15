Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751281AbWIORyU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751281AbWIORyU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Sep 2006 13:54:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751283AbWIORyU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Sep 2006 13:54:20 -0400
Received: from liaag1ad.mx.compuserve.com ([149.174.40.30]:41426 "EHLO
	liaag1ad.mx.compuserve.com") by vger.kernel.org with ESMTP
	id S1751281AbWIORyT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Sep 2006 13:54:19 -0400
Date: Fri, 15 Sep 2006 13:50:55 -0400
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: [patch 3/9] Guest page hinting: volatile page cache.
To: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: Zachary Amsden <zach@vmware.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       virtualization <virtualization@lists.osdl.org>,
       Andrew Morton <akpm@osdl.org>, Nick Piggin <nickpiggin@yahoo.com.au>
Message-ID: <200609151352_MC3-1-CB54-526A@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In-Reply-To: <1158309400.23993.9.camel@localhost>

On Fri, 15 Sep 2006 10:36:39 +0200, Martin Schwidefsky wrote:

> I wonder which trick you use, since there is only one page table one
> i386 I can only imagine that you are tracking all page tables of the
> guest.

AMD K8 with the SVM feature has host and guest page tables and
address-space identifiers for the guests so their global TLB flushes
can be limited to their own address space...

-- 
Chuck

