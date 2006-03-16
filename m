Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964844AbWCPTLe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964844AbWCPTLe (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Mar 2006 14:11:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964838AbWCPTLe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Mar 2006 14:11:34 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:14762 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S964844AbWCPTLd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Mar 2006 14:11:33 -0500
Date: Thu, 16 Mar 2006 20:10:56 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Zachary Amsden <zach@vmware.com>
cc: Linus Torvalds <torvalds@osdl.org>,
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
Subject: Re: [RFC, PATCH 5/24] i386 Vmi code patching
In-Reply-To: <200603131802.k2DI2nv8005665@zach-dev.vmware.com>
Message-ID: <Pine.LNX.4.61.0603162008300.11776@yvahk01.tjqt.qr>
References: <200603131802.k2DI2nv8005665@zach-dev.vmware.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>
>The question of licensing of such ROM code is a completely separate
>issue.  We are not trying to hide some proprietary code by putting it
>inside of a ROM to keep it hidden.  In fact, you can disassemble the
>ROM code and see it quite readily - and you know all of the entry points.
>Whether we can distribute our ROM code under a GPL compatible license
>is not something I know at this time.  Just as you can't compile a
>binary using Linux kernel headers and claim that your binary is not
>subject to the GPL, our ROM code includes headers from other parts of
>our system that are specifically not under the GPL.  How this affects
>the final license under which the ROM is distributed is not something
>I think we know at this time.

The code _you_ wrote can be put under any license(s) you want, so in
the worst case you do not need to rewrite your .c files.


Jan Engelhardt
-- 
