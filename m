Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265667AbTATMps>; Mon, 20 Jan 2003 07:45:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265736AbTATMpT>; Mon, 20 Jan 2003 07:45:19 -0500
Received: from inet-mail3.oracle.com ([148.87.2.203]:23483 "EHLO
	inet-mail3.oracle.com") by vger.kernel.org with ESMTP
	id <S265667AbTATMpA>; Mon, 20 Jan 2003 07:45:00 -0500
Message-ID: <7848733.1043066943393.JavaMail.nobody@web55.us.oracle.com>
Date: Mon, 20 Jan 2003 04:49:03 -0800 (PST)
From: Alessandro Suardi <ALESSANDRO.SUARDI@oracle.com>
To: irda-users@lists.sourceforce.net
Subject: irport_net_open issue in 2.5.59
Cc: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-Mailer: Oracle Webmail Client
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[crossposted to IrDA-users and l-k]

The quest to set up properly (or give up where not possible) my new Dell Latitude
 C640 is moving forward... next target, IrDA. This laptop has a chip that is not
 detected by the 'findchip' tool but is detected by kernel code (SMC LPC47N252).

My base distro is a RH8.0, with the modified rc.sysinit to allow modules to properly
 work even with newer kernels.


When irport is loaded (or perhaps when irattach is run), the module complains saying

irport_net_open(), unable to allocate irq=0

It does load, but as expected it doesn't seem to work - irdadump doesn't come up
 with any line at all.


Any hints ? Thanks in advance, ciao,

--alessandro
