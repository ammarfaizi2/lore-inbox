Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264137AbUA3UfN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jan 2004 15:35:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264257AbUA3UfN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jan 2004 15:35:13 -0500
Received: from av7-2-sn1.fre.skanova.net ([81.228.11.114]:22480 "EHLO
	av7-2-sn1.fre.skanova.net") by vger.kernel.org with ESMTP
	id S264137AbUA3UfD convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jan 2004 15:35:03 -0500
From: Roger Larsson <roger.larsson@norran.net>
To: linux-kernel@vger.kernel.org
Subject: Re: [OT] Crazy idea:  Design open-source graphics chip - DONE
Date: Fri, 30 Jan 2004 21:53:53 +0100
User-Agent: KMail/1.6.50
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Message-Id: <200401302153.54075.roger.larsson@norran.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Not so crazy - it is already done :-)

http://www.opencores.org/projects/vga_lcd/

FEATURES

CRT and LCD display support
24bit Standard VGA interface
Separate VSYNC/HSYNC and combined CSYNC synchronization signals
Composite BLANK signal
TripleDisplay support
12bit Interface
Compatible with DVI transmitters and 12bit VGA ADCs
4 different output modes
Can be used simultaneous with the 24bit interface
User programmable video resolutions 
User programmable video timing
User programmable video control signals polarization levels
32bpp, 24bpp and 16bpp color modes
8bit gray-scale and 8bit pseudo-color modes
Supports video- and/or color-lookup-table bankswitching during vertical 
retrace
32bit WISHBONE revB.3 compliant slave and master interfaces
Operates from a wide range of input clock frequencies
Static synchronous design
Fully synthesizeable

STATUS 

VGA/LCD core v2.0 is ready and available in verilog from OpenCores CVS via 
cvsweb or via cvsget. 
Low level abstraction layer available in C from CVS. 
Character simulation software is currently under development. 



But to get a board that gives you anything more than a cheap old VGA board
the XServer should be running on the board! (PowerPCs are good for embedding)
But for some applications you might need to talk directly to the frame 
buffer...

/RogerL

-- 
Roger Larsson
Skellefteå
Sweden
