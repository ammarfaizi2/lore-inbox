Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268382AbTAMWog>; Mon, 13 Jan 2003 17:44:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268385AbTAMWog>; Mon, 13 Jan 2003 17:44:36 -0500
Received: from modemcable092.130-200-24.mtl.mc.videotron.ca ([24.200.130.92]:54616
	"EHLO montezuma.mastecende.com") by vger.kernel.org with ESMTP
	id <S268382AbTAMWob>; Mon, 13 Jan 2003 17:44:31 -0500
Date: Mon, 13 Jan 2003 17:53:20 -0500 (EST)
From: Zwane Mwaikambo <zwane@holomorphy.com>
X-X-Sender: zwane@montezuma.mastecende.com
To: "Nakajima, Jun" <jun.nakajima@intel.com>
cc: "Protasevich, Natalie" <Natalie.Protasevich@UNISYS.com>,
       "Martin J. Bligh" <mbligh@aracnet.com>,
       "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>,
       William Lee Irwin III <wli@holomorphy.com>,
       Christoph Hellwig <hch@infradead.org>,
       James Cleverdon <jamesclv@us.ibm.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: RE: APIC version
In-Reply-To: <3014AAAC8E0930438FD38EBF6DCEB5647D1026@fmsmsx407.fm.intel.com>
Message-ID: <Pine.LNX.4.44.0301131752030.2102-100000@montezuma.mastecende.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 13 Jan 2003, Nakajima, Jun wrote:

> The entries in acpi_version[] are indexed by the APIC id, not 
> smp_processor_id(). So you can overwrite acpi_version[] for a different 
> processor.

Is it possible to use smp_processor_id instead to avoid wasting memory 
for the sparse APIC id case?

	Zwane
-- 
function.linuxpower.ca

