Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964844AbWEOQ4l@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964844AbWEOQ4l (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 May 2006 12:56:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964900AbWEOQ4l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 May 2006 12:56:41 -0400
Received: from mga02.intel.com ([134.134.136.20]:34714 "EHLO
	orsmga101-1.jf.intel.com") by vger.kernel.org with ESMTP
	id S964844AbWEOQ4l convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 May 2006 12:56:41 -0400
X-IronPort-AV: i="4.05,130,1146466800"; 
   d="scan'208"; a="36488099:sNHT5181764847"
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: [PATCH for 2.6.17] [3/5] i386/x86_64: Force pci=noacpi on HP  XW9300
Date: Mon, 15 May 2006 12:47:31 -0400
Message-ID: <CFF307C98FEABE47A452B27C06B85BB670FA6C@hdsmsx411.amr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH for 2.6.17] [3/5] i386/x86_64: Force pci=noacpi on HP  XW9300
Thread-Index: AcZ4PDGsVr6RFR0MQ7Cr981Tiz8fxgAAoRrg
From: "Brown, Len" <len.brown@intel.com>
To: <ak@suse.de>, <torvalds@osdl.org>
Cc: <akpm@osdl.org>, <linux-kernel@vger.kernel.org>, <gregkh@suse.de>
X-OriginalArrivalTime: 15 May 2006 16:47:32.0046 (UTC) FILETIME=[427DEEE0:01C6783F]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>The system has multiple PCI segments and we don't handle that properly
>yet in PCI and ACPI. Short term before this is fixed blacklist it to
>pci=noacpi.

I'm okay with the patch, but it makes me wonder...

Is this the 1st/only system Linux has run on with multiple PCI segments?
What are your expectations for where "short-term" ends and "long-term"
begins?

thanks,
-Len
