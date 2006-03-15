Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932559AbWCOXAg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932559AbWCOXAg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Mar 2006 18:00:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751964AbWCOXAg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Mar 2006 18:00:36 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:60039 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1751818AbWCOXAg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Mar 2006 18:00:36 -0500
Date: Thu, 16 Mar 2006 00:00:13 +0100
From: Pavel Machek <pavel@ucw.cz>
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
Subject: Re: [RFC, PATCH 5/24] i386 Vmi code patching
Message-ID: <20060315230012.GA1919@elf.ucw.cz>
References: <200603131802.k2DI2nv8005665@zach-dev.vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200603131802.k2DI2nv8005665@zach-dev.vmware.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> Currently, the system is designed to boot under a fully virtualized
> (or native) environment, then switch into paravirtual mode.  It does
> this by detecting the presence of a ROM code page, invoking the

This is not going to work with xen, is it?

> The question of licensing of such ROM code is a completely separate
> issue.  We are not trying to hide some proprietary code by putting it
> inside of a ROM to keep it hidden.  In fact, you can disassemble the
> ROM code and see it quite readily - and you know all of the entry
> points.

Could you disassemble one entry point for us and describe how it works?

> Whether we can distribute our ROM code under a GPL compatible license
> is not something I know at this time.  Just as you can't compile a
> binary using Linux kernel headers and claim that your binary is not
> subject to the GPL, our ROM code includes headers from other parts of
> our system that are specifically not under the GPL.  How this

VMware is probably sole copyright holder (no?), you are perfectly free
to relicence resulting ROM code under whatever licence you want.



-- 
31:    }
