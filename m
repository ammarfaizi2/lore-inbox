Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263628AbTFPIt6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Jun 2003 04:49:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263631AbTFPIt6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Jun 2003 04:49:58 -0400
Received: from imo-d01.mx.aol.com ([205.188.157.33]:25579 "EHLO
	imo-d01.mx.aol.com") by vger.kernel.org with ESMTP id S263628AbTFPIt5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Jun 2003 04:49:57 -0400
Date: Mon, 16 Jun 2003 05:03:44 -0400
From: jpo234@netscape.net
To: linux-kernel@vger.kernel.org
Cc: linux-usb-users@lists.sourceforge.net
Subject: open(2) with NO_CTTY flag for USB ACM TTY devices
MIME-Version: 1.0
Message-ID: <681FF206.485ADA78.00065BAA@netscape.net>
X-Mailer: Atlas Mailer 2.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi list,
I tried to use a program that up until now solely talked to
modems connected to the serial port to talk to a Siemens U10
UMTS mobile connected to a USB port.
The device open failed because the program called open(2) with
the NO_CTTY flag set. Without this flag everything works as
expected.

Should this be considered a buglet? And if so, where?

Regards
  Joerg

__________________________________________________________________
McAfee VirusScan Online from the Netscape Network.
Comprehensive protection for your entire computer. Get your free trial today!
http://channels.netscape.com/ns/computing/mcafee/index.jsp?promo=393397

Get AOL Instant Messenger 5.1 free of charge.  Download Now!
http://aim.aol.com/aimnew/Aim/register.adp?promo=380455
