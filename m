Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268961AbUJQATq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268961AbUJQATq (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Oct 2004 20:19:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268972AbUJQATp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Oct 2004 20:19:45 -0400
Received: from lennier.cc.vt.edu ([198.82.162.213]:23820 "EHLO
	lennier.cc.vt.edu") by vger.kernel.org with ESMTP id S268961AbUJQASU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Oct 2004 20:18:20 -0400
Subject: Re: AMD64 Swsusp on 2.6.9-rc4-mm1
From: William Wolf <wwolf@vt.edu>
Reply-To: wwolf@vt.edu
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
In-Reply-To: <200410162252.33347.rjw@sisk.pl>
References: <417188EA.4090205@vt.edu>  <200410162252.33347.rjw@sisk.pl>
Content-Type: text/plain
Date: Tue, 16 Nov 2004 01:19:14 -0600
Message-Id: <1100589554.7496.2.camel@Xnix>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Is this supposedly something new in rc4-mm1?  I have been having the
same problems since around 2.6.8.1, though i havent gone through every
single -mm patch, i have tried at least one in every -rcx candidate, and
they have all done this same thing.

On Sat, 2004-10-16 at 22:52 +0200, Rafael J. Wysocki wrote:
> On Saturday 16 of October 2004 22:47, William Wolf wrote:
> > Hey, Im running 2.6.9-rc4-mm1, and when i run either a echo 4 > 
> > /proc/acpi/sleep or echo disk > /sys/power/state  I get the following 
> > messages:
> > 
> > 
> > Stopping tasks: =================|
> > Freeing memory... done (0 pages freed)
> > PM: Attempting to suspend to disk.
> > PM: snapshotting memory.
> > ACPI: PCI interrupt 0000:00:02.7[C] -> GSI 18 (level, low) -> IRQ 18
> > Restarting tasks... done
> > 
> > 
> > 
> > It basically just stops everything, then starts it all back up again 
> > immediately.  Any idea whats going on here?  This was done right after 
> > booting and just logging in with no X running.
> 
> IIRC, on 2.6.9-rc4-mm1 swsusp cannot free memory because of some unfinished VM 
> patches that are in there, so it won't work (Andrew, please correct if I'm 
> wrong).
> 
> Greets,
> RJW
> 

