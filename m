Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262783AbUJ1FiJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262783AbUJ1FiJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Oct 2004 01:38:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262790AbUJ1FiJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Oct 2004 01:38:09 -0400
Received: from fmr11.intel.com ([192.55.52.31]:3781 "EHLO
	fmsfmr004.fm.intel.com") by vger.kernel.org with ESMTP
	id S262787AbUJ1FiE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Oct 2004 01:38:04 -0400
Message-ID: <418085B0.30208@intel.com>
Date: Thu, 28 Oct 2004 01:37:52 -0400
From: Len Brown <len.brown@intel.com>
User-Agent: Mozilla Thunderbird 0.8 (X11/20040913)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Yu, Luming" <luming.yu@intel.com>
CC: Bjorn Helgaas <bjorn.helgaas@hp.com>,
       "Moore, Robert" <robert.moore@intel.com>,
       Alex Williamson <alex.williamson@hp.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       acpi-devel@lists.sourceforge.net
Subject: Re: Userspace ACPI interpreter ( was RE: [ACPI] [RFC] dev_acpi: support
 for userspace access to acpi)
References: <3ACA40606221794F80A5670F0AF15F84041ABFFA@pdsmsx403>
In-Reply-To: <3ACA40606221794F80A5670F0AF15F84041ABFFA@pdsmsx403>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

One way to experiment with a user-mode ACPI interpreter would be to 
continue to use the kernel-mode interpreter for boot up , and cut over 
to the user-mode interpreter at /sbin/init.  The kernel-mode interpreter 
could be sent the way of free_initmem() which is called just before 
/sbin/init is invoked.

-Len

