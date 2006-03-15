Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751982AbWCOP5t@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751982AbWCOP5t (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Mar 2006 10:57:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752091AbWCOP5t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Mar 2006 10:57:49 -0500
Received: from mailout1.vmware.com ([65.113.40.130]:4880 "EHLO
	mailout1.vmware.com") by vger.kernel.org with ESMTP
	id S1751982AbWCOP5s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Mar 2006 10:57:48 -0500
Message-ID: <44183965.1020703@vmware.com>
Date: Wed, 15 Mar 2006 07:57:25 -0800
From: Zachary Amsden <zach@vmware.com>
User-Agent: Thunderbird 1.5 (X11/20051201)
MIME-Version: 1.0
To: Christoph Hellwig <hch@infradead.org>, Zachary Amsden <zach@vmware.com>,
       Arjan van de Ven <arjan@infradead.org>,
       Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Virtualization Mailing List <virtualization@lists.osdl.org>,
       Xen-devel <xen-devel@lists.xensource.com>,
       Andrew Morton <akpm@osdl.org>, Dan Hecht <dhecht@vmware.com>,
       Dan Arai <arai@vmware.com>, Anne Holler <anne@vmware.com>,
       Pratap Subrahmanyam <pratap@vmware.com>,
       Christopher Li <chrisl@vmware.com>, Joshua LeVasseur <jtl@ira.uka.de>,
       Chris Wright <chrisw@osdl.org>, Rik Van Riel <riel@redhat.com>,
       Jyothy Reddy <jreddy@vmware.com>, Jack Lo <jlo@vmware.com>,
       Kip Macy <kmacy@fsmware.com>, Jan Beulich <jbeulich@novell.com>,
       Ky Srinivasan <ksrinivasan@novell.com>,
       Wim Coekaerts <wim.coekaerts@oracle.com>,
       Leendert van Doorn <leendert@watson.ibm.com>
Subject: Re: [RFC, PATCH 0/24] VMI i386 Linux virtualization interface	proposal
References: <200603131758.k2DHwQM7005618@zach-dev.vmware.com> <1142273346.3023.38.camel@laptopd505.fenrus.org> <4415B857.9010902@vmware.com> <20060315102522.GA5926@infradead.org>
In-Reply-To: <20060315102522.GA5926@infradead.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig wrote:
> I agree with Zach here, the Xen hypervisor <-> kernel interface is
> not very nice.  This proposal seems like a step forward althogh it'll
> probably need to go through a few iterations.  Without and actually
> useable opensource hypevisor reference implementation it's totally
> unacceptable, though.
>   

Which is why our top priority is getting VMI Linux to run on Xen.  The 
churn rate on both ends has been very high, and we really wanted to 
release our patches with Xen support, but we also didn't want to wait 
some unknown number of weeks more to release them - and we're actually 
looking for volunteers to help with the port if anyone is interested.

What we are hoping for, in the end, is a Linux kernel with a clean 
virtualization interface, that is maintainable, does not slow hypervisor 
exploitation of new technologies, still offers all of the same 
performance advantages, works for the open source community, and allows 
hypervisor vendors of many creeds to benefit from cross-kernel binary 
compatibility.

Zach
