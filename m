Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261900AbVCEQAO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261900AbVCEQAO (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Mar 2005 11:00:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263128AbVCEP4u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Mar 2005 10:56:50 -0500
Received: from static-162-83-93-166.fred.east.verizon.net ([162.83.93.166]:12730
	"EHLO ccs.covici.com") by vger.kernel.org with ESMTP
	id S261900AbVCEPxm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Mar 2005 10:53:42 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16937.54786.986183.491118@ccs.covici.com>
Date: Sat, 5 Mar 2005 10:53:38 -0500
From: John covici <covici@ccs.covici.com>
To: linux-kernel@vger.kernel.org
Subject: X not working with Radeon 9200 under 2.6.11
X-Mailer: VM 7.17 under Emacs 21.3.50.2
Reply-To: covici@ccs.covici.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.  I Have a Radeon 9200c and ever since some time in the 2.6.9
series, I cannot get X to start using this card.  It dies in such a
way that there is no way to get the vga console out of that console
and chvt from another terminal just hangs and xinit cannot be
cancelled.

This is the lspci for the agp card.
0000:01:00.0 VGA compatible controller: ATI Technologies Inc RV280
[Radeon 9200 SE] (rev 01) (prog-if 00 [VGA])
     Subsystem: PC Partner Limited: Unknown device 7c26
     Flags: bus master, 66MHz, medium devsel, latency 64, IRQ 16
     Memory at e8000000 (32-bit, prefetchable) [size=128M]
     I/O ports at e000 [size=256]
     Memory at fbe00000 (32-bit, non-prefetchable) [size=64K]
     Expansion ROM at fbd00000 [disabled] [size=128K]
     Capabilities: [58] AGP version 3.0
     Capabilities: [50] Power Management version 2

0000:01:00.1 Display controller: ATI Technologies Inc RV280 [Radeon
9200 SE] (Secondary) (rev 01)
     Subsystem: PC Partner Limited: Unknown device 7c27
     Flags: bus master, 66MHz, medium devsel, latency 64
     Memory at f0000000 (32-bit, prefetchable) [size=128M]
     Memory at fbf00000 (32-bit, non-prefetchable) [size=64K]
     Capabilities: [50] Power Management version 2

Any assistance would be appreciated.

-- 
Your life is like a penny -- how are you going to spend it?

         John Covici
         covici@ccs.covici.com
