Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261716AbUJ1PY3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261716AbUJ1PY3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Oct 2004 11:24:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261714AbUJ1PXR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Oct 2004 11:23:17 -0400
Received: from atlrel8.hp.com ([156.153.255.206]:2690 "EHLO atlrel8.hp.com")
	by vger.kernel.org with ESMTP id S261708AbUJ1PSb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Oct 2004 11:18:31 -0400
From: Bjorn Helgaas <bjorn.helgaas@hp.com>
To: "Yu, Luming" <luming.yu@intel.com>
Subject: Re: Userspace ACPI interpreter ( was RE: [ACPI] [RFC] dev_acpi: support for userspace access to acpi)
Date: Thu, 28 Oct 2004 09:18:28 -0600
User-Agent: KMail/1.7
Cc: "Brown, Len" <len.brown@intel.com>,
       "Moore, Robert" <robert.moore@intel.com>,
       "Alex Williamson" <alex.williamson@hp.com>,
       "linux-kernel" <linux-kernel@vger.kernel.org>,
       acpi-devel@lists.sourceforge.net
References: <3ACA40606221794F80A5670F0AF15F84041ABFFA@pdsmsx403>
In-Reply-To: <3ACA40606221794F80A5670F0AF15F84041ABFFA@pdsmsx403>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200410280918.28485.bjorn.helgaas@hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 27 October 2004 10:04 pm, Yu, Luming wrote:
> On IA64 platform, ACPI interpreter seems to be mandatory for those
> stuff, but IA32 is not.  So, the ram disk is the generic solution 
> for loading user space interpreter for boot. 

In two sentences: If you want to play with moving the interpreter
to user-space, please do so, and do it on ia64, so you have to
deal with the interesting problems.

And this whole thing is a gigantic tangent that is only distracting
attention from the real question at hand, namely, Alex's dev_acpi
patch, which exists today and enables some very interesting new
functionality.
