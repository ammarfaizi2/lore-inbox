Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281241AbRKTTgh>; Tue, 20 Nov 2001 14:36:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281284AbRKTTg0>; Tue, 20 Nov 2001 14:36:26 -0500
Received: from erasmus.jurri.net ([62.236.96.196]:9088 "EHLO
	oberon.erasmus.jurri.net") by vger.kernel.org with ESMTP
	id <S281274AbRKTTgQ>; Tue, 20 Nov 2001 14:36:16 -0500
To: linux-kernel@vger.kernel.org
Subject: 2.4.15pre7: kernel: invalidate: busy buffer
From: Samuli Suonpaa <suonpaa@iki.fi>
Date: 20 Nov 2001 21:31:46 +0200
Message-ID: <87itc5dysd.fsf@puck.erasmus.jurri.net>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.4 (Artificial Intelligence)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

After booting with 2.4.15pre7 for the first time, I got a screeful of
messages saying: "invalidate: busy buffer".

>From my syslog:

Nov 20 21:20:27 oberon kernel: invalidate: busy buffer
Nov 20 21:20:27 oberon last message repeated 55 times
Nov 20 21:20:27 oberon kernel: invalidate: dirty buffer
Nov 20 21:20:27 oberon kernel: invalidate: busy buffer
Nov 20 21:20:27 oberon kernel: invalidate: dirty buffer
Nov 20 21:20:27 oberon kernel: invalidate: busy buffer
Nov 20 21:20:27 oberon kernel: invalidate: dirty buffer
Nov 20 21:20:27 oberon kernel: invalidate: busy buffer

Since I do not know what this should tell me, I'd appreciate if
somebody told me what this is all about. I can, of course, provide
more information if necessary. But since I don't have a clue on what
this would be related to (other that the printk seems to be in
buffer.c) I have no idea of what information might be useful.

Suonp‰‰...
