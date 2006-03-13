Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750985AbWCMS6N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750985AbWCMS6N (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Mar 2006 13:58:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751102AbWCMS6M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Mar 2006 13:58:12 -0500
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:26241 "EHLO
	sorel.sous-sol.org") by vger.kernel.org with ESMTP id S1750985AbWCMS6L
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Mar 2006 13:58:11 -0500
Date: Mon, 13 Mar 2006 11:02:34 -0800
From: Chris Wright <chrisw@sous-sol.org>
To: Zachary Amsden <zach@vmware.com>
Cc: Arjan van de Ven <arjan@infradead.org>, Linus Torvalds <torvalds@osdl.org>,
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
Message-ID: <20060313190234.GN27645@sorel.sous-sol.org>
References: <200603131758.k2DHwQM7005618@zach-dev.vmware.com> <1142273346.3023.38.camel@laptopd505.fenrus.org> <4415B857.9010902@vmware.com> <1142274398.3023.40.camel@laptopd505.fenrus.org> <4415BA4F.3040307@vmware.com> <1142275365.3023.44.camel@laptopd505.fenrus.org> <4415BE8F.1080609@vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4415BE8F.1080609@vmware.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Zachary Amsden (zach@vmware.com) wrote:
> This we find to be quite true.  Now, you can use a VMI kernel, make 
> changes to it, run it on native hardware, and be confident that it will 
> run properly in a VM as well.  And you can develop in a VM, with 
> confidence that you can run on native hardware.  You can even replace 
> the entire "ROM" image with your own custom debugging image to add any 
> type of debugging or performance monitoring facility you want - and you 
> have some very, very interesting hook points into the kernel that make 
> that task much more achievable.

Replacing a ROM image is easier in terms package management, but still
requires full validation and certification process.  Swapping out the
underlying core is a major change and needs to be re-validated.

thanks,
-chris
