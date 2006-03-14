Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932462AbWCNEFq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932462AbWCNEFq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Mar 2006 23:05:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932501AbWCNEFq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Mar 2006 23:05:46 -0500
Received: from mx1.redhat.com ([66.187.233.31]:2517 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932462AbWCNEFp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Mar 2006 23:05:45 -0500
Date: Mon, 13 Mar 2006 23:04:58 -0500 (EST)
From: Rik van Riel <riel@redhat.com>
X-X-Sender: riel@cuia.boston.redhat.com
To: Zachary Amsden <zach@vmware.com>
cc: Anthony Liguori <aliguori@us.ibm.com>, Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Virtualization Mailing List <virtualization@lists.osdl.org>,
       Xen-devel <xen-devel@lists.xensource.com>,
       Andrew Morton <akpm@osdl.org>, Dan Hecht <dhecht@vmware.com>,
       Dan Arai <arai@vmware.com>, Anne Holler <anne@vmware.com>,
       Pratap Subrahmanyam <pratap@vmware.com>,
       Christopher Li <chrisl@vmware.com>, Joshua LeVasseur <jtl@ira.uka.de>,
       Chris Wright <chrisw@osdl.org>, Jyothy Reddy <jreddy@vmware.com>,
       Jack Lo <jlo@vmware.com>, Kip Macy <kmacy@fsmware.com>,
       Jan Beulich <jbeulich@novell.com>,
       Ky Srinivasan <ksrinivasan@novell.com>,
       Wim Coekaerts <wim.coekaerts@oracle.com>,
       Leendert van Doorn <leendert@watson.ibm.com>
Subject: Re: [RFC, PATCH 0/24] VMI i386 Linux virtualization interface proposal
In-Reply-To: <44164013.1080404@vmware.com>
Message-ID: <Pine.LNX.4.63.0603132304200.17874@cuia.boston.redhat.com>
References: <200603131758.k2DHwQM7005618@zach-dev.vmware.com>
 <441610DE.5060709@us.ibm.com> <44164013.1080404@vmware.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 13 Mar 2006, Zachary Amsden wrote:

> About performance - I actually believe that it is possible to implement 
> VMI Linux in such a way that it actually has _better_ performance on Xen 
> than the current XenoLinux kernels.

How would VMI allow page table batching at fault time?
(one of the future optimizations that are probably worth
making for Xen)

-- 
All Rights Reversed
