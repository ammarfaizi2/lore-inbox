Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268358AbRG3Voh>; Mon, 30 Jul 2001 17:44:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268382AbRG3Vo2>; Mon, 30 Jul 2001 17:44:28 -0400
Received: from Bf824.pppool.de ([213.7.248.36]:2435 "HELO finnegan")
	by vger.kernel.org with SMTP id <S268358AbRG3VoL>;
	Mon, 30 Jul 2001 17:44:11 -0400
Date: Mon, 30 Jul 2001 23:44:13 +0200 (CEST)
From: Peter Koellner <peter@mezzo.net>
To: linux-kernel@vger.kernel.org
Subject: another vaio with broken apm support.
Message-ID: <Pine.LNX.4.21.0107302330020.710-100000@finnegan.do.mezzo.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

hi!

this is a sony vaio PCG-FX209K(DE), with bios R0211U0. it tells me that
it has no battery and is always AC online, regardless of pulling the plug.

/proc/apm looks like this:

1.14 1.2 0x03 0x01 0xff 0x80 -1% -1 ?

so, apm delivers this:

AC on-line, no system battery

i tried kernels 2.4.7  plain and 2.4.7-ac3. i looked into 
arch/i386/kernel/apm.c and dmi_scan.c, but i am not too sure what to do 
to fix this. i guess it can't be too different from the other vaio
variants. where do i have to look for the missing pieces?

-- 
peter koellner <peter@mezzo.net>


