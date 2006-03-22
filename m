Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932080AbWCVV5m@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932080AbWCVV5m (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Mar 2006 16:57:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932070AbWCVV5m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Mar 2006 16:57:42 -0500
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:47490 "EHLO
	sorel.sous-sol.org") by vger.kernel.org with ESMTP id S932080AbWCVV5l
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Mar 2006 16:57:41 -0500
Date: Wed, 22 Mar 2006 13:57:32 -0800
From: Chris Wright <chrisw@sous-sol.org>
To: Andi Kleen <ak@suse.de>
Cc: Chris Wright <chrisw@sous-sol.org>, virtualization@lists.osdl.org,
       Zachary Amsden <zach@vmware.com>, Linus Torvalds <torvalds@osdl.org>,
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
Subject: Re: [RFC, PATCH 1/24] i386 Vmi documentation
Message-ID: <20060322215732.GL15997@sorel.sous-sol.org>
References: <200603131759.k2DHxeep005627@zach-dev.vmware.com> <200603222105.58912.ak@suse.de> <20060322213435.GI15997@sorel.sous-sol.org> <200603222213.45910.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200603222213.45910.ak@suse.de>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Andi Kleen (ak@suse.de) wrote:
> Even then it's useless for many flags because any user program can (and will) 
> call CPUID directly. 

Yes, doesn't handle userspace at all.  It's useful only to get coherent
view of flags in kernel.  Right now, for example, Xen goes in and
basically masks off flags retroactively which is not that nice either.

thanks,
-chris
