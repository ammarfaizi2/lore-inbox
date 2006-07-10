Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965155AbWGJPvW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965155AbWGJPvW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jul 2006 11:51:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965156AbWGJPvV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jul 2006 11:51:21 -0400
Received: from mga02.intel.com ([134.134.136.20]:52915 "EHLO
	orsmga101-1.jf.intel.com") by vger.kernel.org with ESMTP
	id S964906AbWGJPvU convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jul 2006 11:51:20 -0400
X-IronPort-AV: i="4.06,223,1149490800"; 
   d="scan'208"; a="62956811:sNHT21654167430"
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5
Subject: RE: [linux-pm] [BUG] sleeping function called from invalid context during resume
Date: Mon, 10 Jul 2006 11:51:00 -0400
Message-ID: <CFF307C98FEABE47A452B27C06B85BB6ECFDB0@hdsmsx411.amr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [linux-pm] [BUG] sleeping function called from invalid context during resume
Thread-Index: AcakNzIaEt8gxdPFTdCuRgv7/pvyDAAATufg
From: "Brown, Len" <len.brown@intel.com>
To: "Alan Stern" <stern@rowland.harvard.edu>
Cc: "Pavel Machek" <pavel@ucw.cz>, "Andrew Morton" <akpm@osdl.org>,
       <johnstul@us.ibm.com>, <linux-pm@lists.osdl.org>,
       <linux-kernel@vger.kernel.org>, <linux-acpi@vger.kernel.org>
X-OriginalArrivalTime: 10 Jul 2006 15:51:03.0871 (UTC) FILETIME=[A61D74F0:01C6A438]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 
>> http://bugzilla.kernel.org/show_bug.cgi?id=3469
>> 
>> Make acpi_os_allocate() into an inline function to
>> allow /proc/slab_allocators to work.
>
>Another problem with this patch; it doesn't compile.

Hmmm, to you refer to the patch on the bug-id, the one
in e-mail, or the one checked into git?

My appologies if they don't match.  I've compiled 
this into a few dozen kernels at this point.

thanks,
-Len
