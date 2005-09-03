Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161129AbVICEXB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161129AbVICEXB (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Sep 2005 00:23:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161128AbVICEXB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Sep 2005 00:23:01 -0400
Received: from fmr16.intel.com ([192.55.52.70]:4017 "EHLO
	fmsfmr006.fm.intel.com") by vger.kernel.org with ESMTP
	id S1161120AbVICEXA convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Sep 2005 00:23:00 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Subject: RE: 2.6.13-mm1: hangs during boot ...
Date: Sat, 3 Sep 2005 00:22:47 -0400
Message-ID: <F7DC2337C7631D4386A2DF6E8FB22B30047FA061@hdsmsx401.amr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: 2.6.13-mm1: hangs during boot ...
Thread-Index: AcWwPozCogwClmPGTq+OvQET14BsyQAAGSVw
From: "Brown, Len" <len.brown@intel.com>
To: "Andrew Morton" <akpm@osdl.org>,
       "Peter Williams" <pwil3058@bigpond.net.au>
Cc: <linux-kernel@vger.kernel.org>,
       "James Bottomley" <James.Bottomley@steeleye.com>,
       <linux-scsi@vger.kernel.org>
X-OriginalArrivalTime: 03 Sep 2005 04:22:49.0404 (UTC) FILETIME=[24A357C0:01C5B03F]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > [  279.662960]  [<c02d5c74>] wait_for_completion+0xa4/0x110

possibly a missing interrupt?

> CONFIG_ACPI=y

any difference if booted with "acpi=off" or "acpi=noirq"?
