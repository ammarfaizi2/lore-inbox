Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262328AbVBQUON@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262328AbVBQUON (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Feb 2005 15:14:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262322AbVBQUOM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Feb 2005 15:14:12 -0500
Received: from imap.gmx.net ([213.165.64.20]:12468 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S261197AbVBQULk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Feb 2005 15:11:40 -0500
X-Authenticated: #26200865
Message-ID: <4214FAE9.9090003@gmx.net>
Date: Thu, 17 Feb 2005 21:13:29 +0100
From: Carl-Daniel Hailfinger <c-d.hailfinger.devel.2005@gmx.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de-AT; rv:1.7.2) Gecko/20040906
X-Accept-Language: de, en
MIME-Version: 1.0
To: Vernon Mauery <vernux@us.ibm.com>
CC: Matthew Garrett <mjg59@srcf.ucam.org>, Len Brown <len.brown@intel.com>,
       Pavel Machek <pavel@suse.cz>,
       ACPI mailing list <acpi-devel@lists.sourceforge.net>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>, seife@suse.de,
       rjw@sisk.pl
Subject: Re: [ACPI] Call for help: list of machines with working S3
References: <20050214211105.GA12808@elf.ucw.cz>	 <1108621005.2096.412.camel@d845pe> <1108638021.4085.143.camel@tyrosine> <4214C3B8.30502@gmx.net> <4214C9D0.1090707@us.ibm.com>
In-Reply-To: <4214C9D0.1090707@us.ibm.com>
X-Enigmail-Version: 0.86.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Vernon Mauery schrieb:
> Carl-Daniel Hailfinger wrote:
> 
>>1. A first step towards better DSDTs would be to make the ASL compiler
>>complain about the same things which are complained about by the
>>in-kernel ACPI interpreter. An example would be the following:
>>
>>acpi_processor-0496 [10] acpi_processor_get_inf: Invalid PBLK length [7]
>>
>>The ASL compiler will not complain about it, yet the kernel will
>>refuse to do any processor throttling with a PBLK length of 7.
> 
> 
> This is like getting gcc to complain about run-time bugs in a program.

Oh, gcc does that to a certain extent. For example, it has warnings
like "this comparison is always true" or "value too big for selected
type".


> The compiler of a language (ASL in this case) compiles the language,
> regardless of run-time bugs because it can only detect syntax errors.
> And iasl does that pretty well.  

It is possible to do quite a bit of semantic verification at compile
time, but of course there are limits to everything.


Regards,
Carl-Daniel
-- 
http://www.hailfinger.org/
