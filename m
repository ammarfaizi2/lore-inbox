Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261736AbUJ1P1a@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261736AbUJ1P1a (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Oct 2004 11:27:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261171AbUJ1PYp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Oct 2004 11:24:45 -0400
Received: from THUNK.ORG ([69.25.196.29]:31175 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id S261715AbUJ1PYU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Oct 2004 11:24:20 -0400
Date: Thu, 28 Oct 2004 11:24:04 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: Len Brown <len.brown@intel.com>
Cc: "Yu, Luming" <luming.yu@intel.com>, Bjorn Helgaas <bjorn.helgaas@hp.com>,
       "Moore, Robert" <robert.moore@intel.com>,
       Alex Williamson <alex.williamson@hp.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       acpi-devel@lists.sourceforge.net
Subject: Re: Userspace ACPI interpreter ( was RE: [ACPI] [RFC] dev_acpi: support for userspace access to acpi)
Message-ID: <20041028152404.GB7902@thunk.org>
Mail-Followup-To: Theodore Ts'o <tytso@mit.edu>,
	Len Brown <len.brown@intel.com>, "Yu, Luming" <luming.yu@intel.com>,
	Bjorn Helgaas <bjorn.helgaas@hp.com>,
	"Moore, Robert" <robert.moore@intel.com>,
	Alex Williamson <alex.williamson@hp.com>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	acpi-devel@lists.sourceforge.net
References: <3ACA40606221794F80A5670F0AF15F84041ABFFA@pdsmsx403> <418085B0.30208@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <418085B0.30208@intel.com>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 28, 2004 at 01:37:52AM -0400, Len Brown wrote:
> One way to experiment with a user-mode ACPI interpreter would be to 
> continue to use the kernel-mode interpreter for boot up , and cut over 
> to the user-mode interpreter at /sbin/init.  The kernel-mode interpreter 
> could be sent the way of free_initmem() which is called just before 
> /sbin/init is invoked.

Is there a significant advantage to doing having a user-mode ACPI
interpreter?  The only advantage I can think of is that the ACPI
interpreter could now live in pageable memory.  Are there any others?

					- Ted
