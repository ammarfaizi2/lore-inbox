Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266867AbRGTJaB>; Fri, 20 Jul 2001 05:30:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266870AbRGTJ3v>; Fri, 20 Jul 2001 05:29:51 -0400
Received: from mail19.bigmailbox.com ([209.132.220.50]:65036 "EHLO
	mail19.bigmailbox.com") by vger.kernel.org with ESMTP
	id <S266867AbRGTJ3j>; Fri, 20 Jul 2001 05:29:39 -0400
Date: Fri, 20 Jul 2001 02:28:52 -0700
Message-Id: <200107200928.CAA25069@mail19.bigmailbox.com>
Content-Type: text/plain
Content-Disposition: inline
Content-Transfer-Encoding: binary
X-Mailer: MIME-tools 4.104 (Entity 4.116)
Mime-Version: 1.0
X-Originating-Ip: [64.40.45.173]
From: "Colin Bayer" <colin_bayer@compnerd.net>
To: hmallat@cc.hut.fi
Cc: linux-kernel@vger.kernel.org
Subject: Framebuffer woes with 3dfx Voodoo5 5500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

When I boot up my home box, a Pentium III/933MHz with an i810 onboard disabled to make way for a 3dfx Voodoo5 5500 PCI, two main problems occur if I boot my framebuffered kernel (2.4.7-pre7):

1) It won't support anything over 640x480.  I've got the buffer set up to run in 1024x768x32, and it reverts to 640x480x32.

2) Corrupted cursors: until I start XFree86, the terminal cursors are corrupted; they're maybe 80x60 pixels and rendered as randomly black-and-white pixels.

I know that because 3dfx is now no longer extant, there's fairly little chance that this will ever be resolved, but I currently have to boot with my non-frame-buffered kernel, which keeps me from seeing *cute widdle Tux* at boot-up. 8-)

     -- Colin


Colin Bayer <vogon_jeltz@users.sourceforge.net>
Windows emulator for Linux: #include <stdio.h> 
int main() { int n = *(int *)NULL; }
fortytwo: Linux kernel 2.4.7-pre7 (i686; 1854.66 BogoMips)

------------------------------------------------------------
The CompNerd Network: http://www.compnerd.com/
Where a nerd can be a nerd.  Get your free webmail@compnerd.net!
