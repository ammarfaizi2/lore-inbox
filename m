Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263673AbUDGOdw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Apr 2004 10:33:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263682AbUDGOdw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Apr 2004 10:33:52 -0400
Received: from ozlabs.org ([203.10.76.45]:36311 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S263673AbUDGOdt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Apr 2004 10:33:49 -0400
Date: Thu, 8 Apr 2004 00:27:48 +1000
From: Anton Blanchard <anton@samba.org>
To: Andi Kleen <ak@suse.de>
Cc: David Gibson <david@gibson.dropbear.id.au>, akpm@osdl.org,
       linux-kernel@vger.kernel.org, benh@kernel.crashing.org,
       paulus@samba.org, linuxppc64-dev@lists.linuxppc.org
Subject: Re: RFC: COW for hugepages
Message-ID: <20040407142748.GO26474@krispykreme>
References: <20040407074239.GG18264@zax> <20040407143447.4d8f08af.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040407143447.4d8f08af.ak@suse.de>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 
> Implementing this for ppc64 only is just wrong. Before you do this 
> I would suggest to factor out the common code in the various hugetlbpage
> implementations and then implement it in common code.

I could say a similar thing about your i386 specific largepage modifications
in the NUMA api :)

We should probably look at making lots of the arch specific hugetlb code
common but im not sure we want that to become a prerequisite for merging
NUMA API and hugepage COW.

Anton
