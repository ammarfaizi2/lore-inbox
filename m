Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266666AbUAWXES (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jan 2004 18:04:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266716AbUAWXES
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jan 2004 18:04:18 -0500
Received: from dial249.pm3abing3.abingdonpm.naxs.com ([216.98.75.249]:6548
	"EHLO animx.eu.org") by vger.kernel.org with ESMTP id S266666AbUAWXER
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jan 2004 18:04:17 -0500
Date: Fri, 23 Jan 2004 18:15:12 -0500
From: Wakko Warner <wakko@animx.eu.org>
To: linux-kernel@vger.kernel.org
Subject: Illegal instruction with gl
Message-ID: <20040123181512.A6632@animx.eu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I recently upgraded my system board and now gl stuff crashes with illegal
instruction.

Here's the trace (space in url to keep off robots)
http:// veg.animx.eu.org/strace.gl.txt

I'm using 2.6.1 SMP PREEMPT on a dual P4 Xeon 2.66ghz (1gb ram)

The board is a supermicro x5da8 (Intel e7505 chipset).  The card is a matrox
g400 max 32mb dual head.  mga, intel_agp and agpgart are loaded.

Modifications to the kernel when I changed the board (old board was an intel
chipset, same card with 384mb ram):
Enabled ACPI
Enabled PreEmpt
Changed processor type to p4 (from pIII)
Enabled SMP
Enabled High mem (4GB)
Enable aic79xx (aic7xxx is also enabled but not used) and changed the
initial delay from 15000 to 1000

I also enabled new modules for the intel 1000 nic and the intel ICH ac97
sound (both alsa and oss).

These are the only configuration changes.  I looked at the X log but saw
nothing.  The kernel does not complain about anything.

If this is a known problem, please let me know.  I'm willing to try any
troubleshooting to fix this problem.  Any more information available on
request.

-- 
 Lab tests show that use of micro$oft causes cancer in lab animals
