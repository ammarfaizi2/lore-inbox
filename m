Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752227AbWCQAU5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752227AbWCQAU5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Mar 2006 19:20:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752451AbWCQAU5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Mar 2006 19:20:57 -0500
Received: from mailout1.vmware.com ([65.113.40.130]:52752 "EHLO
	mailout1.vmware.com") by vger.kernel.org with ESMTP
	id S1752227AbWCQAU4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Mar 2006 19:20:56 -0500
Message-ID: <4419DC5D.1020001@vmware.com>
Date: Thu, 16 Mar 2006 13:45:01 -0800
From: Zachary Amsden <zach@vmware.com>
User-Agent: Thunderbird 1.5 (X11/20051201)
MIME-Version: 1.0
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: Christoph Hellwig <hch@infradead.org>, Linus Torvalds <torvalds@osdl.org>,
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
Subject: Re: [RFC, PATCH 2/24] i386 Vmi config
References: <200603131800.k2DI0RfN005633@zach-dev.vmware.com> <20060314152350.GB16921@infradead.org> <Pine.LNX.4.61.0603161959510.11776@yvahk01.tjqt.qr>
In-Reply-To: <Pine.LNX.4.61.0603161959510.11776@yvahk01.tjqt.qr>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jan Engelhardt wrote:
> And, the last thing, distributor kernels are often compiled for i586 to
> be generic to all users. But some users may actually run them on i686,
> and these users would like to have VMI (speculation :-). Which would
> include a forceful patch to Kconfig to have the VMI option available
> with CONFIG_M586.
>   

We can reenable all these things eventually.  We hacked them out to get 
around some of the awful hacks required for these older machines, (F00F 
bug protection, broken APICs, etc).
