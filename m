Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751280AbWA0ABc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751280AbWA0ABc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Jan 2006 19:01:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751262AbWA0ABc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Jan 2006 19:01:32 -0500
Received: from embla.aitel.hist.no ([158.38.50.22]:49110 "HELO
	embla.aitel.hist.no") by vger.kernel.org with SMTP id S1751233AbWA0ABc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Jan 2006 19:01:32 -0500
Date: Fri, 27 Jan 2006 01:06:30 +0100
To: Linus Torvalds <torvalds@osdl.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.6.16-rc1 - usb printer problems
Message-ID: <20060127000630.GA13008@aitel.hist.no>
References: <Pine.LNX.4.64.0601170001530.13339@g5.osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0601170001530.13339@g5.osdl.org>
User-Agent: Mutt/1.5.11
From: Helge Hafting <helgehaf@aitel.hist.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

There seems to be a usb printer problem in 2.6.16-rc1 (amd64)

I can print a page or two of graphichs (A4 maps), and then 
my syslog fills up with these:
kernel: drivers/usb/class/usblp.c: usblp0: error -19 reading printer status

It is then time to power-cycle the printer, restart cups and
maybe get another page out.  Or maybe not. Going back to 2.6.15 I don't
see such problems, the printer cranks out page after page with ease.

Known issue, or is some USB debugging in place?

Helge Hafting
