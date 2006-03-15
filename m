Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751081AbWCOSjj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751081AbWCOSjj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Mar 2006 13:39:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751178AbWCOSjj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Mar 2006 13:39:39 -0500
Received: from iramx2.ira.uni-karlsruhe.de ([141.3.10.81]:44469 "EHLO
	iramx2.ira.uni-karlsruhe.de") by vger.kernel.org with ESMTP
	id S1751081AbWCOSji (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Mar 2006 13:39:38 -0500
In-Reply-To: <20060315102522.GA5926@infradead.org>
References: <200603131758.k2DHwQM7005618@zach-dev.vmware.com> <1142273346.3023.38.camel@laptopd505.fenrus.org> <4415B857.9010902@vmware.com> <20060315102522.GA5926@infradead.org>
Mime-Version: 1.0 (Apple Message framework v749.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <F032F3F4-00DB-43AF-A67B-E82673883303@ira.uka.de>
Cc: Zachary Amsden <zach@vmware.com>, Arjan van de Ven <arjan@infradead.org>,
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
Content-Transfer-Encoding: 7bit
From: Joshua LeVasseur <jtl@ira.uka.de>
Subject: Re: [RFC, PATCH 0/24] VMI i386 Linux virtualization interface	proposal
Date: Wed, 15 Mar 2006 18:38:45 +0100
To: Christoph Hellwig <hch@infradead.org>
X-Mailer: Apple Mail (2.749.3)
X-Spam-Score: -4.3 (----)
X-Spam-Report: -1.8 ALL_TRUSTED            Passed through trusted hosts only via SMTP
	-2.6 BAYES_00               BODY: Bayesian spam probability is 0 to 1%
	[score: 0.0000]
	0.1 AWL                    AWL: From: address is in the auto white-list
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mar 15, 2006, at 11:25 , Christoph Hellwig wrote:

> On Mon, Mar 13, 2006 at 10:22:15AM -0800, Zachary Amsden wrote:
>>> Why can't vmware use the Xen interface instead?
>>>
>>
>> We could.  But it is our opinion that the Xen interface is  
>> unnecessarily
>> complicated, without a clean separation between the layer of  
>> interaction
>> with the hypervisor and the kernel proper.  The interface we  
>> propose we
>> believe is more powerful, and more conducive to performance
>> optimizations while providing significant advantages - most
>> specifically, a single binary image that is properly virtualizable on
>> multiple hypervisors and capable of running on native hardware.
>
> I agree with Zach here, the Xen hypervisor <-> kernel interface is
> not very nice.  This proposal seems like a step forward althogh it'll
> probably need to go through a few iterations.  Without and actually
> useable opensource hypevisor reference implementation it's totally
> unacceptable, though.
>


As part of our pre-virtualization work, we developed a virtualization  
solution similar to VMI.  We support Xen v2 and v3 with high  
performance.  We added support for the first generation of VMI to our  
project, and are currently adding support for the latest VMI patch.   
Our work is open source.  We'll announce when we finish the VMI updates.

We also experimented with other architectures and found the approach  
highly suitable, such as for Itanium.

Joshua


