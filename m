Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132808AbRDOW13>; Sun, 15 Apr 2001 18:27:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132810AbRDOW1K>; Sun, 15 Apr 2001 18:27:10 -0400
Received: from smtp01.web.de ([194.45.170.210]:16911 "HELO smtp.web.de")
	by vger.kernel.org with SMTP id <S132808AbRDOW1E>;
	Sun, 15 Apr 2001 18:27:04 -0400
Date: Mon, 16 Apr 2001 00:26:42 +0200
From: Stefan Frank <stefrank@web.de>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: 3dfx framebuffer problems with 2.4.4-pre[1-3]
Message-ID: <20010416002642.A2631@k6>
Mail-Followup-To: linux-kernel <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
X-Operating-System: Linux 2.4.3
X-PGP: PGP-key available
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I have a problem with the 3dfx framebuffer since 2.4.4-pre1.
I have the following append line in my lilo.conf:
append = "video=tdfx:1280x1024-8@76"

This setting works fine for the 2.4.[0-3] kernels.

When I boot the box, the little penguin on the top left side is unrecognizable.

When I exit X, the console is just black with a blinking cursor. I can type
commands "blind" but nothing appears on the screen. The system seems to work
normal because the commands are executed, the only problem is that the screen
is black.

Using fbset or resetting the console doesn't help.

fbtv (from the xawtv-package) works fine, also on the "black and
blinking" console.

My card is a 3dfx Voodoo3 2000 PCI (16MB).

gcc        2.95.2
make       2.79.1
binutils   2.9.5.0.24
util-linux 2.10q
modutils   2.4.5
e2fsprogs  1.19
PPP        2.4.0

Let me know, if I can provide more information.
Perhaps I have a configuration failure?
(I'm not a linux guru and a good programmer)

Thanks a lot,
Steff

