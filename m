Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272433AbTHIRIq (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Aug 2003 13:08:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272437AbTHIRIp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Aug 2003 13:08:45 -0400
Received: from sinma-gmbh.17.mind.de ([212.21.92.17]:24595 "EHLO gw.enyo.de")
	by vger.kernel.org with ESMTP id S272433AbTHIRIo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Aug 2003 13:08:44 -0400
To: linux-kernel@vger.kernel.org
Subject: [2.6.0-test3] Hyperthreading gone
From: Florian Weimer <fw@deneb.enyo.de>
Mail-Followup-To: linux-kernel@vger.kernel.org
Date: Sat, 09 Aug 2003 19:08:43 +0200
Message-ID: <87llu2bvxg.fsf@deneb.enyo.de>
User-Agent: Gnus/5.1003 (Gnus v5.10.3) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ACPI with CPU enumeration is enabled, but the sibling CPUs aren't
activated.

This is all what I have of the boot message (standard buffer size is
too small, apparently):

CPU:     After all inits, caps: 3febfbff 00000000 00000000 00000080
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#3.
CPU#3: Intel P4/Xeon Extended MCE MSRs (12) available
CPU#3: Thermal monitoring enabled
CPU3: Intel(R) Xeon(TM) CPU 1.40GHz stepping 01
Total of 4 processors activated (11034.62 BogoMIPS).
WARNING: No sibling found for CPU 0.
WARNING: No sibling found for CPU 1.
WARNING: No sibling found for CPU 2.
WARNING: No sibling found for CPU 3.

Recent 2.4.x kernels (starting with 2.4.20 IIRC) support
Hyperthreading on this machine (Siemens Primergy H450).
