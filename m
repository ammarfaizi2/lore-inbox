Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313725AbSDPP5y>; Tue, 16 Apr 2002 11:57:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313727AbSDPP5x>; Tue, 16 Apr 2002 11:57:53 -0400
Received: from smtp-sec1.zid.nextra.de ([212.255.127.204]:46348 "EHLO
	smtp-sec1.zid.nextra.de") by vger.kernel.org with ESMTP
	id <S313725AbSDPP5w>; Tue, 16 Apr 2002 11:57:52 -0400
Date: Tue, 16 Apr 2002 17:57:22 +0200 (CEST)
From: Guennadi Liakhovetski <gl@dsa-ac.de>
To: <linux-kernel@vger.kernel.org>
Subject: drivers/char/serial.c in 2.5 versus 2.4...
Message-ID: <Pine.LNX.4.33.0204161750460.15512-100000@pcgl.dsa-ac.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello

We were using this driver successfully with 2.4 kernels on trizeps
Strong-ARM boards, then, when we ported our patch to 2.5, the situation
changed - sending data TO the board from, say, a PC works, but not the
other way round... I enabled debugging in the driver, so, I see that
transmit_chars is called, the parameters are fine, then it calls
serial_out - but nothing happens... UART is an ordinary 16550A. Any ideas
as what has changed between 2.4.13 and 2.5.6 that would require special
attention are welcome.

Thanks
Guennadi
---------------------------------
Guennadi Liakhovetski, Ph.D.
DSA Daten- und Systemtechnik GmbH
Pascalstr. 28
D-52076 Aachen
Germany

