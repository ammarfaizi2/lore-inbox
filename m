Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751532AbWCMS74@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751532AbWCMS74 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Mar 2006 13:59:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751612AbWCMS74
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Mar 2006 13:59:56 -0500
Received: from mailout1.vmware.com ([65.113.40.130]:60422 "EHLO
	mailout1.vmware.com") by vger.kernel.org with ESMTP
	id S1750820AbWCMS7z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Mar 2006 13:59:55 -0500
Message-ID: <4415C12A.3080602@vmware.com>
Date: Mon, 13 Mar 2006 10:59:54 -0800
From: Zachary Amsden <zach@vmware.com>
User-Agent: Thunderbird 1.5 (X11/20051201)
MIME-Version: 1.0
To: Hollis Blanchard <hollisb@us.ibm.com>
Cc: virtualization@lists.osdl.org, Arjan van de Ven <arjan@infradead.org>,
       Xen-devel <xen-devel@lists.xensource.com>,
       Wim Coekaerts <wim.coekaerts@oracle.com>,
       Chris Wright <chrisw@osdl.org>, Christopher Li <chrisl@vmware.com>,
       Jan Beulich <jbeulich@novell.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>, Anne Holler <anne@vmware.com>,
       Jyothy Reddy <jreddy@vmware.com>, Kip Macy <kmacy@fsmware.com>,
       Ky Srinivasan <ksrinivasan@novell.com>,
       Leendert van Doorn <leendert@watson.ibm.com>
Subject: Re: [RFC, PATCH 0/24] VMI i386 Linux virtualization interface proposal
References: <200603131758.k2DHwQM7005618@zach-dev.vmware.com> <1142274398.3023.40.camel@laptopd505.fenrus.org> <4415BA4F.3040307@vmware.com> <200603131256.51854.hollisb@us.ibm.com>
In-Reply-To: <200603131256.51854.hollisb@us.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hollis Blanchard wrote:
> On Monday 13 March 2006 12:30, Zachary Amsden wrote:
>   
>> It is an advantage for everyone.  It cuts support and certification 
>> costs for Linux distributors, software vendors, makes debugging and 
>> development easier, and gives hypervisors room to grow while maintaining 
>> binary compatibility with already released kernels.
>>     
>
> It certainly is good for kernel developers and end-users.
>
> However, it would be a foolish distributor or ISV who tests with one 
> hypervisor and decides that covers all hypervisors which implement the same 
> interface. So I'm not sure there's any advantage w.r.t. support and 
> certification costs.
>   

Your point is well noted.  I'm not arguing that it would be smart to 
test with just one hypervisor (or worse, yet, test only on native 
hardware), and proudly declare your kernel virtualization compatible.  
There are some things you can do (instrument a torture test verification 
module in a native VMI ROM) to help with that test load.

But in the end, having a single binary reduces the complexity and work 
that goes into a certification, which does simplify the process - even 
if you still have to validate against the list of all supported vendors 
/ hardware.

Zach
