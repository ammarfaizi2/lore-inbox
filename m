Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263205AbTFPB5I (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Jun 2003 21:57:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263212AbTFPB5I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Jun 2003 21:57:08 -0400
Received: from fe1.rdc-kc.rr.com ([24.94.163.48]:12038 "EHLO mail1.kc.rr.com")
	by vger.kernel.org with ESMTP id S263205AbTFPB5G (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Jun 2003 21:57:06 -0400
Date: Sun, 15 Jun 2003 21:10:59 -0500
From: Greg Norris <haphazard@kc.rr.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: memory problem with 2.4.21 SMP on Dell Dimension 8300 (i875p chipset)
Message-ID: <20030616021059.GA1671@glitch.localdomain>
Mail-Followup-To: linux-kernel <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

After running a SMP 2.4.21 kernel on my Dell Dimension 8300, the BIOS
thinks that the amount of memory has changed.  When the box is
rebooted, I get the following message at the end of BIOS
initialization:

   The amount of system memory has changed.
   Alert! OS Install Mode enabled. Amount of available memory limited to 256MB.

At this point the bootup hangs, waiting for someone to press F1
(resume) or F2 (setup).  Any idea what's triggering this behaviour, and
what I can do to squash it?  This issue doesn't occur when using a UP
kernel (basically identical, except for SMP/ACPI being disabled).

Thanx!
