Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262011AbUCLIP2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Mar 2004 03:15:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262022AbUCLIP2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Mar 2004 03:15:28 -0500
Received: from web21107.mail.yahoo.com ([216.136.227.109]:32076 "HELO
	web21107.mail.yahoo.com") by vger.kernel.org with SMTP
	id S262011AbUCLIP0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Mar 2004 03:15:26 -0500
Message-ID: <20040312081525.26148.qmail@web21107.mail.yahoo.com>
Date: Fri, 12 Mar 2004 00:15:25 -0800 (PST)
From: Chris Grzegorczyk <chris_grze@yahoo.com>
Subject: Multiport Serial Device Support - Exar XR17L154
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have failed to find reference to this particular
device anywhere beside Exar:

[1] Exar XR17L154 
http://www.exar.com/product.php?ProdNumber=XR17L154&areaID=3
Note: The page indicates that "A Linux driver is also
available.", but I can't seem to get my hands on it.

[2] System:
PC104 / Intel PIIX Compatible
16MB CompactFlash
Celeron 1.2Ghz @ 800Mhz 
2.4.25 / 2.6.3

I have noted support for the Exar ST16C555/XR16... in
char/serial.c, however, the XR17L154 differs in that
it has a 32 bit interface ( linear addressing ) with
all 4 UARTs on the same IRQ.  My attempts to have the
kernel recognize the device have failed. 

Is there a chance of having this device work under the
stock kernel ( 2.4.25 )?

If not, can someone suggest an existing multiport
driver which could serve as a reasonable starting
point for development by a kernel newbie?

TAI, greatly appreciated.

Chris

p.s. Please CC in replies as I am not subscribed.

__________________________________
Do you Yahoo!?
Yahoo! Search - Find what you’re looking for faster
http://search.yahoo.com
