Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266295AbTAPKZs>; Thu, 16 Jan 2003 05:25:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266307AbTAPKZs>; Thu, 16 Jan 2003 05:25:48 -0500
Received: from harpo.it.uu.se ([130.238.12.34]:45222 "EHLO harpo.it.uu.se")
	by vger.kernel.org with ESMTP id <S266295AbTAPKZr>;
	Thu, 16 Jan 2003 05:25:47 -0500
From: Mikael Pettersson <mikpe@csd.uu.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15910.35488.252418.356477@harpo.it.uu.se>
Date: Thu, 16 Jan 2003 11:34:08 +0100
To: sfr@canb.auug.org.au
Subject: CONFIG_APM_DISPLAY_BLANK problem in the 2.5 kernel
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have an ex-desktop PIII box which now runs as a leafnode News
server. It's up 24/7 and 2.4 and 2.2 kernels are rock solid on it.

However, 2.5 kernels tend to hang the machine when the console screen
blanker kicks in. "Tend to" as in almost but not quite always.
Recently I found that disabling APM_DISPLAY_BLANK eliminates the hangs.

My other boxes don't have any problems with APM_DISPLAY_BLANK, and this
box does run 2.4 fine with APM_DISPLAY_BLANK, so it seems there must
be some change in the 2.5 kernel's APM driver that is problematic on
this particular box.

(UP_APIC, APM, and APM_DO_ENABLE are enabled; IO_APIC, SMP, PREEMPT, ACPI,
and the other APM options are disabled. PCI S3 Trio64V2/DX graphics card.)

/Mikael
