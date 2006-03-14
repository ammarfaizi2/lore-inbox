Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932257AbWCNEBv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932257AbWCNEBv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Mar 2006 23:01:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932462AbWCNEBv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Mar 2006 23:01:51 -0500
Received: from mailout1.vmware.com ([65.113.40.130]:17680 "EHLO
	mailout1.vmware.com") by vger.kernel.org with ESMTP id S932257AbWCNEBu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Mar 2006 23:01:50 -0500
Message-ID: <44164013.1080404@vmware.com>
Date: Mon, 13 Mar 2006 20:01:23 -0800
From: Zachary Amsden <zach@vmware.com>
User-Agent: Thunderbird 1.5 (X11/20051201)
MIME-Version: 1.0
To: Anthony Liguori <aliguori@us.ibm.com>
Cc: Linus Torvalds <torvalds@osdl.org>,
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
References: <200603131758.k2DHwQM7005618@zach-dev.vmware.com> <441610DE.5060709@us.ibm.com>
In-Reply-To: <441610DE.5060709@us.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Anthony Liguori wrote:
> Zachary Amsden wrote:
>> This is by no means finished work. A few of the areas that need more
>> attention and exploration are (a) 64bit support is still lacking, but we
>> feel a port of VMI to the 64 bit Linux can be done without too much
>> trouble (b) the Xen compatibility layer needs some work to bring it
>> up to the Xen 3.0 interfaces.  Work is underway on this already, and
>> no major issues are expected at this time.   
> Hi Zach,
>
> Can you please post the Xen compatibility layer (even if it is for 
> 2.0.x).  I think it's important to see that code to understand the 
> advantages/disadvantages compared to the existing Xen 
> paravirtualization interface.  Likewise, any Xen performance data 
> would be useful as there has been some discussion about whether VMI 
> would negatively impact Xen performance[1].

About performance - I actually believe that it is possible to implement 
VMI Linux in such a way that it actually has _better_ performance on Xen 
than the current XenoLinux kernels.

I'm working on getting together the older interface pieces now.

Zach
