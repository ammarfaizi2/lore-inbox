Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261957AbUBJVc5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Feb 2004 16:32:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262078AbUBJVc5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Feb 2004 16:32:57 -0500
Received: from topaz.cx ([66.220.6.227]:38820 "EHLO mail.topaz.cx")
	by vger.kernel.org with ESMTP id S261957AbUBJVcv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Feb 2004 16:32:51 -0500
Date: Tue, 10 Feb 2004 16:32:46 -0500
From: Chip Salzenberg <chip@pobox.com>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: 2.6.3-rc2: ACPI's Revenge vs. the Thinkpad A30
Message-ID: <20040210213246.GA12795@perlsupport.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Message-Flag: OUTLOOK ERROR: Message text violates P.A.T.R.I.O.T. act
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On my very first 2.6 kernel boot, many things worked well.  However, ACPI
is complaining a fair bit.  Is this (1) a surprise, (2) very bad, (3) already
fixed in CVS, and/or (4) where?  adTHANKSvance

ACPI-1120: *** Error: Method execution failed [\_SB_.PCI0.LPC_.EC__._INI] (Node e7ea9ce0), AE_NOT_EXIST
ACPI-1120: *** Error: Method execution failed [\_SB_.PCI0.LPC_.EC__.BAT0._STA] (Node e7ea8500), AE_NOT_EXIST
ACPI-0098: *** Error: Method execution failed [\_SB_.PCI0.LPC_.EC__.BAT0._STA] (Node e7ea8500), AE_NOT_EXIST
ACPI-1120: *** Error: Method execution failed [\_SB_.PCI0.LPC_.EC__.BAT1._STA] (Node e7ea8380), AE_NOT_EXIST
ACPI-0098: *** Error: Method execution failed [\_SB_.PCI0.LPC_.EC__.BAT1._STA] (Node e7ea8380), AE_NOT_EXIST
ACPI-1120: *** Error: Method execution failed [\_SB_.PCI0.LPC_.EC__.BLID] (Node e7ea1320), AE_NOT_EXIST
ACPI-1120: *** Error: Method execution failed [\_SB_.PCI0.LPC_.EC__.BLII] (Node e7ea1340), AE_NOT_EXIST
ACPI-1120: *** Error: Method execution failed [\_SB_.PCI0.LPC_.EC__.BLPC] (Node e7ea1380), AE_NOT_EXIST
ACPI-1120: *** Error: Method execution failed [\_SB_.PCI0.IDE0.PRIM.SLAV._STA] (Node e7ea1d20), AE_NOT_EXIST
ACPI-0098: *** Error: Method execution failed [\_SB_.PCI0.IDE0.PRIM.SLAV._STA] (Node e7ea1d20), AE_NOT_EXIST
ACPI-1120: *** Error: Method execution failed [\_SB_.PCI0.LPC_.EC__.BRID] (Node e7ea1f00), AE_NOT_EXIST
ACPI-1120: *** Error: Method execution failed [\_SB_.PCI0.LPC_.EC__.BRII] (Node e7ea1f20), AE_NOT_EXIST
ACPI-1120: *** Error: Method execution failed [\_SB_.PCI0.LPC_.EC__.BRPC] (Node e7ea1f60), AE_NOT_EXIST
ACPI-1120: *** Error: Method execution failed [\_SB_.PCI0.IDE0.SCND.MSTR._STA] (Node e7ea1ce0), AE_NOT_EXIST
ACPI-0098: *** Error: Method execution failed [\_SB_.PCI0.IDE0.SCND.MSTR._STA] (Node e7ea1ce0), AE_NOT_EXIST
ACPI-1120: *** Error: Method execution failed [\_SB_.PCI0.LPC_.EC__.BLID] (Node e7ea1320), AE_NOT_EXIST
ACPI-1120: *** Error: Method execution failed [\_SB_.PCI0.LPC_.EC__.BLII] (Node e7ea1340), AE_NOT_EXIST
ACPI-1120: *** Error: Method execution failed [\_SB_.PCI0.LPC_.EC__.BLPC] (Node e7ea1380), AE_NOT_EXIST
ACPI-1120: *** Error: Method execution failed [\_SB_.PCI0.LPC_.EC__.BSTA] (Node e7ea1580), AE_NOT_EXIST
ACPI-1120: *** Error: Method execution failed [\_SB_.PCI0.USB0.URTH.UNST._STA] (Node e7ea18c0), AE_NOT_EXIST
ACPI-0098: *** Error: Method execution failed [\_SB_.PCI0.USB0.URTH.UNST._STA] (Node e7ea18c0), AE_NOT_EXIST

-- 
Chip Salzenberg               - a.k.a. -               <chip@pobox.com>
"I wanted to play hopscotch with the impenetrable mystery of existence,
    but he stepped in a wormhole and had to go in early."  // MST3K
