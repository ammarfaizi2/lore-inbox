Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261346AbTDDVOa (for <rfc822;willy@w.ods.org>); Fri, 4 Apr 2003 16:14:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261349AbTDDVOa (for <rfc822;linux-kernel-outgoing>); Fri, 4 Apr 2003 16:14:30 -0500
Received: from air-2.osdl.org ([65.172.181.6]:60129 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261346AbTDDVO2 (for <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Apr 2003 16:14:28 -0500
Date: Fri, 4 Apr 2003 13:25:47 +0000
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: mikpe@csd.uu.se
Cc: mbligh@aracnet.com, robins.t@kutumb.org.in, linux-kernel@vger.kernel.org
Subject: Re: [Bug 538] New: Rebooting of pentium-I during initial booting
 phase.
Message-Id: <20030404132547.7bda0d49.rddunlap@osdl.org>
In-Reply-To: <200304042052.h34KqZSE021540@harpo.it.uu.se>
References: <200304042052.h34KqZSE021540@harpo.it.uu.se>
Organization: OSDL
X-Mailer: Sylpheed version 0.8.11 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 4 Apr 2003 22:52:35 +0200 (MEST) mikpe@csd.uu.se wrote:

| On Thu, 3 Apr 2003 09:55:34 -0800, mbligh@aracnet.com wrote:
| >http://bugme.osdl.org/show_bug.cgi?id=538
| >
| >           Summary: Rebooting of pentium-I during initial booting phase.
| >    Kernel Version: 2.5.65 (probably most versions of 2.5.x)
| >            Status: NEW
| >          Severity: normal
| >             Owner: mbligh@aracnet.com
| >         Submitter: robins.t@kutumb.org.in
| >
| >
| >Distribution: linus kernel 2.5.65 (probably 2.5.x)
| >
| >Hardware Environment: 
| >Pentium - I (120 MHz) with FO-OF Bug
| >Motherboard Via - With DMA Problem ("nodma" option required in 2.4.x kernels)
| >16mb RAM (EDO)
| >
| >Software Environment:
| >Linus kernel 2.5.65
| >
| >Problem Description:
| >The new kernel 2.5.65 reboots while booting process (in the very initial phase) making even noting the progress very difficult.
| >The system is running fine with 2.4.21-pre5, with the option "nodma".
| 
| Most probably a configuration error, viz. choosing a CPU type
| higher than generic 586. My Socket7 ASUS T2P4 with a Pentium
| Classic (pre-MMX) 133MHz boots 2.5.66 just fine.

Yes, I agree with that suggestion, but I don't see a problem.
Did you look at his .config file?  It's here:
  http://bugme.osdl.org/attachment.cgi?id=261&action=view

I'm comparing it to the .config on my Pentium-with-f00f-bug, which does
boot 2.5.65 successfully, and I don't see CPU option differences.
I see lots that don't matter and I see PIIX vs. VIA option differences.

Oh, and I have CONFIG_VIDEO_DEV enabled, while Robins does not.
Would that matter?

--
~Randy
