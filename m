Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268425AbTAMXwx>; Mon, 13 Jan 2003 18:52:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268423AbTAMXwx>; Mon, 13 Jan 2003 18:52:53 -0500
Received: from e33.co.us.ibm.com ([32.97.110.131]:62974 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S268412AbTAMXwv>; Mon, 13 Jan 2003 18:52:51 -0500
Date: Mon, 13 Jan 2003 15:54:18 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: "Protasevich, Natalie" <Natalie.Protasevich@UNISYS.com>,
       Zwane Mwaikambo <zwane@holomorphy.com>,
       "Nakajima, Jun" <jun.nakajima@intel.com>
cc: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>,
       William Lee Irwin III <wli@holomorphy.com>,
       Christoph Hellwig <hch@infradead.org>,
       James Cleverdon <jamesclv@us.ibm.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: RE: APIC version
Message-ID: <421050000.1042502058@flay>
In-Reply-To: <3FAD1088D4556046AEC48D80B47B478C022BD8EB@usslc-exch-4.slc.unisys.com>
References: <3FAD1088D4556046AEC48D80B47B478C022BD8EB@usslc-exch-4.slc.unisys.com>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> If you index it by 4-bit GET_APIC_ID() (not GET_APIC_LOGICAL_ID()), i.e.
> hard_smp_processor_id(), you can get away with it.

Not on clustered mode platforms - the physical address is not unique.
 
> Of course, it is possible that it can just be "don't care":

;-)

M.

