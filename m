Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266746AbSKHDau>; Thu, 7 Nov 2002 22:30:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266748AbSKHDau>; Thu, 7 Nov 2002 22:30:50 -0500
Received: from fmr02.intel.com ([192.55.52.25]:38652 "EHLO
	caduceus.fm.intel.com") by vger.kernel.org with ESMTP
	id <S266746AbSKHDat>; Thu, 7 Nov 2002 22:30:49 -0500
Message-ID: <009e01c286d8$2a44e010$77d40a0a@amr.corp.intel.com>
From: "Rusty Lynch" <rusty@linux.co.intel.com>
To: <linux-kernel@vger.kernel.org>
Subject: Is there a way to interrupt MMIO with kprobes/ltt/etc...
Date: Thu, 7 Nov 2002 19:37:29 -0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1106
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have been looking into the possible ways a fault injection tool could be
implemented on the available tools/hooks in the 2.5 kernel.  I can see how
kprobes would help by allowing me to setup handlers when a specific address
is executed, but what about when a specific memory mapped IO address is
touched or looked at?

I know there has been a lot of activity on kprobes, LTT, and others (isn't
there something else?).  Do any of these patches allow a handler to be
called just before some MMIO is accessed?  Messing with architecture
specific debug registers seems problematic since it makes the solution
architecture specific and the number of watch points is pretty limited.

    -rustyl

