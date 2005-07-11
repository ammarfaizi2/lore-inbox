Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261845AbVGKOXv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261845AbVGKOXv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Jul 2005 10:23:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261804AbVGKOVt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Jul 2005 10:21:49 -0400
Received: from smtp005.bizmail.sc5.yahoo.com ([66.163.175.82]:55673 "HELO
	smtp005.bizmail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261803AbVGKOT4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Jul 2005 10:19:56 -0400
Reply-To: <matts@commtech-fastcom.com>
From: "Matt Schulte" <matts@commtech-fastcom.com>
To: "Russell King" <rmk+lkml@arm.linux.org.uk>
Cc: <linux-kernel@vger.kernel.org>, <linux-serial@vger.kernel.org>
Subject: RE: Serial PCI driver in 2.6.x kernel (i.e. 8250_pci HOWTO)
Date: Mon, 11 Jul 2005 09:19:51 -0500
Message-ID: <MFEBKNPNJBEAJEICJEJNMEDDCLAA.matts@commtech-fastcom.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.6604 (9.0.2911.0)
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1506
In-Reply-To: <20050710130343.A3279@flint.arm.linux.org.uk>
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>From: Russell King [mailto:rmk@arm.linux.org.uk]On Behalf Of Russell King

>Can we see this code?
Because I was working on the assumption that the driver would no longer be
serial.c and would use only my card, I may have done some things that
weren't exactly the best practice.  This is partially why I am trying to
figure out the "correct" way to use the new serial driver.  Because I went
with the entire serial.c file, I don't think that I can post it.  However,
you can get my modifications here:
http://support.commtech-fastcom.com/fcap335_07_11_2005.tar.gz.  I renamed
the serial.c file to fcap_335.c and I changed the devnodes to be
/dev/ttyFCx.  I think every modification that I made has a comment //mds
near it.

>Despite being the maintainer for the serial layer, I'm not on linux-serial.
Right, I am on linux-serial and I had seen a couple of posts from you on
linux-serial, I kind of assumed that you were there too.

Thanks,

Matt Schulte
Commtech, Inc.
http://www.commtech-fastcom.com

