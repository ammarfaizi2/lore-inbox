Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262358AbTEPVjm (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 May 2003 17:39:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262676AbTEPVjm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 May 2003 17:39:42 -0400
Received: from fmr06.intel.com ([134.134.136.7]:53968 "EHLO
	caduceus.jf.intel.com") by vger.kernel.org with ESMTP
	id S262358AbTEPVjl convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 May 2003 17:39:41 -0400
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
x-mimeole: Produced By Microsoft Exchange V6.0.6375.0
Subject: APM sysenter MSR restore patch breaks ACPI
Date: Fri, 16 May 2003 14:52:27 -0700
Message-ID: <F760B14C9561B941B89469F59BA3A84725A2A5@orsmsx401.jf.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: APM sysenter MSR restore patch breaks ACPI
Thread-Index: AcMb9XBGEv9l/zRUQP6rmGvEZC9VMA==
From: "Grover, Andrew" <andrew.grover@intel.com>
To: <mikepe@csd.uu.se>
Cc: <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 16 May 2003 21:52:27.0941 (UTC) FILETIME=[715DB550:01C31BF5]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I think moving the saved_context_* variables into suspend_asm.S broke
the build if CONFIG_ACPI and CONFIG_SOFTWARE_SUSPEND. It looks like
arch/i386/kernel/acpi/wakeup.S makes use of those, too.

Could you fix this?

Thanks -- Regards -- Andy

-----------------------------
Andrew Grover
Intel Labs / Mobile Architecture
andrew.grover@intel.com

