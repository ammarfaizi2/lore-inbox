Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932306AbWCWAkJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932306AbWCWAkJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Mar 2006 19:40:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932686AbWCWAkJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Mar 2006 19:40:09 -0500
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:2177 "EHLO
	sorel.sous-sol.org") by vger.kernel.org with ESMTP id S932306AbWCWAkH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Mar 2006 19:40:07 -0500
Date: Wed, 22 Mar 2006 16:40:06 -0800
From: Chris Wright <chrisw@sous-sol.org>
To: Anthony Liguori <aliguori@us.ibm.com>
Cc: Chris Wright <chrisw@sous-sol.org>, Andi Kleen <ak@suse.de>,
       Xen-devel <xen-devel@lists.xensource.com>,
       Wim Coekaerts <wim.coekaerts@oracle.com>,
       Christopher Li <chrisl@vmware.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       virtualization@lists.osdl.org, Linus Torvalds <torvalds@osdl.org>,
       Anne Holler <anne@vmware.com>, Jan Beulich <jbeulich@novell.com>,
       Jyothy Reddy <jreddy@vmware.com>, Kip Macy <kmacy@fsmware.com>,
       Ky Srinivasan <ksrinivasan@novell.com>,
       Leendert van Doorn <leendert@watson.ibm.com>
Subject: Re: [RFC, PATCH 5/24] i386 Vmi code patching
Message-ID: <20060323004006.GQ15997@sorel.sous-sol.org>
References: <200603131802.k2DI2nv8005665@zach-dev.vmware.com> <200603222115.46926.ak@suse.de> <20060322214025.GJ15997@sorel.sous-sol.org> <4421EC44.7010500@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4421EC44.7010500@us.ibm.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Anthony Liguori (aliguori@us.ibm.com) wrote:
> Would you have less trouble if the "ROM" were actually more like a 
> module?  Specifically, if it had a proper elf header and symbol table, 
> used symbols as entry points, and was a GPL interface (so that ROM's had 
> to be GPL)?  Then it's just a kernel module that's hidden in the option 
> ROM space and has a C interface.

Yeah, point is the interface is normal C API, and has the similar free
form that normal kernel API's have.

thanks,
-chris
