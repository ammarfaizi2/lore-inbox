Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422847AbWJPTJu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422847AbWJPTJu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Oct 2006 15:09:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422846AbWJPTJu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Oct 2006 15:09:50 -0400
Received: from mga03.intel.com ([143.182.124.21]:664 "EHLO mga03.intel.com")
	by vger.kernel.org with ESMTP id S1422845AbWJPTJt convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Oct 2006 15:09:49 -0400
X-ExtLoop1: 1
X-IronPort-AV: i="4.09,316,1157353200"; 
   d="scan'208"; a="131747656:sNHT19141892"
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: [PATCH] CONFIG_TELCLOCK depends on X86
Date: Mon, 16 Oct 2006 12:09:47 -0700
Message-ID: <5389061B65D50446B1783B97DFDB392D0310E38A@orsmsx411.amr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH] CONFIG_TELCLOCK depends on X86
thread-index: AcbxTN//fQjNsh9FR9ysFjdU8W/9cgACWSLQ
From: "Gross, Mark" <mark.gross@intel.com>
To: <geert@linux-m68k.org>, "Linus Torvalds" <torvalds@osdl.org>,
       "Andrew Morton" <akpm@osdl.org>
Cc: "Linux Kernel Development" <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 16 Oct 2006 19:09:47.0871 (UTC) FILETIME=[A5DAF6F0:01C6F156]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is good.  

Thank you for doing this.

Acked-by: Mark Gross <mark.gross@intel.com>

--mgross

>-----Original Message-----
>From: geert@linux-m68k.org [mailto:geert@linux-m68k.org]
>Sent: Monday, October 16, 2006 11:00 AM
>To: Linus Torvalds; Andrew Morton
>Cc: Linux Kernel Development; Gross, Mark
>Subject: [PATCH] CONFIG_TELCLOCK depends on X86
>
>
>The telecom clock driver for MPBL0010 ATCA SBC depends on X86
>
>Signed-Off-By: Geert Uytterhoeven <geert@linux-m68k.org>
>Cc: Mark Gross <mark.gross@intel.com>
>
>--- linux-2.6.19-rc2/drivers/char/Kconfig.orig	2006-10-05
11:16:43.000000000 +0200
>+++ linux-2.6.19-rc2/drivers/char/Kconfig	2006-10-16
09:26:10.000000000 +0200
>@@ -1046,7 +1046,7 @@ source "drivers/char/tpm/Kconfig"
>
> config TELCLOCK
> 	tristate "Telecom clock driver for MPBL0010 ATCA SBC"
>-	depends on EXPERIMENTAL
>+	depends on EXPERIMENTAL && X86
> 	default n
> 	help
> 	  The telecom clock device is specific to the MPBL0010 ATCA
computer and
>
>--
>Geert Uytterhoeven -- There's lots of Linux beyond ia32 --
geert@linux-m68k.org
>
>In personal conversations with technical people, I call myself a
hacker. But
>when I'm talking to journalists I just say "programmer" or something
like that.
>							    -- Linus
Torvalds
