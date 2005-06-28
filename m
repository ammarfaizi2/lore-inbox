Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262141AbVF1ROY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262141AbVF1ROY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Jun 2005 13:14:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262163AbVF1RNG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Jun 2005 13:13:06 -0400
Received: from e6.ny.us.ibm.com ([32.97.182.146]:225 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262157AbVF1RDh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Jun 2005 13:03:37 -0400
Subject: Re: 2.6.12 breaks 8139cp
From: Kylene Jo Hall <kjhall@us.ibm.com>
To: Pierre Ossman <drzeus-list@drzeus.cx>
Cc: Bjorn Helgaas <bjorn.helgaas@hp.com>, LKML <linux-kernel@vger.kernel.org>,
       jgarzik@pobox.com, tpmdd-devel@lists.sourceforge.net
In-Reply-To: <42C18022.2010101@drzeus.cx>
References: <42B9D21F.7040908@drzeus.cx>
	 <200506221534.03716.bjorn.helgaas@hp.com> <42BA69AC.5090202@drzeus.cx>
	 <200506231143.34769.bjorn.helgaas@hp.com> <42BB3428.6030708@drzeus.cx>
	 <42C0EE1A.9050809@drzeus.cx>  <42C1434F.2010003@drzeus.cx>
	 <1119967788.6382.7.camel@localhost.localdomain>
	 <42C16162.2070208@drzeus.cx>
	 <1119971339.6382.18.camel@localhost.localdomain>
	 <42C18022.2010101@drzeus.cx>
Content-Type: text/plain
Date: Tue, 28 Jun 2005 12:03:32 -0500
Message-Id: <1119978212.6403.4.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> (btw. does no output in dmesg mean that no TPM chip was found? it seems
> to have found a pci id it likes atleast.)
> 

True I think if a chip is found there should be info in dmesg.  Are you
loading tpm_atmel or tpm_nsc?  You can look at /proc/misc or see
if /sys/class/misc/tpm0 exists.

Do you know if your machine has a TPM?  Is it activated in BIOS?

Thanks,
Kylie

> Rgds
> Pierre
> 

