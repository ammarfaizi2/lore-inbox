Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262906AbUFVNfw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262906AbUFVNfw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Jun 2004 09:35:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263015AbUFVNfw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Jun 2004 09:35:52 -0400
Received: from e4.ny.us.ibm.com ([32.97.182.104]:59778 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262906AbUFVNfr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Jun 2004 09:35:47 -0400
From: <gin@ginandtonic.ca>
To: <linux-kernel@vger.kernel.org>
Subject: Don't want to share interrupts
Date: Tue, 22 Jun 2004 09:34:07 -0400
Message-ID: <000001c4585d$98896340$0c501709@IBM3B3C778F126>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.2627
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1409
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have been trying to get some platforms to work with a quad port
Ethernet card.
Some hardware is OK, others...well, not so OK.

An IBM x335 works OK under Linux (2.4.9) and Win2K3
An IBM x365 Does not work under Linux.

Looks like Linux shares an IRQ between all 4 ports whereas win2k3
doesn't .... each is assigned it's own IRQ.  Is there anyway to
duplicate this behavior under Linux? (i.e. have an IRQ assigned to each
port instead of sharing one for the whole card?).

Thanks,

-Garreth-

