Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268594AbUIQJTn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268594AbUIQJTn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Sep 2004 05:19:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268609AbUIQJTn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Sep 2004 05:19:43 -0400
Received: from dpvc-162-83-93-166.fred.east.verizon.net ([162.83.93.166]:44427
	"EHLO ccs.covici.com") by vger.kernel.org with ESMTP
	id S268594AbUIQJTb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Sep 2004 05:19:31 -0400
To: linux-kernel@vger.kernel.org
Subject: problems with multitech 4 port serial card under 2.4.x and 2.6.x
From: John Covici <covici@ccs.covici.com>
Date: Fri, 17 Sep 2004 05:19:30 -0400
Message-ID: <m3656di76l.fsf@ccs.covici.com>
User-Agent: Gnus/5.1002 (Gnus v5.10.2) Emacs/21.3.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have had problems with the multitech 4 port serial card under both
the 2.4 and the 2.6 Linux kernels.

I guess the most important problem is that the driver module does not
detect the card at all -- the only driver whichworks is the one from
multitech itself.   Here is the lspci -v entry for the card.

0000:00:0e.0 Serial controller: Exar Corp. XR17C158 Octal UART (rev
01) (prog-if 02 [16550])
        Subsystem: Unknown device 2205:2001
        Flags: fast devsel, IRQ 7
        Memory at fba00000 (32-bit, non-prefetchable) [size=2K]
 
Now also, I have an Asus a8V and if I have the apic support for uni
processors on it won't even boot with the card installed.

Any assistance on these matters would be appreciated -- especially
Any assistance on these matters would be appreciated.

-- 
         John Covici
         covici@ccs.covici.com
