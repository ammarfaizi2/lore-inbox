Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263084AbTJPT1U (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Oct 2003 15:27:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263110AbTJPT1U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Oct 2003 15:27:20 -0400
Received: from d216-232-206-119.bchsia.telus.net ([216.232.206.119]:58120 "EHLO
	cyclops.implode.net") by vger.kernel.org with ESMTP id S263084AbTJPT1S
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Oct 2003 15:27:18 -0400
Date: Thu, 16 Oct 2003 12:27:17 -0700
From: John Wong <kernel@implode.net>
To: linux-kernel@vger.kernel.org
Subject: via-rhine on 2.4.23-pre6 Too much work at interrupt, status=0x00001000.
Message-ID: <20031016192717.GA2749@gambit.implode.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The system used to run 2.4.22 and did not have this too much work
problem.  There were some other hardware changes.  The system used to be
a Pentium 100 on a Triton 430FX chipset Intel Advanced/EV board.  Now it 
is a K6 2 - 500 on a Via Apollo MVP3 chipset on FIC VA-503+ board.
The NIC stayed the same.  The kernel was recompiled and ACPI was
enabled.

I noticed in 2.4.23-pre2 -> pre3
	 [netdrvr] sync with 2.5: epic100, fealnx, via-rhine, winbond-840

via-rhine.c:v1.10-LK1.1.19  July-12-2003  Written by Donald Becker
  http://www.scyld.com/network/via-rhine.html
eth0: VIA VT86C100A Rhine at 0xe4001000, 00:80:c8:d3:36:a6, IRQ 10.
eth0: MII PHY found at address 8, status 0x782d advertising 05e1 Link 40a1.


eth0: Too much work at interrupt, status=0x00001000.
eth0: Too much work at interrupt, status=0x00001000.
eth0: Too much work at interrupt, status=0x00001000.
eth0: Too much work at interrupt, status=0x00001000.
eth0: Too much work at interrupt, status=0x00001000.
eth0: Too much work at interrupt, status=0x00001000.
eth0: Too much work at interrupt, status=0x00001000.
eth0: Too much work at interrupt, status=0x00001000.
eth0: Too much work at interrupt, status=0x00001000.
eth0: Too much work at interrupt, status=0x00001000.

John
