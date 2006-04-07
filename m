Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964948AbWDGUyS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964948AbWDGUyS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Apr 2006 16:54:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964843AbWDGUyS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Apr 2006 16:54:18 -0400
Received: from mga06.intel.com ([134.134.136.21]:64667 "EHLO
	orsmga101.jf.intel.com") by vger.kernel.org with ESMTP
	id S964948AbWDGUyR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Apr 2006 16:54:17 -0400
TrustExchangeSourcedMail: True
X-ExchangeTrusted: True
X-IronPort-AV: i="4.04,98,1144047600"; 
   d="scan'208"; a="20727861:sNHT20143907"
Date: Fri, 7 Apr 2006 13:53:27 -0700
From: Ashok Raj <ashok.raj@intel.com>
To: jensmh@gmx.de
Cc: Ashok Raj <ashok.raj@intel.com>, Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.16.1 lost cpu, was: 2.6.16-rc5 'lost' cpu
Message-ID: <20060407135327.A27253@unix-os.sc.intel.com>
References: <Pine.LNX.4.64.0603030954230.28074@montezuma.fsmlabs.com> <200604071845.38371.jensmh@gmx.de> <20060407132206.A27131@unix-os.sc.intel.com> <200604072227.58594.jensmh@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200604072227.58594.jensmh@gmx.de>; from jensmh@gmx.de on Fri, Apr 07, 2006 at 10:27:56PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 07, 2006 at 10:27:56PM +0200, jensmh@gmx.de wrote:
> Ashok Raj writes:
> > On Fri, Apr 07, 2006 at 06:45:36PM +0200, jensmh@gmx.de wrote:
> > 
> > Oh well, seems like that CPU has trouble booting, per message below
> > we seemed to start it, but processor didnt run startup code... Suspect its a 
> > failing part probably..
> > 
> > > CPU1: Intel P4/Xeon Extended MCE MSRs (12) available
> > > CPU1: Thermal monitoring enabled
> > > CPU1: Intel(R) Xeon(TM) CPU 2.80GHz stepping 09
> > > Booting processor 2/6 eip 2000
> 
> shouldn't that be "Booting processor 2/_4_ eip 2000"?

I agree the message is not clear.. but the number is the APIC id of the cpu
its trying to boot..


ACPI: LAPIC (acpi_id[0x01] lapic_id[0x00] enabled)
Processor #0 15:2 APIC version 20
ACPI: LAPIC (acpi_id[0x02] lapic_id[0x06] enabled)
-----------------------------------^^^^^^^

Processor #6 15:2 APIC version 20
ACPI: LAPIC (acpi_id[0x03] lapic_id[0x01] enabled)
Processor #1 15:2 APIC version 20
ACPI: LAPIC (acpi_id[0x04] lapic_id[0x07] enabled)
Processor #7 15:2 APIC version 20
