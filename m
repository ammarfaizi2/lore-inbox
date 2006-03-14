Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932512AbWCNVvo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932512AbWCNVvo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Mar 2006 16:51:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932513AbWCNVvo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Mar 2006 16:51:44 -0500
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:63106 "EHLO
	sorel.sous-sol.org") by vger.kernel.org with ESMTP id S932512AbWCNVvm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Mar 2006 16:51:42 -0500
Date: Tue, 14 Mar 2006 13:56:17 -0800
From: Chris Wright <chrisw@sous-sol.org>
To: Zachary Amsden <zach@vmware.com>
Cc: Chris Wright <chrisw@sous-sol.org>, Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Virtualization Mailing List <virtualization@lists.osdl.org>,
       Xen-devel <xen-devel@lists.xensource.com>,
       Andrew Morton <akpm@osdl.org>, Dan Hecht <dhecht@vmware.com>,
       Dan Arai <arai@vmware.com>, Anne Holler <anne@vmware.com>,
       Pratap Subrahmanyam <pratap@vmware.com>,
       Christopher Li <chrisl@vmware.com>, Joshua LeVasseur <jtl@ira.uka.de>,
       Chris Wright <chrisw@sous-sol.org>, Rik Van Riel <riel@redhat.com>,
       Jyothy Reddy <jreddy@vmware.com>, Jack Lo <jlo@vmware.com>,
       Kip Macy <kmacy@fsmware.com>, Jan Beulich <jbeulich@novell.com>,
       Ky Srinivasan <ksrinivasan@novell.com>,
       Wim Coekaerts <wim.coekaerts@oracle.com>,
       Leendert van Doorn <leendert@watson.ibm.com>,
       Gerd Hoffmann <kraxel@suse.de>
Subject: Re: [RFC, PATCH 7/24] i386 Vmi memory hole
Message-ID: <20060314215616.GM12807@sorel.sous-sol.org>
References: <200603131804.k2DI4N6s005678@zach-dev.vmware.com> <20060314064107.GK12807@sorel.sous-sol.org> <44166D6B.4090701@vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44166D6B.4090701@vmware.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Zachary Amsden (zach@vmware.com) wrote:
> Allow creation of an compile time hole at the top of linear address space.
> 
> Extended to allow a dynamic hole in linear address space, 7/2005.  This
> required some serious hacking to get everything perfect, but the end result
> appears to function quite nicely.  Everyone can now share the appreciation
> of pseudo-undocumented ELF OS fields, which means core dumps, debuggers
> and even broken or obsolete linkers may continue to work.

Thanks.  Gerd did something similar (although I believe it's simpler,
don't recall the relocation magic) for Xen.  Either way, it's useful
from Xen perspective.

thanks,
-chris
