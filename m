Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751708AbWGZRPI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751708AbWGZRPI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Jul 2006 13:15:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751711AbWGZRPI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Jul 2006 13:15:08 -0400
Received: from ns1.suse.de ([195.135.220.2]:3712 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751708AbWGZRPG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Jul 2006 13:15:06 -0400
From: Andi Kleen <ak@suse.de>
To: "Brown, Len" <len.brown@intel.com>
Subject: Re: smp + acpi
Date: Wed, 26 Jul 2006 19:13:25 +0200
User-Agent: KMail/1.9.3
Cc: "Marco Berizzi" <pupilla@hotmail.com>, linux-kernel@vger.kernel.org
References: <CFF307C98FEABE47A452B27C06B85BB60112506C@hdsmsx411.amr.corp.intel.com>
In-Reply-To: <CFF307C98FEABE47A452B27C06B85BB60112506C@hdsmsx411.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200607261913.25806.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> CONFIG_ACPI=y is necessary to parse the ACPI tables
> and discover HT siblings.  Except for the rare BIOS
> that gives the option to enumerate HT via MPS
> (thus breaking some versions of Windows),
> enabling ACPI is the only way to enable HT.
> 
> Yes, in the distant past, CONFIG_ACPI=n did not remove
> all ACPI code from your kernel, and that was a bug.

Ok thanks for the confirmation.

However the proposed change would be still wrong because
SMP can be without HT.

-Andi
