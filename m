Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129798AbRCAS4h>; Thu, 1 Mar 2001 13:56:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129799AbRCAS42>; Thu, 1 Mar 2001 13:56:28 -0500
Received: from [62.90.5.51] ([62.90.5.51]:3850 "EHLO salvador.shunra.co.il")
	by vger.kernel.org with ESMTP id <S129798AbRCAS4W>;
	Thu, 1 Mar 2001 13:56:22 -0500
Message-ID: <F1629832DE36D411858F00C04F24847A11DED7@SALVADOR>
From: Ofer Fryman <ofer@shunra.co.il>
To: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: RE: Intel-e1000 for Linux 2.0.36-pre14
Date: Thu, 1 Mar 2001 21:01:03 +0200 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2448.0)
Content-Type: text/plain;
	charset="WINDOWS-1255"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Some more info:
I compiled it with support for IANS and without, but I get the same outcome,
only setting E1000_IMS_RXSEQ will cause endless interrupts that cannot be
stopped not with int_disable and not with cli(), so I guess there must be a
bug somewhere, so I activated it on 2.2.x and surprisingly it works ok.

Another thing is that without E1000_IMS_RXSEQ, I can see that the interrupt
handler is being evoked, but the driver does not try to receive or send
although I try pinging in and out of my machine.

Ofer
