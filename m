Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751370AbWCNPXy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751370AbWCNPXy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Mar 2006 10:23:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751465AbWCNPXy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Mar 2006 10:23:54 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:44740 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751370AbWCNPXx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Mar 2006 10:23:53 -0500
Date: Tue, 14 Mar 2006 15:23:50 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Zachary Amsden <zach@vmware.com>
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
Subject: Re: [RFC, PATCH 2/24] i386 Vmi config
Message-ID: <20060314152350.GB16921@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Zachary Amsden <zach@vmware.com>,
	Linus Torvalds <torvalds@osdl.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Virtualization Mailing List <virtualization@lists.osdl.org>,
	Xen-devel <xen-devel@lists.xensource.com>,
	Andrew Morton <akpm@osdl.org>, Dan Hecht <dhecht@vmware.com>,
	Dan Arai <arai@vmware.com>, Anne Holler <anne@vmware.com>,
	Pratap Subrahmanyam <pratap@vmware.com>,
	Christopher Li <chrisl@vmware.com>,
	Joshua LeVasseur <jtl@ira.uka.de>, Chris Wright <chrisw@osdl.org>,
	Rik Van Riel <riel@redhat.com>, Jyothy Reddy <jreddy@vmware.com>,
	Jack Lo <jlo@vmware.com>, Kip Macy <kmacy@fsmware.com>,
	Jan Beulich <jbeulich@novell.com>,
	Ky Srinivasan <ksrinivasan@novell.com>,
	Wim Coekaerts <wim.coekaerts@oracle.com>,
	Leendert van Doorn <leendert@watson.ibm.com>
References: <200603131800.k2DI0RfN005633@zach-dev.vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200603131800.k2DI0RfN005633@zach-dev.vmware.com>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 13, 2006 at 10:00:27AM -0800, Zachary Amsden wrote:
> Introduce the basic VMI sub-arch configuration dependencies.  VMI kernels only
> are designed to run on modern hardware platforms.  As such, they require a
> working APIC, and do not support some legacy functionality, including APM BIOS,
> ISA and MCA bus systems, PCI BIOS interfaces, or PnP BIOS (by implication of
> dropping ISA support).  They also require a P6 series CPU.

That's pretty bad because distributors need another kernel still.  At least
a working APIC isn't quite as common today as it should.

