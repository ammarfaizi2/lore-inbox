Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751170AbWCOXbe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751170AbWCOXbe (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Mar 2006 18:31:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752161AbWCOXbe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Mar 2006 18:31:34 -0500
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:26241 "EHLO
	sorel.sous-sol.org") by vger.kernel.org with ESMTP id S1751170AbWCOXbd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Mar 2006 18:31:33 -0500
Date: Wed, 15 Mar 2006 15:36:05 -0800
From: Chris Wright <chrisw@sous-sol.org>
To: Pavel Machek <pavel@ucw.cz>
Cc: Zachary Amsden <zach@vmware.com>, Linus Torvalds <torvalds@osdl.org>,
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
Subject: Re: [RFC, PATCH 9/24] i386 Vmi smp support
Message-ID: <20060315233605.GA15997@sorel.sous-sol.org>
References: <200603131805.k2DI5wlO005693@zach-dev.vmware.com> <20060315231755.GB1919@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060315231755.GB1919@elf.ucw.cz>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Pavel Machek (pavel@ucw.cz) wrote:
> > +#include <asm/io.h>
> > +#include <asm/highmem.h>
> > +#include <asm/pgtable.h>
> > +#include <vmi.h>
> 
> How it is possible that vmi.h is included without path?

That's how subarch works (although typically looks like <mach_vmi.h>)

thanks,
-chris
