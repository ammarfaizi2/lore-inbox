Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261721AbVHBTLx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261721AbVHBTLx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Aug 2005 15:11:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261724AbVHBTLx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Aug 2005 15:11:53 -0400
Received: from fmr14.intel.com ([192.55.52.68]:6366 "EHLO
	fmsfmr002.fm.intel.com") by vger.kernel.org with ESMTP
	id S261721AbVHBTLu convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Aug 2005 15:11:50 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: removal of sys_set_zone_reclaim
Date: Tue, 2 Aug 2005 12:11:39 -0700
Message-ID: <B8E391BBE9FE384DAA4C5C003888BE6F040BF373@scsmsx401.amr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: removal of sys_set_zone_reclaim
Thread-Index: AcWXlgLE0srj5uhKQw296yCxzsyznA==
From: "Luck, Tony" <tony.luck@intel.com>
To: "Ingo Molnar" <mingo@elte.hu>, "Linus Torvalds" <torvalds@osdl.org>
Cc: <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 02 Aug 2005 19:11:39.0259 (UTC) FILETIME=[027D6CB0:01C59796]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The definition of __NR_set_zone_reclaim is still in the i386 and
ia64 versions of <asm/unistd.h>.  Was this intentional (keep the
system call number reserved in case this is resurrected), or just
an oversight in the removal patch?

-Tony
