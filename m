Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261256AbVEFSIa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261256AbVEFSIa (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 May 2005 14:08:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261257AbVEFSI3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 May 2005 14:08:29 -0400
Received: from pollux.ds.pg.gda.pl ([153.19.208.7]:61957 "EHLO
	pollux.ds.pg.gda.pl") by vger.kernel.org with ESMTP id S261256AbVEFSI1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 May 2005 14:08:27 -0400
Date: Fri, 6 May 2005 19:08:32 +0100 (BST)
From: "Maciej W. Rozycki" <macro@linux-mips.org>
To: "Protasevich, Natalie" <Natalie.Protasevich@UNISYS.com>
Cc: Len Brown <len.brown@intel.com>, Andrew Morton <akpm@osdl.org>,
       Andi Kleen <ak@suse.de>, Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>,
       linux-kernel@vger.kernel.org
Subject: RE: [patch 1/1] Do not enforce unique IO_APIC_ID for Xeonprocessors
 in EM64T mode (x86_64)
In-Reply-To: <19D0D50E9B1D0A40A9F0323DBFA04ACCE04B4B@USRV-EXCH4.na.uis.unisys.com>
Message-ID: <Pine.LNX.4.61L.0505061904060.25293@blysk.ds.pg.gda.pl>
References: <19D0D50E9B1D0A40A9F0323DBFA04ACCE04B4B@USRV-EXCH4.na.uis.unisys.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 6 May 2005, Protasevich, Natalie wrote:

> Would the APIC version be a good criteria to make a run-time decision
> with Xeons? I know that everything Intel that can run EM64T has front
> side bus (APIC version >= 20?). And I guess the boot parameter can still
> be useful?

 Isn't there a bit in one of the I/O APIC registers which denotes that FSB 
delivery is used?  Hmm, that would be "IO_APIC_reg_00.bits.delivery_type", 
actually...

  Maciej
