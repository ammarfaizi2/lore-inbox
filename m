Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266043AbTA3C3S>; Wed, 29 Jan 2003 21:29:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267348AbTA3C3R>; Wed, 29 Jan 2003 21:29:17 -0500
Received: from smtp2.clear.net.nz ([203.97.37.27]:51908 "EHLO
	smtp2.clear.net.nz") by vger.kernel.org with ESMTP
	id <S266043AbTA3C3R>; Wed, 29 Jan 2003 21:29:17 -0500
Date: Thu, 30 Jan 2003 15:41:15 +1300
From: Nigel Cunningham <ncunningham@clear.net.nz>
Subject: drivers/char/keyboard.c now unused?
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Message-id: <1043894474.1623.6.camel@laptop-linux.cunninghams>
Organization: 
MIME-version: 1.0
X-Mailer: Ximian Evolution 1.2.1
Content-type: text/plain
Content-transfer-encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all.

I've been doing some work on porting my patches to the 2.4 version of
software suspend to 2.5. Under 2.4, I use the shift_state variable from
drivers/char/keyboard.c to provide interactive, step-by-step progression
through the process. That is, there is an option for you to be able to
press and release shift before the next stage starts. With the new input
layer, drivers/char/keyboard.c still exists, but seems to be unused. Can
I get confirmation that my understand is correct, and (if possible) a
pointer to information on how I can reimplement the functionality under
2.5?

Oh and before anyone has a hernia, I'm not intending to leave this
functionality in the final version - its just for debugging purposes.

Thanks in advance,

Nigel

