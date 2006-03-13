Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751711AbWCMSsu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751711AbWCMSsu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Mar 2006 13:48:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932296AbWCMSsu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Mar 2006 13:48:50 -0500
Received: from mailout1.vmware.com ([65.113.40.130]:30469 "EHLO
	mailout1.vmware.com") by vger.kernel.org with ESMTP
	id S1751711AbWCMSst (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Mar 2006 13:48:49 -0500
Message-ID: <4415BE8F.1080609@vmware.com>
Date: Mon, 13 Mar 2006 10:48:47 -0800
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
Subject: Re: [RFC, PATCH 0/24] VMI i386 Linux	virtualization	interface	proposal
References: <200603131758.k2DHwQM7005618@zach-dev.vmware.com>	 <1142273346.3023.38.camel@laptopd505.fenrus.org>	 <4415B857.9010902@vmware.com>	 <1142274398.3023.40.camel@laptopd505.fenrus.org>	 <4415BA4F.3040307@vmware.com> <1142275365.3023.44.camel@laptopd505.fenrus.org>
In-Reply-To: <1142275365.3023.44.camel@laptopd505.fenrus.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven wrote:
>
>> makes debugging and 
>> development easier,
>>     
>
> that I don't buy; a fixed interface tends to make debugging harder not
> easier since you can't change it to add more information

This we find to be quite true.  Now, you can use a VMI kernel, make 
changes to it, run it on native hardware, and be confident that it will 
run properly in a VM as well.  And you can develop in a VM, with 
confidence that you can run on native hardware.  You can even replace 
the entire "ROM" image with your own custom debugging image to add any 
type of debugging or performance monitoring facility you want - and you 
have some very, very interesting hook points into the kernel that make 
that task much more achievable.


> that I buy for binary only hypervisors. But in an open source world I'll
> buy this a LOT less as being relevant.
>   

This is not about the open source versus the closed source world.  It is 
about the real world, where customers want to make as few changes as 
possible to a working and already deployed system.  If they have to 
recompile a kernel just to get their system to run again, that is a pain 
point that is easily avoided.


Zach
