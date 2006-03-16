Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932613AbWCPAFv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932613AbWCPAFv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Mar 2006 19:05:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932614AbWCPAFv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Mar 2006 19:05:51 -0500
Received: from iramx2.ira.uni-karlsruhe.de ([141.3.10.81]:51073 "EHLO
	iramx2.ira.uni-karlsruhe.de") by vger.kernel.org with ESMTP
	id S932613AbWCPAFu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Mar 2006 19:05:50 -0500
In-Reply-To: <20060315120257.28c18344.akpm@osdl.org>
References: <200603131758.k2DHwQM7005618@zach-dev.vmware.com> <1142273346.3023.38.camel@laptopd505.fenrus.org> <4415B857.9010902@vmware.com> <20060315102522.GA5926@infradead.org> <F032F3F4-00DB-43AF-A67B-E82673883303@ira.uka.de> <20060315120257.28c18344.akpm@osdl.org>
Mime-Version: 1.0 (Apple Message framework v749.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <A2496632-C643-4E88-B0A7-7BBD92E5BC00@ira.uka.de>
Cc: hch@infradead.org, zach@vmware.com, arjan@infradead.org, torvalds@osdl.org,
       linux-kernel@vger.kernel.org, virtualization@lists.osdl.org,
       xen-devel@lists.xensource.com, dhecht@vmware.com, arai@vmware.com,
       anne@vmware.com, pratap@vmware.com, chrisl@vmware.com, chrisw@osdl.org,
       riel@redhat.com, jreddy@vmware.com, jlo@vmware.com, kmacy@fsmware.com,
       jbeulich@novell.com, ksrinivasan@novell.com, wim.coekaerts@oracle.com,
       leendert@watson.ibm.com
Content-Transfer-Encoding: 7bit
From: Joshua LeVasseur <jtl@ira.uka.de>
Subject: Re: [RFC, PATCH 0/24] VMI i386 Linux virtualization interface proposal
Date: Thu, 16 Mar 2006 01:05:19 +0100
To: Andrew Morton <akpm@osdl.org>
X-Mailer: Apple Mail (2.749.3)
X-Spam-Score: -4.3 (----)
X-Spam-Report: -1.8 ALL_TRUSTED            Passed through trusted hosts only via SMTP
	-2.6 BAYES_00               BODY: Bayesian spam probability is 0 to 1%
	[score: 0.0000]
	0.1 AWL                    AWL: From: address is in the auto white-list
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mar 15, 2006, at 21:02 , Andrew Morton wrote:

> Joshua LeVasseur <jtl@ira.uka.de> wrote:
>>
>> As part of our pre-virtualization work, we developed a virtualization
>> solution similar to VMI.  We support Xen v2 and v3 with high
>> performance.  We added support for the first generation of VMI to our
>> project, and are currently adding support for the latest VMI patch.
>> Our work is open source.  We'll announce when we finish the VMI  
>> updates.
>
> Who is "we" and what product are you referring to?
>
> (I think an important part of this discussion is getting an  
> understanding
> of which virtualisation products (current or planned) could use a  
> VMI).
>
> Thanks.


This is a project at the University of Karlsruhe. The project web  
page is:
http://l4ka.org/projects/virtualization/afterburn/
and there you'll find documentation and source code. The source code  
supports our pre-virtualization project on L4 and Xen (and we have  
some nascent implementations for Linux-as-hypervisor and Windows-as- 
hypervisor).  We automate the transformations to the Linux code, thus  
minimizing the number of manual modifications. Due to the  
similarities of our approach and VMI, our virtualization runtime  
supports VMI with some minor additions.

Joshua

