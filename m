Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261607AbUK2AAM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261607AbUK2AAM (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Nov 2004 19:00:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261610AbUK2AAL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Nov 2004 19:00:11 -0500
Received: from ip189.73.1311O-CUD12K-02.ish.de ([62.143.73.189]:32386 "EHLO
	metzlerbros.de") by vger.kernel.org with ESMTP id S261607AbUK1X7z
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Nov 2004 18:59:55 -0500
From: Ralph Metzler <rjkm@metzlerbros.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16810.26231.936086.930240@metzlerbros.de>
Date: Mon, 29 Nov 2004 00:59:51 +0100
To: linux-kernel@vger.kernel.org
Subject: efficeon and longrun
X-Mailer: VM 7.07 under 21.4 (patch 6) "Common Lisp" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I recently got a Sharp MP70G with a 1.6 GHz efficeon processor 
and have some questions regarding longrun support. I am using 
longrun-0.9-15 and kernel 2.6.10-rc2.

In arch/i386/kernel/cpu/proc.c the kernel seems to check bit 3
for the lrti capability, longrun.c checks bit2. 

Are thermal extensions different on the efficeon compared to the crusoe?
No matter what I choose (between 0 and 7) the level field in the ATM
register is always 0. 

Are there any new efficeon features not yet supported in the kernel or
the longrun utility? Is there any register information available
anywhere? I looked on the transmeta pages but did not find anything
about this.
The BIOS also allows one to select C4 as possible power level,
/proc/acpi/processor/CPU0/power only offers C1, C2 and C3. 

I ask because under Windows, if nothing is running, the fan will
stay off. Under Linux it is turning on about every two minutes and
will then run for about a minute (also with everything turned off, and
about every daemon shut down).


Cheers,
Ralph Metzler
