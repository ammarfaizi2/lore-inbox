Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946171AbWJSQMd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946171AbWJSQMd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Oct 2006 12:12:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946173AbWJSQMd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Oct 2006 12:12:33 -0400
Received: from ns2.suse.de ([195.135.220.15]:30893 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1946171AbWJSQMc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Oct 2006 12:12:32 -0400
From: Andi Kleen <ak@suse.de>
To: "Allen Martin" <AMartin@nvidia.com>
Subject: Re: ASUS M2NPV-VM APIC/ACPI Bug (patched)
Date: Thu, 19 Oct 2006 18:11:49 +0200
User-Agent: KMail/1.9.3
Cc: "Robert Hancock" <hancockr@shaw.ca>, "Len Brown" <lenb@kernel.org>,
       "linux-kernel" <linux-kernel@vger.kernel.org>,
       "Daniel Mierswa" <impulze@impulze.org>,
       "Andy Currid" <ACurrid@nvidia.com>
References: <DBFABB80F7FD3143A911F9E6CFD477B0195D13E6@hqemmail02.nvidia.com>
In-Reply-To: <DBFABB80F7FD3143A911F9E6CFD477B0195D13E6@hqemmail02.nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200610191811.49243.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> The problem is this workaround doesn't fix a chipset issue, it fixes
> incorrect entries in the BIOS ACPI tables.  This bug existed in the
> NVIDIA reference BIOS for nForce2 and got copied to all customer BIOSes
> for nForce2.  Even though our reference BIOSes and documentation for all
> chipsets since then have the correct interrupt overrides in the ACPI
> tables we still see customer BIOSes that get shipped with incorrect
> entries that were probably copied from their nForce2 BIOS code.

Ah my understanding was that it applied to NF3 and possible NF4 too. Does it 
not?
 
> I believe the HPET check was because the workaround was causing problems
> when enabling HPET on systems that support it.  Andy probably has more
> details on that.

Yes it was because NF5 needed it to be disabled. Anyways if I can 
get a list of PCI-IDs of chipsets where the reference BIOS had this
issue it can be narrowed to those.

-Andi
