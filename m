Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267330AbUJITjA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267330AbUJITjA (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Oct 2004 15:39:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267327AbUJITjA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Oct 2004 15:39:00 -0400
Received: from 168.imtp.Ilyichevsk.Odessa.UA ([195.66.192.168]:39951 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S267334AbUJITip (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Oct 2004 15:38:45 -0400
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
To: Ciucioni@netscape.net (Gustavo Solari-Bortolotti),
       linux-kernel@vger.kernel.org
Subject: Re: Mouse lock when any keyboard key is pressed at same time mouse moves
Date: Sat, 9 Oct 2004 22:38:36 +0300
User-Agent: KMail/1.5.4
References: <6FCCD038.7E24D4F9.006FAE0F@netscape.net>
In-Reply-To: <6FCCD038.7E24D4F9.006FAE0F@netscape.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="koi8-r"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200410092238.36086.vda@port.imtp.ilyichevsk.odessa.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 09 October 2004 06:28, Gustavo Solari-Bortolotti wrote:
> I am sorry I don't know who to exactly send this message to, so please bare with me.

Only if you will wrap the long lines ;)
 
> I have noticed a mouse problem since the 2.6.5 kernel release
(when I actually upgraded from 2.4.X) where the mouse locks up
every time any key is pressed while the mouse is moving.
An example of using a key press, while moving the mouse
would be to hold the ctrl key while moving the mouse to
make a non linear selected on any window environment.
 
> Here is how to reproduce:
> 
> With any Desktop manager, or virtual console loaded with
gpm, hold any key while moving the mouse.  The mouse will
lock up, and not respond.  Only when the numlock key is
pressed a couple of time (most of the time) the mouse acts
again.  The first numlock press most of the time will make
the mouse active, but acting out of wack.  If the first
numlock press did not bring the mouse back to normal,
then a second numlock press will bring the mouse back to normal.

Failed to reproduce. It probably happens only to specific
mouse types or on specific mobos.

> Once the mouse comes back to normal, the syslog throws these messages:
> 
> Oct  7 19:51:22 ciucioni kernel: psmouse.c: Wheel Mouse at isa0060/serio1/input0 lost synchronization, throwing 3 bytes away.
> Oct  7 19:51:22 ciucioni kernel: psmouse.c: Wheel Mouse at isa0060/serio1/input0 lost synchronization, throwing 1 bytes away.
> 
> Below you will find all the information I was able to get as best as I could as asked for by the guidelines.  If anyone has any questions, feel free to email me at the email above.
[snip]
> logitec Mousman ps2 mouse

VIA mobo here.

Mine is A4Tech optical with two wheels, although I didn't bother
to configure X to recognize the wheels. I don't need them that much.

dmesg says:
...
mice: PS/2 mouse device common for all mice
input: AT Translated Set 2 keyboard on isa0060/serio0
input: ImExPS/2 Generic Explorer Mouse on isa0060/serio1
...
--
vda

