Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268861AbUJPUux@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268861AbUJPUux (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Oct 2004 16:50:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268873AbUJPUux
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Oct 2004 16:50:53 -0400
Received: from grendel.digitalservice.pl ([217.67.200.140]:46278 "HELO
	mail.digitalservice.pl") by vger.kernel.org with SMTP
	id S268861AbUJPUuv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Oct 2004 16:50:51 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: linux-kernel@vger.kernel.org
Subject: Re: AMD64 Swsusp on 2.6.9-rc4-mm1
Date: Sat, 16 Oct 2004 22:52:33 +0200
User-Agent: KMail/1.6.2
Cc: Andrew Morton <akpm@osdl.org>, William Wolf <wwolf@vt.edu>
References: <417188EA.4090205@vt.edu>
In-Reply-To: <417188EA.4090205@vt.edu>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Message-Id: <200410162252.33347.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 16 of October 2004 22:47, William Wolf wrote:
> Hey, Im running 2.6.9-rc4-mm1, and when i run either a echo 4 > 
> /proc/acpi/sleep or echo disk > /sys/power/state  I get the following 
> messages:
> 
> 
> Stopping tasks: =================|
> Freeing memory... done (0 pages freed)
> PM: Attempting to suspend to disk.
> PM: snapshotting memory.
> ACPI: PCI interrupt 0000:00:02.7[C] -> GSI 18 (level, low) -> IRQ 18
> Restarting tasks... done
> 
> 
> 
> It basically just stops everything, then starts it all back up again 
> immediately.  Any idea whats going on here?  This was done right after 
> booting and just logging in with no X running.

IIRC, on 2.6.9-rc4-mm1 swsusp cannot free memory because of some unfinished VM 
patches that are in there, so it won't work (Andrew, please correct if I'm 
wrong).

Greets,
RJW

-- 
- Would you tell me, please, which way I ought to go from here?
- That depends a good deal on where you want to get to.
		-- Lewis Carroll "Alice's Adventures in Wonderland"
