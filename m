Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261334AbTDDVRQ (for <rfc822;willy@w.ods.org>); Fri, 4 Apr 2003 16:17:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261338AbTDDVRP (for <rfc822;linux-kernel-outgoing>); Fri, 4 Apr 2003 16:17:15 -0500
Received: from air-2.osdl.org ([65.172.181.6]:1762 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261334AbTDDVRM (for <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Apr 2003 16:17:12 -0500
Date: Fri, 4 Apr 2003 13:28:32 +0000
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: "Randy.Dunlap" <rddunlap@osdl.org>
Cc: mikpe@csd.uu.se, mbligh@aracnet.com, robins.t@kutumb.org.in,
       linux-kernel@vger.kernel.org
Subject: Re: [Bug 538] New: Rebooting of pentium-I during initial booting
 phase.
Message-Id: <20030404132832.74ed6aee.rddunlap@osdl.org>
In-Reply-To: <20030404132547.7bda0d49.rddunlap@osdl.org>
References: <200304042052.h34KqZSE021540@harpo.it.uu.se>
	<20030404132547.7bda0d49.rddunlap@osdl.org>
Organization: OSDL
X-Mailer: Sylpheed version 0.8.11 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

| | >Problem Description:
| | >The new kernel 2.5.65 reboots while booting process (in the very initial phase) making even noting the progress very difficult.
| | >The system is running fine with 2.4.21-pre5, with the option "nodma".
| | 
| | Most probably a configuration error, viz. choosing a CPU type
| | higher than generic 586. My Socket7 ASUS T2P4 with a Pentium
| | Classic (pre-MMX) 133MHz boots 2.5.66 just fine.
| 
| Yes, I agree with that suggestion, but I don't see a problem.
| Did you look at his .config file?  It's here:
|   http://bugme.osdl.org/attachment.cgi?id=261&action=view
| 
| I'm comparing it to the .config on my Pentium-with-f00f-bug, which does
| boot 2.5.65 successfully, and I don't see CPU option differences.
| I see lots that don't matter and I see PIIX vs. VIA option differences.
| 
| Oh, and I have CONFIG_VIDEO_DEV enabled, while Robins does not.
| Would that matter?

Ugh, never mind that last part.  I was thinking that was CONSOLE stuff,
but it's not.

--
~Randy
