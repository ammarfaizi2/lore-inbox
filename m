Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751338AbWGKWlG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751338AbWGKWlG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jul 2006 18:41:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751339AbWGKWlG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jul 2006 18:41:06 -0400
Received: from CHOKECHERRY.SRV.CS.CMU.EDU ([128.2.185.41]:17103 "EHLO
	chokecherry.srv.cs.cmu.edu") by vger.kernel.org with ESMTP
	id S1751338AbWGKWlF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jul 2006 18:41:05 -0400
Date: Tue, 11 Jul 2006 18:41:04 -0400
To: linux-kernel@vger.kernel.org
Subject: boot hangs with SMP, USB storage, and ACPI
Message-ID: <20060711224104.GA7046@localhost>
Mail-Followup-To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060403
From: Eric Cooper <ecc@cmu.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When I try to boot a 2.6.17 kernel compiled for SMP (hyperthreading),
it hangs early in the boot sequence (after printing "Freeing SMP
alternatives").  The issue seems to be an interaction between a
USB-storage device (an empty flash card reader built into the
monitor) and ACPI.

It boots fine if I do any one of these:
  - physically disconnect the USB device
  - disable USB support in the BIOS
  - boot with acpi=ht
but none of these is completely satisfactory.

I'll happily supply more details, run tests, etc. if anyone is
interested in looking at this.  Thanks, and please CC me if you
respond.

-- 
Eric Cooper             e c c @ c m u . e d u
