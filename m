Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262098AbTLSIrG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Dec 2003 03:47:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262101AbTLSIrG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Dec 2003 03:47:06 -0500
Received: from mail.convergence.de ([212.84.236.4]:22445 "EHLO
	mail.convergence.de") by vger.kernel.org with ESMTP id S262098AbTLSIrD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Dec 2003 03:47:03 -0500
Message-ID: <3FE2BB05.1000107@convergence.de>
Date: Fri, 19 Dec 2003 09:47:01 +0100
From: Michael Hunold <hunold@convergence.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de-AT; rv:1.6b) Gecko/20031205 Thunderbird/0.4
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Steffen Schwientek <schwientek@web.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.6-test11 framebuffer Matrox
References: <200312190314.13138.schwientek@web.de>
In-Reply-To: <200312190314.13138.schwientek@web.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Steffen,

> My Matrox-framebuffer is not working properly. Build direct into the
> kernel, the monitor will be black with some stripes at startup, just the
> reset button works.
> Build as a modules, the same happens if I load the module.

Hmm, I just tested with the 2.6.0 release and my both cards are working 
properly now. The only thing is a huge white box around the penguin logo.

Here is "lspci -v" of the cards I tested:

00:0a.0 VGA compatible controller: Matrox Graphics, Inc. MGA G200 (rev 
01) (prog-if 00 [VGA])
	Subsystem: Matrox Graphics, Inc. Millennium G200 SD
	Flags: bus master, medium devsel, latency 64, IRQ 11
	Memory at dd000000 (32-bit, prefetchable) [size=16M]
	Memory at dfffc000 (32-bit, non-prefetchable) [size=16K]
	Memory at df000000 (32-bit, non-prefetchable) [size=8M]
	Expansion ROM at dffe0000 [disabled] [size=64K]
	Capabilities: [dc] Power Management version 1

01:00.0 VGA compatible controller: Matrox Graphics, Inc. MGA G400 AGP 
(rev 03) (prog-if 00 [VGA])
	Subsystem: Giga-byte Technology GA-G400
	Flags: bus master, medium devsel, latency 64, IRQ 11
	Memory at dc000000 (32-bit, prefetchable) [size=32M]
	Memory at dfafc000 (32-bit, non-prefetchable) [size=16K]
	Memory at df000000 (32-bit, non-prefetchable) [size=8M]
	Expansion ROM at dfae0000 [disabled] [size=64K]
	Capabilities: [dc] Power Management version 2
	Capabilities: [f0] AGP version 2.0

> Steffen

CU
Michael.
