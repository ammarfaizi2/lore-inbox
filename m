Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261681AbUA0Byn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jan 2004 20:54:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261731AbUA0Byn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jan 2004 20:54:43 -0500
Received: from [203.152.107.170] ([203.152.107.170]:12672 "HELO
	skieu.myftp.org") by vger.kernel.org with SMTP id S261681AbUA0Byl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jan 2004 20:54:41 -0500
Date: Tue, 27 Jan 2004 14:56:06 +0000 (UTC)
From: haiquy@yahoo.com
X-X-Sender: sk@darkstar.example.net
Reply-To: s_kieu@hotmail.com
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.2-rc1-mm1 pppd: page allocation failure (fwd)
Message-ID: <Pine.LNX.4.53.0401271442590.919@darkstar.example.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

Sorry for the delay but I have still unable to reproduce the bug when
when compiling use standard CFLAGS in the kernel Makefile.

Best regard,


Steve Kieu

---------- Forwarded message ----------
Date: Sat, 24 Jan 2004 12:38:41 +0000 (UTC)
From: haiquy@yahoo.com
Reply-To: s_kieu@hotmail.com
To: linux-kernel@vger.kernel.org
Subject: 2.6.2-rc1-mm1 pppd: page allocation failure


Hi,

This did not happen with 2.6.1-mm4 . The system is still running fine
at the moment but I find several message in the dmesg output

pppd: page allocation failure. order:4, mode:0xd0
Call Trace: [<c01388f0>]  [<c013895f>]  [<c013b48c>]  [<c013b79e>]  [<c013bae4>]  [<c01fc177>]  [<c01f87b4>]  [<c01f6bd1>]  [<c014e742>]  [<c015f299>]  [<c02b2f67>]
pppd: page allocation failure. order:4, mode:0xd0
Call Trace: [<c01388f0>]  [<c013895f>]  [<c013b48c>]  [<c013b79e>]  [<c013bae4>]  [<c01fc177>]  [<c01f87b4>]  [<c01f6bd1>]  [<c014e742>]  [<c015f299>]  [<c02b2f67>]
pppd: page allocation failure. order:4, mode:0xd0
Call Trace: [<c01388f0>]  [<c013895f>]  [<c013b48c>]  [<c013b79e>]  [<c013bae4>]  [<c01fc177>]  [<c01f87b4>]  [<c01f6bd1>]  [<c014e742>]  [<c015f299>]  [<c02b2f67>]

If some one need further testing or information pls cc me.

Steve Kieu
