Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272265AbTHNGb1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Aug 2003 02:31:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272266AbTHNGb0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Aug 2003 02:31:26 -0400
Received: from amalthea.dnx.de ([193.108.181.146]:31387 "EHLO amalthea.dnx.de")
	by vger.kernel.org with ESMTP id S272265AbTHNGbY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Aug 2003 02:31:24 -0400
Date: Thu, 14 Aug 2003 08:31:19 +0200
From: Robert Schwebel <robert@schwebel.de>
To: linux-kernel@vger.kernel.org
Subject: Missing ttys on SC520
Message-ID: <20030814063119.GA10127@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.4i
X-Spam-Score: -2.5 (--)
X-Scanner: exiscan for exim4 (http://duncanthrax.net/exiscan/) *19nBde-0006o1-00*Q7ZzedBQtkE*
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have two AMD Elan SC520 boards which are basically identical; the only
visuable difference is that one bootloader switches on the PCI-VGA card
and displays a splash screen before starting the Linux kernel. 

The board without splash screen boots 2.4.21 just fine, especially there
are entries in /dev/vc/* for the virtual terminals. The splash screen
board does also boot, but there is only /dev/vc/0 available. Both boards
run the same kernel image and the same user space. 

Any idea how this could be caused? I'm not that firm with the terminal
code to find out which part fails while probing what... 

Robert
-- 
 Dipl.-Ing. Robert Schwebel | http://www.pengutronix.de
 Pengutronix - Linux Solutions for Science and Industry
   Handelsregister:  Amtsgericht Hildesheim, HRA 2686
     Hornemannstraﬂe 12,  31137 Hildesheim, Germany
    Phone: +49-5121-28619-0 |  Fax: +49-5121-28619-4
