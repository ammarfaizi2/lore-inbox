Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932715AbWCPSxF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932715AbWCPSxF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Mar 2006 13:53:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932713AbWCPSxE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Mar 2006 13:53:04 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:55452 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S932712AbWCPSxD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Mar 2006 13:53:03 -0500
Date: Thu, 16 Mar 2006 19:52:18 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Joshua LeVasseur <jtl@ira.uka.de>
cc: Arjan van de Ven <arjan@infradead.org>, Zachary Amsden <zach@vmware.com>,
       Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Virtualization Mailing List <virtualization@lists.osdl.org>,
       Xen-devel <xen-devel@lists.xensource.com>,
       Andrew Morton <akpm@osdl.org>, Dan Hecht <dhecht@vmware.com>,
       Dan Arai <arai@vmware.com>, Anne Holler <anne@vmware.com>,
       Pratap Subrahmanyam <pratap@vmware.com>,
       Christopher Li <chrisl@vmware.com>, Chris Wright <chrisw@osdl.org>,
       Rik Van Riel <riel@redhat.com>, Jyothy Reddy <jreddy@vmware.com>,
       Jack Lo <jlo@vmware.com>, Kip Macy <kmacy@fsmware.com>,
       Jan Beulich <jbeulich@novell.com>,
       Ky Srinivasan <ksrinivasan@novell.com>,
       Wim Coekaerts <wim.coekaerts@oracle.com>,
       Leendert van Doorn <leendert@watson.ibm.com>
Subject: Re: [RFC, PATCH 0/24] VMI i386 Linux virtualization interface proposal
In-Reply-To: <93FDC403-B5ED-4508-A468-1DE80D1CAB13@ira.uka.de>
Message-ID: <Pine.LNX.4.61.0603161950360.11776@yvahk01.tjqt.qr>
References: <200603131758.k2DHwQM7005618@zach-dev.vmware.com>
 <1142273346.3023.38.camel@laptopd505.fenrus.org> <4415B857.9010902@vmware.com>
 <1142274398.3023.40.camel@laptopd505.fenrus.org> <4415BA4F.3040307@vmware.com>
 <1142275365.3023.44.camel@laptopd505.fenrus.org> <93FDC403-B5ED-4508-A468-1DE80D1CAB13@ira.uka.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> > and gives hypervisors room to grow while maintaining
>> > binary compatibility with already released kernels.
>> 
>> that I buy for binary only hypervisors. But in an open source world I'll
>> buy this a LOT less as being relevant.
>
> Binary compatibility to Linux is pretty important for applications.  Even
> though Apache is open source, I don't want to recompile it for every new Linux
> kernel.  Fortunately I don't have to, because glibc abstracts the Linux kernel
> interface.  Consider VMI in the same role as glibc -- when the hypervisor
> changes, VMI maintains compatibility with your pre-existing infrastructure,

VMI = kernel code (AFAIU)

I would rather like a user-space-based compat layer.


Jan Engelhardt
-- 
