Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262446AbTI0On1 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 Sep 2003 10:43:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262454AbTI0On1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 Sep 2003 10:43:27 -0400
Received: from gnu.univ.gda.pl ([153.19.120.250]:908 "EHLO gnu.univ.gda.pl")
	by vger.kernel.org with ESMTP id S262446AbTI0On0 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 Sep 2003 10:43:26 -0400
From: Piotr =?iso-8859-2?q?Szyma=F1ski?= <djurban@gnu.univ.gda.pl>
Reply-To: djurban@gnu.univ.gda.pl
To: linux-kernel@vger.kernel.org
Subject: urb timeouts with eagle on 2.4.20
Date: Sat, 27 Sep 2003 16:43:25 +0200
User-Agent: KMail/1.5.9
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 8BIT
Message-Id: <200309271643.25235.djurban@gnu.univ.gda.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
I have a problem with my sagem 800 modem on my USB Controller: VIA 
Technologies, Inc. USB (rev 10), using kernel 2.4.20.
After connecting to the net, the modem disconnects and I get an error:
***
Sep 27 12:51:56 niedakh NETDEV WATCHDOG: eth0: transmit timed out
Sep 27 12:51:56 niedakh [Adi] Transmit timed out!
Sep 27 12:51:56 niedakh [Adi] transmit URB e5cce0bc cancelled
***
I have to reload its firmware in order for it to work again. 
I talked to manypeople about this. I was told to try booting with noapic or 
acpi=off. Unfortunately the same error happened with apci=off or  noapic or 
even both.  On eagle forums I was pointed to check my controllers altency 
(how do you do that?) which reminded me I had a similar situation on win2k on 
the same machine, but after installing via 4in1 update for usb it started to 
work properly on win2k. i google for "usb via latency" and found a via usb 
latency patch for windows, I didnt find a linux version of the latency patch 
for via anywhere.
Noone around knows how to fix this, so Im mailing here.
Thanks for any replies.
-- 
Piotr Szymañski
djurban@gnu.univ.gda.pl; djurban.jogger.pl
JID: djurban@jabber.org; GG 2300264; ICQ: 12622400
