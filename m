Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261181AbUKCAxc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261181AbUKCAxc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Nov 2004 19:53:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261248AbUKCAxB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Nov 2004 19:53:01 -0500
Received: from fmr02.intel.com ([192.55.52.25]:56469 "EHLO
	caduceus.fm.intel.com") by vger.kernel.org with ESMTP
	id S261669AbUKBWHj convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Nov 2004 17:07:39 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Subject: RE: [PATCH] IA64 build broken... cond_syscall()... Fixes?
Date: Tue, 2 Nov 2004 14:07:18 -0800
Message-ID: <B8E391BBE9FE384DAA4C5C003888BE6F02510E27@scsmsx401.amr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH] IA64 build broken... cond_syscall()... Fixes?
Thread-Index: AcTAkKy4JIHV46rAQuKsrdYTPENm+wAl2Axg
From: "Luck, Tony" <tony.luck@intel.com>
To: "Peter Chubb" <peterc@gelato.unsw.edu.au>, "Andrew Morton" <akpm@osdl.org>
Cc: <linux-ia64@vger.kernel.org>, <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 02 Nov 2004 22:07:20.0965 (UTC) FILETIME=[53105B50:01C4C128]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>Andrew> Shouldn't we just bite the bullet and hoist all that
>Andrew> cond_syscall stuff out into its own .c file?
>
>OK.  Patch appended.
>
>Signed-off-by: Peter Chubb <peterc@gelato.unsw.edu.au>
>

Acked-by: Tony Luck

No surprise that Peter's fix works for me since I'm building
ia64 systems too.

-Tony
