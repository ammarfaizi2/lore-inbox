Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262883AbUCJXlH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Mar 2004 18:41:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262765AbUCJXlH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Mar 2004 18:41:07 -0500
Received: from main.gmane.org ([80.91.224.249]:53996 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S262883AbUCJXkK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Mar 2004 18:40:10 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Giuseppe Bilotta <bilotta78@hotpop.com>
Subject: Framebuffer with nVidia GeForce 2 Go on Dell Inspiron 8200
Date: Wed, 10 Mar 2004 23:38:02 +0000 (UTC)
Message-ID: <c2o8sp$h3j$1@sea.gmane.org>
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: ppp-69-130.29-151.libero.it
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Date: Thu, 11 Mar 2004 00:37:58 +0100
Message-ID: <MPG.1ab9c538eb2f9b69989681@news.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
X-Newsreader: MicroPlanet Gravity v2.60

Hello,

I have recently started to migrate to Linux on my DELL laptop; 
everything is going pretty smoothly, but one thing I can't seem to 
enable is the framebuffer to take advantage, in console, of the high 
resolution my video card and monitor can afford.

The video card is an nVidia GeForce 2 Go, on a Dell Inspiron 8200, 
and the monitor is their UXGA monitor (1600x1200). The system BIOS is 
version A11, which means the video card BIOS is up to version 
3.11.01.44.D1.

The system I'm running is a Debian testing/unstable updated every two 
or three days.

I tried the following things with the kernels 2.4.22, 2.6.0, 2.6.1, 
2.6.2, 2.6.3 (self-compiled) more or less always with the same 
results:

1. The vga framebuffer works. I can even bring the monitor to 800x600 
in tweaked VGA mode.

2. The VESA framebuffer does not work. Apparently, the card is not 
detected as VESA-compatible. (I'm not 100% sure about this --how can 
I check if this is indeed the case?)

3. The Riva framebuffer doesn't work either. It detects the video 
card all right, understands that I'm running on a laptop and thus 
with an LCD monitor, but as soon as I "touch" it (be it even just 
with a fbset -i to find the information), the screen goes blank or 
has some very funny graphical effects (fade to black in the middle, 
etc). The system doesn't lock up (I can still blind-type and reset 
it), but I can't use it.

Does anybody know what could be wrong?


The only thing which I can think of is that even Windows drivers have 
problems with this particular setup; the only documentation I could 
find on the matter is here

http://www.laptopvideo2go.com/

(Go to "Dell laptop owners")

HTH,

-- 
Giuseppe "Oblomov" Bilotta

Can't you see
It all makes perfect sense
Expressed in dollar and cents
Pounds shillings and pence
                  (Roger Waters)

