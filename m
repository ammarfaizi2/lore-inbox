Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261886AbVBOVIl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261886AbVBOVIl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Feb 2005 16:08:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261888AbVBOVIl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Feb 2005 16:08:41 -0500
Received: from postman.ripe.net ([193.0.0.199]:32992 "EHLO postman.ripe.net")
	by vger.kernel.org with ESMTP id S261886AbVBOVIj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Feb 2005 16:08:39 -0500
Message-ID: <42126506.8020407@colitti.com>
Date: Tue, 15 Feb 2005 22:09:26 +0100
From: Lorenzo Colitti <lorenzo@colitti.com>
User-Agent: Mozilla Thunderbird 1.0RC1 (X11/20041201)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: Alistair John Strachan <s0348365@sms.ed.ac.uk>,
       Pavel Machek <pavel@suse.cz>,
       ACPI mailing list <acpi-devel@lists.sourceforge.net>,
       kernel list <linux-kernel@vger.kernel.org>, seife@suse.de, rjw@sisk.pl
Subject: Re: [ACPI] Re: Call for help: list of machines with working S3
References: <20050214211105.GA12808@elf.ucw.cz>	 <1108482083.12031.10.camel@elrond.flymine.org>	 <42122054.8010408@colitti.com>  <200502151742.55362.s0348365@sms.ed.ac.uk> <1108500194.12031.21.camel@elrond.flymine.org>
In-Reply-To: <1108500194.12031.21.camel@elrond.flymine.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-RIPE-Spam-Level: 
X-RIPE-Spam-Tests: ALL_TRUSTED,BAYES_00
X-RIPE-Spam-Status: N 0.146646 / -5.9
X-RIPE-Signature: 91f993dfd611ee7cc8f8200dbe9a98ef
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matthew Garrett wrote:
>>                Vendor: Hewlett-Packard
>>-               Version: 68BDD Ver. F.0F
>>-               Release Date: 07/23/2004
>>+               Version: 68BDD Ver. F.11
>>+               Release Date: 11/22/2004
> 
> 
> Ok, so you both have different BIOS versions and different CPUs.

S3 works for me with both BIOS F.0F, which I was using before, and F.11, 
which I flashed today after learning it existed.

> Everything else looks pretty identical. Could you both
> stick /proc/acpi/dsdt up somewhere so I can check if there are any
> relevant looking differences?

I would advise trying to compile a custom kernel from scratch with my 
.config first.

I got S3 working first with a very basic kernel config, but I couldn't 
get it to work with my usual kernel. Assuming it was some feature that 
caused the problem, I started disabling features in the hope of getting 
it to work, but I ended up with two different kernels with seemingly 
irrelevant differences, of which one would succesfully resume and one 
wouldn't. So I started added features to the other kernel, and I never 
found out what caused the problem.

I'm not saying that this is not deterministic, but I am saying that, at 
least in my case, it's not obvious what it is that stops S3 from 
working. :-)


Cheers,
Lorenzo
