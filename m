Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264815AbTAASi1>; Wed, 1 Jan 2003 13:38:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264818AbTAASi1>; Wed, 1 Jan 2003 13:38:27 -0500
Received: from mailout05.sul.t-online.com ([194.25.134.82]:10184 "EHLO
	mailout05.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S264815AbTAASi0>; Wed, 1 Jan 2003 13:38:26 -0500
Date: Wed, 1 Jan 2003 19:46:32 +0100
From: Daniel Golle <daniel@exil.afraid.org>
To: linux-kernel@vger.kernel.org
Subject: Problems radeonfb, again...
Message-ID: <20030101184632.GC8173@osama.exil.afraid.org>
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; charset=ISO-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Mailer: Balsa 2.0.4
X-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm running an ATI OEM (Xelo) Radeon 8500 with a NEC MultiSync 1535VI 
panel connected via DVI-D. X runs well with the latest fglrx driver 
from ATI as well as with the OpenSource radeon driver. When booting, 
the framebuffer does not initialize (see below). With older versions of 
ATI's driver (fglr200) I also had problems with the 
panel-size-detection, too: I had to start X 3 to 10 times before it 
started fine. Once running, there were no further probs.
Is there a possebility to skip the auto-detection of the panel size at 
boot time by setting it manual (via bootparams or compiling it into the 
kernel)?

--- Kernel output ---
radeonfb: ref_clk=2700, ref_div=12, xclk=25000 from BIOS
radeonfb: panel ID string: ªhé²^D
radeonfb: detected DFP panel size from BIOS: 1x0
radeonfb: Failed to detect DFP panel size
---------------------

thank you and excuse my poor english...
yours
  -Daniel
