Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131261AbQJ1TGr>; Sat, 28 Oct 2000 15:06:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131247AbQJ1TGh>; Sat, 28 Oct 2000 15:06:37 -0400
Received: from [194.213.32.137] ([194.213.32.137]:1284 "EHLO bug.ucw.cz")
	by vger.kernel.org with ESMTP id <S131280AbQJ1TGX>;
	Sat, 28 Oct 2000 15:06:23 -0400
Date: Sat, 28 Oct 2000 13:30:06 +0000
From: Pavel Machek <pavel@suse.cz>
To: linux@cr753963-a.glph1.on.wave.home.com
Cc: Brian Gerst <bgerst@didntduck.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.4.0pre9 and an analog joystick
Message-ID: <20001028133006.A40@toy>
In-Reply-To: <39F65A6E.5B4E5BFB@didntduck.org> <Pine.LNX.4.21.0010251718300.790-100000@cr753963-a.glph1.on.wave.home.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <Pine.LNX.4.21.0010251718300.790-100000@cr753963-a.glph1.on.wave.home.com>; from linux@cr753963-a.glph1.on.wave.home.com on Wed, Oct 25, 2000 at 05:19:21PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


contact vojtech@SUSE.cz

On Wed 25-10-00 17:19:21, linux@cr753963-a.glph1.on.wave.home.com wrote:
> 
> 
> On Tue, 24 Oct 2000, Brian Gerst wrote:
> 
> > linux@cr753963-a.glph1.on.wave.home.com wrote:
> > > 
> > > I just switched from 2.2.17pre9 to 2.4.0pre9, and my joystick won't work
> > > anymore. It's an analog joystick connected to an AudioPCI sound card. I
> > > can get it initialized, but I can not access it, it seems it does not map
> > > it to js0
> > > 
> > > Oct 24 23:15:21 cr753963-a kernel: gameport0: NS558 ISA at 0x200 size 8
> > > speed 917 kHz
> > > Oct 24 23:15:31 cr753963-a kernel: input0: Analog 2-axis 4-button joystick
> > > at gameport0.0 [TSC timer, 463 MHz clock, 1193 ns res]
> > > 
> > > and I can't get any further :[
> > > 
> > > Dave
> > 
> > insmod joydev
> 
> Ok, I can get it to work with modules, but it will not work if it's
> directly compiled into the kernel, is this a known bug?
> 
> Dave
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> Please read the FAQ at http://www.tux.org/lkml/

-- 
Philips Velo 1: 1"x4"x8", 300gram, 60, 12MB, 40bogomips, linux, mutt,
details at http://atrey.karlin.mff.cuni.cz/~pavel/velo/index.html.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
