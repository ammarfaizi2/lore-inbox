Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262379AbVF2HDr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262379AbVF2HDr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Jun 2005 03:03:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262453AbVF2HDr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Jun 2005 03:03:47 -0400
Received: from [85.8.12.41] ([85.8.12.41]:24249 "EHLO smtp.drzeus.cx")
	by vger.kernel.org with ESMTP id S262379AbVF2HDn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Jun 2005 03:03:43 -0400
Message-ID: <42C247AE.6060406@drzeus.cx>
Date: Wed, 29 Jun 2005 09:03:10 +0200
From: Pierre Ossman <drzeus-list@drzeus.cx>
User-Agent: Mozilla Thunderbird 1.0.2-7 (X11/20050623)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Kylene Jo Hall <kjhall@us.ibm.com>
CC: LKML <linux-kernel@vger.kernel.org>, tpmdd-devel@lists.sourceforge.net
Subject: Re: 2.6.12 breaks 8139cp
References: <42B9D21F.7040908@drzeus.cx>	 <200506221534.03716.bjorn.helgaas@hp.com> <42BA69AC.5090202@drzeus.cx>	 <200506231143.34769.bjorn.helgaas@hp.com> <42BB3428.6030708@drzeus.cx>	 <42C0EE1A.9050809@drzeus.cx>  <42C1434F.2010003@drzeus.cx>	 <1119967788.6382.7.camel@localhost.localdomain>	 <42C16162.2070208@drzeus.cx>	 <1119971339.6382.18.camel@localhost.localdomain>	 <42C18022.2010101@drzeus.cx> <1119978212.6403.4.camel@localhost.localdomain>
In-Reply-To: <1119978212.6403.4.camel@localhost.localdomain>
X-Enigmail-Version: 0.90.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kylene Jo Hall wrote:

>>(btw. does no output in dmesg mean that no TPM chip was found? it seems
>>to have found a pci id it likes atleast.)
>>
>>    
>>
>
>True I think if a chip is found there should be info in dmesg.  Are you
>loading tpm_atmel or tpm_nsc?  You can look at /proc/misc or see
>if /sys/class/misc/tpm0 exists.
>  
>

I'm using tpm_atmel (its PCI id list matches my LPC bridge). Nothing
shows up in /proc or /sys though.

>Do you know if your machine has a TPM?  Is it activated in BIOS?
>
>  
>

Haven't the slightest. :)
My BIOS is barely advanced enough to configure the clock. So no fancy
stuff like enabling/disabling parts of the hardware. ;)

Rgds
Pierre

