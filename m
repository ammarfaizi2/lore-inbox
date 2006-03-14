Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751026AbWCNQM2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751026AbWCNQM2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Mar 2006 11:12:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751246AbWCNQM2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Mar 2006 11:12:28 -0500
Received: from mailout1.vmware.com ([65.113.40.130]:45576 "EHLO
	mailout1.vmware.com") by vger.kernel.org with ESMTP
	id S1751026AbWCNQM1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Mar 2006 11:12:27 -0500
Message-ID: <4416EB29.1070209@vmware.com>
Date: Tue, 14 Mar 2006 08:11:21 -0800
From: Zachary Amsden <zach@vmware.com>
User-Agent: Thunderbird 1.5 (X11/20051201)
MIME-Version: 1.0
To: Christoph Hellwig <hch@infradead.org>, Zachary Amsden <zach@vmware.com>,
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
Subject: Re: [RFC, PATCH 3/24] i386 Vmi interface definition
References: <200603131801.k2DI1EAe005650@zach-dev.vmware.com> <20060314152559.GC16921@infradead.org>
In-Reply-To: <20060314152559.GC16921@infradead.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig wrote:
> On Mon, Mar 13, 2006 at 10:01:14AM -0800, Zachary Amsden wrote:
>   
>> Master definition of VMI interface, including calls, constants, and
>> interface version.
>>     
>
> This is a totally horrible style.  There's absolutely no need to find
> your own sized integer types, please use the standard kernel ones.
> Also don't use camel case and #pack but rather __attribute__.
> Also please avoid // comments.
>
> Also please remove all the historical version garbage, we don't care about
> that.
>   

Ugly, isn't it.  The collision of two source styles has left some 
scars.  And fixing it is not yet finished.  We know about these 
problems, and we are working on getting rid of them.  The historical 
version garbage is rather important to us internally, and these bits are 
not yet fully polished, so you get to see it to.  I think you'll find us 
respecting Linux conventions a lot more in the later patches.

Zach

