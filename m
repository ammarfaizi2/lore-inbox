Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261293AbTDDUlZ (for <rfc822;willy@w.ods.org>); Fri, 4 Apr 2003 15:41:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261294AbTDDUlZ (for <rfc822;linux-kernel-outgoing>); Fri, 4 Apr 2003 15:41:25 -0500
Received: from meryl.it.uu.se ([130.238.12.42]:36523 "EHLO meryl.it.uu.se")
	by vger.kernel.org with ESMTP id S261293AbTDDUlY (for <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Apr 2003 15:41:24 -0500
Date: Fri, 4 Apr 2003 22:52:35 +0200 (MEST)
Message-Id: <200304042052.h34KqZSE021540@harpo.it.uu.se>
From: mikpe@csd.uu.se
To: bugme-daemon@osdl.org, mbligh@aracnet.com, robins.t@kutumb.org.in
Subject: Re: [Bug 538] New: Rebooting of pentium-I during initial booting phase.
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 3 Apr 2003 09:55:34 -0800, mbligh@aracnet.com wrote:
>http://bugme.osdl.org/show_bug.cgi?id=538
>
>           Summary: Rebooting of pentium-I during initial booting phase.
>    Kernel Version: 2.5.65 (probably most versions of 2.5.x)
>            Status: NEW
>          Severity: normal
>             Owner: mbligh@aracnet.com
>         Submitter: robins.t@kutumb.org.in
>
>
>Distribution: linus kernel 2.5.65 (probably 2.5.x)
>
>Hardware Environment: 
>Pentium - I (120 MHz) with FO-OF Bug
>Motherboard Via - With DMA Problem ("nodma" option required in 2.4.x kernels)
>16mb RAM (EDO)
>
>Software Environment:
>Linus kernel 2.5.65
>
>Problem Description:
>The new kernel 2.5.65 reboots while booting process (in the very initial phase) making even noting the progress very difficult.
>The system is running fine with 2.4.21-pre5, with the option "nodma".

Most probably a configuration error, viz. choosing a CPU type
higher than generic 586. My Socket7 ASUS T2P4 with a Pentium
Classic (pre-MMX) 133MHz boots 2.5.66 just fine.

/Mikael
