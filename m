Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266704AbUGQNWF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266704AbUGQNWF (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Jul 2004 09:22:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266705AbUGQNWE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Jul 2004 09:22:04 -0400
Received: from postfix4-2.free.fr ([213.228.0.176]:29589 "EHLO
	postfix4-2.free.fr") by vger.kernel.org with ESMTP id S266704AbUGQNWB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Jul 2004 09:22:01 -0400
Subject: Davicom DM9102AF card working only at 10 Mbps
From: Jean Francois Martinez <jfm512@free.fr>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Message-Id: <1090070520.4498.25.camel@agnes>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Sat, 17 Jul 2004 15:22:00 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have an ethernet card with a DM9102AF chip.  It only works at 10 Mbps.

More precisely by using etheral on another box I see the frames it is
sending but it seems unable to catch the replies.  If I configure it 
to transmit at 10 Mbps then it works.

It happens both with 2.4 and 2.6 kernels.

The computer with the Davicom card is linked to the network through 
a switch.  The particualr cable and switch's port have worked 
perfectly with other cards.  Same thing for the network config;

Could be a thing about failing negotiation with the switch 
(as I saids the switch has worked perfectly with other cards).
Now the question is if negotiation is a hardware thing and there
is nothing to be done or a driver thing and then it should be
fixed

I have tried to link the card directly to another computer through a
crossed cable.    It worked but
I haven't checked at what speed the cards agreed to work.

I have tried the card in several computers: K6 with VIA chipset, PIII
with VIA chipset, P4 with Intel chipset.  Same results everywhere: card
doesn't work at 100 Mbps only at 10 Mbps



