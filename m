Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261837AbUBOOhl (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Feb 2004 09:37:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264927AbUBOOhl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Feb 2004 09:37:41 -0500
Received: from agminet01.oracle.com ([141.146.126.228]:42144 "EHLO
	agminet01.oracle.com") by vger.kernel.org with ESMTP
	id S261837AbUBOOhj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Feb 2004 09:37:39 -0500
Message-ID: <402F83D4.3080605@oracle.com>
Date: Sun, 15 Feb 2004 15:36:04 +0100
From: Alessandro Suardi <alessandro.suardi@oracle.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20040107
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
CC: linux-kernel <linux-kernel@vger.kernel.org>
Subject: 2.6.3-rc3: radeon blanks screen
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On my Dell Latitude C640 as on Peter Osterlund's laptop - blind-typing
  login/password and startx gets me a visible X desktop.

Old driver with Peter's patch works as before.

Note - this is the same laptop you tried I gave up using framebuffer on
  in the 2.4 series because after 2.4.22-pre4 it would send my screen in
  a crazed-up state (X didn't work either) [that was July 2003].


2.6.3-rc3 new driver messages:

radeonfb: Invalid ROM signature 0 should be 0xaa55
radeonfb: Retreived PLL infos from BIOS
radeonfb: Reference=27.00 MHz (RefDiv=12) Memory=230.00 Mhz, System=166.00 MHz
Non-DDC laptop panel detected
radeonfb: Monitor 1 type LCD found
radeonfb: Monitor 2 type no found
radeonfb: panel ID string: 1024x768
radeonfb: detected LVDS panel size from BIOS: 1024x768
radeondb: BIOS provided dividers will be used
radeonfb: Power Management enabled for Mobility chipsets
radeonfb: ATI Radeon LW  DDR SGRAM 32 MB

2.6.3-rc3 old driver messages:

radeonfb_pci_register BEGIN
radeonfb: ref_clk=2700, ref_div=12, xclk=16600 from BIOS
radeonfb: probed DDR SGRAM 32768k videoram
radeon_get_moninfo: bios 4 scratch = 1000004
radeonfb: panel ID string: 1024x768
radeonfb: detected DFP panel size from BIOS: 1024x768
radeonfb: ATI Radeon M7 LW DDR SGRAM 32 MB
radeonfb: DVI port LCD monitor connected
radeonfb: CRT port no monitor connected
radeonfb_pci_register END
[drm] Initialized radeon 1.9.0 20020828 on minor 0


Please CC me on replies as I'm not on the list. Thanks in advance,

--alessandro

  "Two rivers run too deep
   The seasons change and so do I"
       (U2, "Indian Summer Sky")

