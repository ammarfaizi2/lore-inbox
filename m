Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293680AbSFBTKW>; Sun, 2 Jun 2002 15:10:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311885AbSFBTKV>; Sun, 2 Jun 2002 15:10:21 -0400
Received: from mail.gmx.net ([213.165.64.20]:30802 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id <S293680AbSFBTKU>;
	Sun, 2 Jun 2002 15:10:20 -0400
Date: Sun, 2 Jun 2002 21:10:14 +0200
From: Hanno =?ISO-8859-1?Q?B=F6ck?= <hanno@gmx.de>
To: linux-kernel@vger.kernel.org
Subject: radeon framebuffer problem
Message-Id: <20020602211014.3ccbe57e.hanno@gmx.de>
Organization: Mecronome Webdesign - http://www.mecronome.de/
X-Mailer: Sylpheed version 0.7.6claws (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I can't get the radeon framebuffer working.

If I use plain kernel 2.4.18, it doesn't work at all, it says
"cannot map FB"
(complete kernel-output:
Jun  2 19:55:35 hannonb kernel: radeonfb: ref_clk=2700, ref_div=60, xclk=16600 from BIOS
Jun  2 19:55:35 hannonb kernel: radeonfb: panel ID string: 1024x768                
Jun  2 19:55:35 hannonb kernel: radeonfb: detected DFP panel size from BIOS: 1024x768
Jun  2 19:55:35 hannonb kernel: radeonfb: cannot map FB
)

If I use kernel-2.4.18-pre9-ac3 with vga=ask and vga=normal, I get the same error.
If I use an explicit graphics-mode (e.g. vga=791), the screen is just black (X Starts, but I don't have a console).

My card is a Radeon Mobility M6 LY.
All kernels are with radeon framebuffer compiled in as the only framebuffer.

Any idea what is wrong?

cu,

Hanno
