Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965015AbVIHVjL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965015AbVIHVjL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Sep 2005 17:39:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965016AbVIHVjL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Sep 2005 17:39:11 -0400
Received: from fmr16.intel.com ([192.55.52.70]:64727 "EHLO
	fmsfmr006.fm.intel.com") by vger.kernel.org with ESMTP
	id S965013AbVIHVjI convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Sep 2005 17:39:08 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Subject: RE: [RFC] Consistently use the name asm-offsets.h
Date: Thu, 8 Sep 2005 14:39:04 -0700
Message-ID: <B8E391BBE9FE384DAA4C5C003888BE6F0456EE9E@scsmsx401.amr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [RFC] Consistently use the name asm-offsets.h
Thread-Index: AcW0uu1IFyla8nQWTVuc2s/m9jj0WwAAmGFg
From: "Luck, Tony" <tony.luck@intel.com>
To: "Sam Ravnborg" <sam@ravnborg.org>, <linux-arch@vger.kernel.org>,
       <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 08 Sep 2005 21:39:03.0401 (UTC) FILETIME=[BB4B2590:01C5B4BD]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The existing ia64 specific rule to generate offsets.h
has to "echo #define IA64_TASK_SIZE 0 > include/asm-ia64/offsets.h"
before building asm-offsets.s to avoid compilation errors.

So long as you take care of this somehow in the generic version, go wild.

-Tony
