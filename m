Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265249AbSLTT2S>; Fri, 20 Dec 2002 14:28:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265255AbSLTT2S>; Fri, 20 Dec 2002 14:28:18 -0500
Received: from [213.171.53.133] ([213.171.53.133]:61703 "EHLO gulipin.miee.ru")
	by vger.kernel.org with ESMTP id <S265249AbSLTT2R>;
	Fri, 20 Dec 2002 14:28:17 -0500
Date: Fri, 20 Dec 2002 22:37:28 +0300
From: "Ruslan U. Zakirov" <cubic@wr.miee.ru>
X-Mailer: The Bat! (v1.61)
Reply-To: "Ruslan U. Zakirov" <cubic@wr.miee.ru>
Organization: CITL MIEE
X-Priority: 3 (Normal)
Message-ID: <100701659052.20021220223728@wr.miee.ru>
To: James Simmons <jsimmons@infradead.org>
CC: linux-kernel@vger.kernel.org
Subject: fbset in startup script and atyfb problems.
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

        Hello, James and other.
I've put fbset 800x600-90 in my /etc/rc.d/rc.local
Under 2.4.20 I have only one console switched to this resolution.
Under 2.5.50 all consoles switch to this(this better for me).
Is this expected behavior?

And I have some problems with atyfb driver:
Config was right. Without vesafb and vgacon, with fbcon.
2.5.51-vanilla: It was working fine, but with machine hangs randomly.
2.5.52-vanilla: I'm pressing ^C or Enter to print bash's empty
lines, it's ok while cursor at the screen. When we at the botom
line and with the next line we will need to scroll down screen,
nothing happens. Lines goes down, but we see same screen. Switch to
other console and then back, turn us to the right plase of the console
buffer, but last line in the middle of the screen. I think it's 25
string like in default mode(80x25).

Best regards.
                       Ruslan.
PS. Sorry for my bad knowing of English.

