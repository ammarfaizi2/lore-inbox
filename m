Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261156AbVBQQoJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261156AbVBQQoJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Feb 2005 11:44:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262307AbVBQQoJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Feb 2005 11:44:09 -0500
Received: from e5.ny.us.ibm.com ([32.97.182.145]:61611 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261156AbVBQQoE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Feb 2005 11:44:04 -0500
Message-ID: <4214C9D0.1090707@us.ibm.com>
Date: Thu, 17 Feb 2005 08:44:00 -0800
From: Vernon Mauery <vernux@us.ibm.com>
User-Agent: Debian Thunderbird 1.0 (X11/20050116)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Carl-Daniel Hailfinger <c-d.hailfinger.devel.2005@gmx.net>
CC: Matthew Garrett <mjg59@srcf.ucam.org>, Len Brown <len.brown@intel.com>,
       Pavel Machek <pavel@suse.cz>,
       ACPI mailing list <acpi-devel@lists.sourceforge.net>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>, seife@suse.de,
       rjw@sisk.pl
Subject: Re: [ACPI] Call for help: list of machines with working S3
References: <20050214211105.GA12808@elf.ucw.cz>	 <1108621005.2096.412.camel@d845pe> <1108638021.4085.143.camel@tyrosine> <4214C3B8.30502@gmx.net>
In-Reply-To: <4214C3B8.30502@gmx.net>
X-Enigmail-Version: 0.90.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Carl-Daniel Hailfinger wrote:
> 1. A first step towards better DSDTs would be to make the ASL compiler
> complain about the same things which are complained about by the
> in-kernel ACPI interpreter. An example would be the following:
> 
> acpi_processor-0496 [10] acpi_processor_get_inf: Invalid PBLK length [7]
> 
> The ASL compiler will not complain about it, yet the kernel will
> refuse to do any processor throttling with a PBLK length of 7.

This is like getting gcc to complain about run-time bugs in a program.  The compiler of a language (ASL in this case) compiles the language, regardless of run-time bugs because it can only detect syntax errors.  And iasl does that pretty well.  

--Vernon
