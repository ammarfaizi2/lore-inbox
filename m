Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932690AbWCWAmg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932690AbWCWAmg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Mar 2006 19:42:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932693AbWCWAmg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Mar 2006 19:42:36 -0500
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:51585 "EHLO
	sorel.sous-sol.org") by vger.kernel.org with ESMTP id S932690AbWCWAmf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Mar 2006 19:42:35 -0500
Date: Wed, 22 Mar 2006 16:41:36 -0800
From: Chris Wright <chrisw@sous-sol.org>
To: Zachary Amsden <zach@vmware.com>
Cc: Chris Wright <chrisw@sous-sol.org>, Andi Kleen <ak@suse.de>,
       virtualization@lists.osdl.org, Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Xen-devel <xen-devel@lists.xensource.com>,
       Andrew Morton <akpm@osdl.org>, Dan Hecht <dhecht@vmware.com>,
       Dan Arai <arai@vmware.com>, Anne Holler <anne@vmware.com>,
       Pratap Subrahmanyam <pratap@vmware.com>,
       Christopher Li <chrisl@vmware.com>, Joshua LeVasseur <jtl@ira.uka.de>,
       Rik Van Riel <riel@redhat.com>, Jyothy Reddy <jreddy@vmware.com>,
       Jack Lo <jlo@vmware.com>, Kip Macy <kmacy@fsmware.com>,
       Jan Beulich <jbeulich@novell.com>,
       Ky Srinivasan <ksrinivasan@novell.com>,
       Wim Coekaerts <wim.coekaerts@oracle.com>,
       Leendert van Doorn <leendert@watson.ibm.com>
Subject: Re: [RFC, PATCH 5/24] i386 Vmi code patching
Message-ID: <20060323004136.GR15997@sorel.sous-sol.org>
References: <200603131802.k2DI2nv8005665@zach-dev.vmware.com> <200603222115.46926.ak@suse.de> <20060322214025.GJ15997@sorel.sous-sol.org> <4421CCA8.4080702@vmware.com> <20060322225117.GM15997@sorel.sous-sol.org> <4421DF62.8020903@vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4421DF62.8020903@vmware.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Zachary Amsden (zach@vmware.com) wrote:
> Chris Wright wrote:
> >You could compile all platform layers you want to support with the kernel.
> 
> But the entire point is that you don't know what platform layers you 
> want to support.  The platform layers can change.  Xen has changed the 
> platform layer and re-optimized kernel / hypervisor transitions how many 
> times?  The platform layer provides exactly the flexibility to do that, 
> so that a kernel you compile today against a generic platform can work 
> with the platform layer provided by Xen 4.0 tomorrow.

This only works if you have all possible dreamed of interface bits in
the ABI. In Linux, we often don't know what we'll need to support in the
future, but we don't write binary compatible interfaces just in case we
need to update.  Preferring instead, API's that are justifiable right now.
This is the issue I have with the ABI proposal.  It doesn't fit well
with Linux developement.

thanks,
-chris
