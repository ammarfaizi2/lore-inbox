Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932104AbWCMSap@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932104AbWCMSap (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Mar 2006 13:30:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932327AbWCMSap
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Mar 2006 13:30:45 -0500
Received: from mailout1.vmware.com ([65.113.40.130]:53007 "EHLO
	mailout1.vmware.com") by vger.kernel.org with ESMTP id S932104AbWCMSao
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Mar 2006 13:30:44 -0500
Message-ID: <4415BA4F.3040307@vmware.com>
Date: Mon, 13 Mar 2006 10:30:39 -0800
From: Zachary Amsden <zach@vmware.com>
User-Agent: Thunderbird 1.5 (X11/20051201)
MIME-Version: 1.0
To: Arjan van de Ven <arjan@infradead.org>
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
Subject: Re: [RFC, PATCH 0/24] VMI i386 Linux virtualization	interface	proposal
References: <200603131758.k2DHwQM7005618@zach-dev.vmware.com>	 <1142273346.3023.38.camel@laptopd505.fenrus.org>	 <4415B857.9010902@vmware.com> <1142274398.3023.40.camel@laptopd505.fenrus.org>
In-Reply-To: <1142274398.3023.40.camel@laptopd505.fenrus.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven wrote:
>>   The interface we propose we 
>> believe is more powerful, and more conducive to performance 
>> optimizations while providing significant advantages - most 
>> specifically, a single binary image that is properly virtualizable on 
>> multiple hypervisors and capable of running on native hardware.
>>     
>
> that is mostly an advantage in the binary would though.. less so in the
> open source world.
>   

It is an advantage for everyone.  It cuts support and certification 
costs for Linux distributors, software vendors, makes debugging and 
development easier, and gives hypervisors room to grow while maintaining 
binary compatibility with already released kernels.

Zach
