Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268812AbUJPTxX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268812AbUJPTxX (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Oct 2004 15:53:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268828AbUJPTtq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Oct 2004 15:49:46 -0400
Received: from lennier.cc.vt.edu ([198.82.162.213]:61714 "EHLO
	lennier.cc.vt.edu") by vger.kernel.org with ESMTP id S268819AbUJPTpQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Oct 2004 15:45:16 -0400
Message-ID: <417188EA.4090205@vt.edu>
Date: Sat, 16 Oct 2004 15:47:38 -0500
From: William Wolf <wwolf@vt.edu>
User-Agent: Mozilla Thunderbird 0.8 (X11/20040919)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: kernel list <linux-kernel@vger.kernel.org>
Subject: AMD64 Swsusp on 2.6.9-rc4-mm1
X-Enigmail-Version: 0.86.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hey, Im running 2.6.9-rc4-mm1, and when i run either a echo 4 > 
/proc/acpi/sleep or echo disk > /sys/power/state  I get the following 
messages:


Stopping tasks: =================|
Freeing memory... done (0 pages freed)
PM: Attempting to suspend to disk.
PM: snapshotting memory.
ACPI: PCI interrupt 0000:00:02.7[C] -> GSI 18 (level, low) -> IRQ 18
Restarting tasks... done



It basically just stops everything, then starts it all back up again 
immediately.  Any idea whats going on here?  This was done right after 
booting and just logging in with no X running.
