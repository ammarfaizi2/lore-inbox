Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264143AbUDRB5D (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Apr 2004 21:57:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264151AbUDRB5D
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Apr 2004 21:57:03 -0400
Received: from pileup.ihatent.com ([217.13.24.22]:13217 "EHLO
	pileup.ihatent.com") by vger.kernel.org with ESMTP id S264143AbUDRB5A
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Apr 2004 21:57:00 -0400
To: linux-kernel@vger.kernel.org, jeremy@goop.org
Subject: Speedstep on centrino
From: Alexander Hoogerhuis <alexh@boxed.no>
Date: Sun, 18 Apr 2004 03:56:49 +0200
Message-ID: <87n05aoxpa.fsf@dorker.boxed.no>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've been twaddling with getting SpeedStep right on my laptop (HP
nc6000, 1.6GHz P-M) and noticed a few odd things:

Using regular SpeedStep is says to use speedstep-centrino due to
voltage regultion, etc.

Using SpeedStep for Centrino og gived me this line on boot:
speedstep-centrino: found "Intel(R) Pentium(R) M processor 1600MHz": max frequency: 1600000kHz

This seems to work and make the battery last an useful amount of time.

Using SpeedStep for Centrino with decoding the speeds and voltages
(CONFIG_X86_SPEEDSTEP_CENTRINO_ACPI) will not yield any output during
boot regarding cpufreq at all and the battery useage is heavy. ACPI is
enabled. 

mvh,
A
-- 
Alexander Hoogerhuis                               | alexh@boxed.no
CCNP - CCDP - MCNE - CCSE                          | +47 908 21 485
"You have zero privacy anyway. Get over it."  --Scott McNealy
