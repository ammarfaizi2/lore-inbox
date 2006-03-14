Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751745AbWCNAkJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751745AbWCNAkJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Mar 2006 19:40:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751763AbWCNAkI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Mar 2006 19:40:08 -0500
Received: from e35.co.us.ibm.com ([32.97.110.153]:16535 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751746AbWCNAkG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Mar 2006 19:40:06 -0500
Message-ID: <441610DE.5060709@us.ibm.com>
Date: Mon, 13 Mar 2006 18:39:58 -0600
From: Anthony Liguori <aliguori@us.ibm.com>
User-Agent: Mail/News 1.5 (X11/20060309)
MIME-Version: 1.0
To: Zachary Amsden <zach@vmware.com>
CC: Linus Torvalds <torvalds@osdl.org>,
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
Subject: Re: [RFC, PATCH 0/24] VMI i386 Linux virtualization interface proposal
References: <200603131758.k2DHwQM7005618@zach-dev.vmware.com>
In-Reply-To: <200603131758.k2DHwQM7005618@zach-dev.vmware.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Zachary Amsden wrote:
> This is by no means finished work. A few of the areas that need more
> attention and exploration are (a) 64bit support is still lacking, but we
> feel a port of VMI to the 64 bit Linux can be done without too much
> trouble (b) the Xen compatibility layer needs some work to bring it
> up to the Xen 3.0 interfaces.  Work is underway on this already, and
> no major issues are expected at this time. 
>   
Hi Zach,

Can you please post the Xen compatibility layer (even if it is for 
2.0.x).  I think it's important to see that code to understand the 
advantages/disadvantages compared to the existing Xen paravirtualization 
interface.  Likewise, any Xen performance data would be useful as there 
has been some discussion about whether VMI would negatively impact Xen 
performance[1].

Thanks,

Anthony Liguori
> Two final notes.  This is not an attempt to force a proprietary interface
> into the Linux kernel.  This is an attempt to find a common interface
> that can be used by many hypervisors by isolating hypervisor specific
> idioms into a neutral layer.  This new layer is just what is claims to
> be - a virtual machine interface, which allows hypervisor dependent code
> to be abstracted in a way that benefits both Linux and hypervisor
> development.
>
> This is also not an attempt to define an exact and final specification
> of how virtualization should be done in Linux.  This is very much a work
> in progress, and it is understood that the interfaces proposed here will
> change in time to accommodate the needs of all interested parties.  We 
> hope to find a common solution that can eventually become part of the
> Linux kernel and serve as a model for other operating systems as well.
>
> We appreciate your feedback on this design and the patches to Linux, and
> welcome working with anyone who is interested in making virtualization
> in Linux a friendly environment to innovate in.  If you find the ideas
> here interesting, please volunteer to help improve them.
>   
> ------------------------------------------------------------------------
>
> _______________________________________________
> Virtualization mailing list
> Virtualization@lists.osdl.org
> https://lists.osdl.org/mailman/listinfo/virtualization
>   

