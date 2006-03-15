Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751248AbWCOKIf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751248AbWCOKIf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Mar 2006 05:08:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751384AbWCOKIf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Mar 2006 05:08:35 -0500
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:26242 "EHLO
	sorel.sous-sol.org") by vger.kernel.org with ESMTP id S1751248AbWCOKIe
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Mar 2006 05:08:34 -0500
Date: Wed, 15 Mar 2006 02:13:21 -0800
From: Chris Wright <chrisw@sous-sol.org>
To: Zachary Amsden <zach@vmware.com>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Virtualization Mailing List <virtualization@lists.osdl.org>,
       Xen-devel <xen-devel@lists.xensource.com>,
       Andrew Morton <akpm@osdl.org>, Dan Hecht <dhecht@vmware.com>,
       Dan Arai <arai@vmware.com>, Anne Holler <anne@vmware.com>,
       Pratap Subrahmanyam <pratap@vmware.com>,
       Christopher Li <chrisl@vmware.com>, Joshua LeVasseur <jtl@ira.uka.de>,
       Chris Wright <chrisw@sous-sol.org>, Rik Van Riel <riel@redhat.com>,
       Jyothy Reddy <jreddy@vmware.com>, Jack Lo <jlo@vmware.com>,
       Kip Macy <kmacy@fsmware.com>, Jan Beulich <jbeulich@novell.com>,
       Ky Srinivasan <ksrinivasan@novell.com>,
       Wim Coekaerts <wim.coekaerts@oracle.com>,
       Leendert van Doorn <leendert@watson.ibm.com>
Subject: Re: [RFC, PATCH 10/24] i386 Vmi descriptor changes
Message-ID: <20060315101321.GV12807@sorel.sous-sol.org>
References: <200603131806.k2DI6jlJ005700@zach-dev.vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200603131806.k2DI6jlJ005700@zach-dev.vmware.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Zachary Amsden (zach@vmware.com) wrote:
> Descriptor and trap table cleanups.  Add cleanly written accessors for
> IDT and GDT gates so the subarch may override them.  Note that this
> allows the hypervisor to transparently tweak the DPL of the descriptors
> as well as the RPL of segments in those descriptors, with no unnecessary
> kernel code modification.  It also allows the hypervisor implementation
> of the VMI to tweak the gates, allowing for custom exception frames or
> extra layers of indirection above the guest fault / IRQ handlers.

Nice cleanups, VMI or not.

thanks,
-chris
