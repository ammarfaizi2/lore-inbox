Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282329AbRLAW4T>; Sat, 1 Dec 2001 17:56:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282328AbRLAW4C>; Sat, 1 Dec 2001 17:56:02 -0500
Received: from 119-LASP-X11.libre.retevision.es ([62.83.114.119]:56449 "HELO
	rendevouz.ddts.net") by vger.kernel.org with SMTP
	id <S282039AbRLAWzn>; Sat, 1 Dec 2001 17:55:43 -0500
Message-ID: <XFMail.20011201230159.kernelin@softhome.net>
X-Mailer: XFMail 1.4.7p2 on Linux
X-Priority: 3 (Normal)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
MIME-Version: 1.0
In-Reply-To: <3C0952F5.2050802@twobit.net>
Date: Sat, 01 Dec 2001 23:01:59 -0000 (WET)
Reply-To: debianiz@softhome.net
From: kernelin@softhome.net
To: linux-kernel@vger.kernel.org
Subject: RE: rivafb
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi:

        I've the same problem. It's seems like a conflict of the nvidia drivers
and rivafb. Try to unload the nvidia_kernel module and use in X the nv
driver who comes with the X, that works (at least with my GForce2 Pro), but if
you do this, you'll loose the nvidia hardware acceleration...

        
>Hi all you smart folk.
>    I've been trying to use the rivafb driver for my console, because I 
>like 1024x768 console resolution, but dislike the slowness of the vesa 
>framebuffer.  Every time I start X and then switch to a text console, it 
>begins to mess up (my cursor turns into 2 purple dots) and if I try to 
>switch back to X the console is completely corrupted, forcing me to 
>reboot.  Is there a conflict that makes it incorrect to use a 
>framebuffer text console and a different accelerated X console?  Or is 
>this a bug in the memory handling of the rivafb that makes it conflict 
>with the NVidia accelerated stuff, OR can I not ask this here, because 
>I'm using the unlicensed NVidia kernel drivers?

>Thanks!



