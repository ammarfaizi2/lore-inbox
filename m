Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265969AbUAFXYg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jan 2004 18:24:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265992AbUAFXYg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jan 2004 18:24:36 -0500
Received: from smtp0.libero.it ([193.70.192.33]:48791 "EHLO smtp0.libero.it")
	by vger.kernel.org with ESMTP id S265969AbUAFXYd convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jan 2004 18:24:33 -0500
From: "Mario ''Jorge'' Di Nitto" <jorge78@inwind.it>
To: James Simmons <jsimmons@infradead.org>
Subject: Re: [Oops] 2.6.1-rc1-mm1 and Sisfb
Date: Tue, 6 Jan 2004 23:24:37 +0100
User-Agent: KMail/1.5.4
References: <Pine.LNX.4.44.0401052141410.3150-100000@phoenix.infradead.org>
In-Reply-To: <Pine.LNX.4.44.0401052141410.3150-100000@phoenix.infradead.org>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200401060225.56953.jorge78@inwind.it>
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alle 22:45, lunedì 5 gennaio 2004, James Simmons ha scritto:
Hi James,
[cut]
>
> Can you give my latest patch a try.
>
> http://phoenix.infradead.org/~jsimmons/fbdev.diff.gz

I've just now finished to patch, compile and install 2.6.1-rc1 and it seems to 
be ok, without any error.
Your patch doesn't apply clearly over rc1-mm1 or rc1-mm2 (too many hunks 
failed), so I've tryied to patch vanilla rc1.
Reboot was ok, without any warning or error about framebuffer.
I use XFree from debian experimental (4.3.0-0pre1v4) and now it appears more 
smooth than with 2.4.23-ck1! (thanks a lot!!!)
At system startup I always choose video=sisfb:1024x768x256 to show linux logo 
but if I try to boot without it, all characters aren't displayed very well... 
Glxgears shows me 250 Fps (exactly as 2.4), but when cpu (p4m 1.6 ghz) reachs 
100%, ALT-TAB switching between apps is not fluid like with 2.4...  
Probably it's a scheduler issue...
However, it's a great job!!!
So, what about your patches in 2.6 mainline ?

Ok ok ...  only another question... :)
Do you have some news about DRI for my SiS chipset? 

glxinfo shows me:
------------------------------
D998:/home/io# glxinfo
name of display: :0.0
Xlib:  extension "XFree86-DRI" missing on display ":0.0".
display: :0  screen: 0
direct rendering: No
server glx vendor string: SGI
server glx version string: 1.2
server glx extensions:
....

TIA,
					Jorge
PS: sorry for all lexical mistakes I made...

