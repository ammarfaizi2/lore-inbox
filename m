Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932723AbWCVU73@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932723AbWCVU73 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Mar 2006 15:59:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932722AbWCVU7K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Mar 2006 15:59:10 -0500
Received: from mx2.suse.de ([195.135.220.15]:6322 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932723AbWCVU7C (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Mar 2006 15:59:02 -0500
From: Andi Kleen <ak@suse.de>
To: virtualization@lists.osdl.org
Subject: Re: [RFC, PATCH 5/24] i386 Vmi code patching
Date: Wed, 22 Mar 2006 21:15:44 +0100
User-Agent: KMail/1.9.1
Cc: Zachary Amsden <zach@vmware.com>, Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
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
References: <200603131802.k2DI2nv8005665@zach-dev.vmware.com>
In-Reply-To: <200603131802.k2DI2nv8005665@zach-dev.vmware.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200603222115.46926.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 13 March 2006 19:02, Zachary Amsden wrote:
> The VMI ROM detection and code patching mechanism is illustrated in
> setup.c.  There ROM is a binary block published by the hypervisor, and
> and there are certainly implications of this.  ROMs certainly have a
> history of being proprietary, very differently licensed pieces of
> software, and mostly under non-free licenses.  Before jumping to the
> conclusion that this is a bad thing, let us consider more carefully
> why hiding the interface layer to the hypervisor is actually a good
> thing.

How about you fix all these issues you describe here first 
and then submit it again?

The disassembly stuff indeed doesn't look like something
that belongs in the kernel.

-Andi

