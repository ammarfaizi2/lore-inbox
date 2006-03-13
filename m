Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932284AbWCMSJV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932284AbWCMSJV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Mar 2006 13:09:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932278AbWCMSJT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Mar 2006 13:09:19 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:24712 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932284AbWCMSJQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Mar 2006 13:09:16 -0500
Subject: Re: [RFC, PATCH 0/24] VMI i386 Linux virtualization interface
	proposal
From: Arjan van de Ven <arjan@infradead.org>
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
In-Reply-To: <200603131758.k2DHwQM7005618@zach-dev.vmware.com>
References: <200603131758.k2DHwQM7005618@zach-dev.vmware.com>
Content-Type: text/plain
Date: Mon, 13 Mar 2006 19:09:05 +0100
Message-Id: <1142273346.3023.38.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Two final notes.  This is not an attempt to force a proprietary interface
> into the Linux kernel.  This is an attempt to find a common interface
> that can be used by many hypervisors by isolating hypervisor specific
> idioms into a neutral layer.  This new layer is just what is claims to
> be - a virtual machine interface, which allows hypervisor dependent code
> to be abstracted in a way that benefits both Linux and hypervisor
> development.


such an interface should be defined with source visibility of both sides
though. At least of one user. Can XEN or any of the other open
hypervisors use this? What does it look like? And if not, why not,
wouldn't that make VMA a VMwareInterface instead ? ;)

Why can't vmware use the Xen interface instead?


