Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316391AbSEVRkA>; Wed, 22 May 2002 13:40:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316421AbSEVRj7>; Wed, 22 May 2002 13:39:59 -0400
Received: from www.transvirtual.com ([206.14.214.140]:1546 "EHLO
	www.transvirtual.com") by vger.kernel.org with ESMTP
	id <S316391AbSEVRj5>; Wed, 22 May 2002 13:39:57 -0400
Date: Wed, 22 May 2002 10:39:33 -0700 (PDT)
From: James Simmons <jsimmons@transvirtual.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: vojtech@suse.cz, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.5.17 /dev/ports
In-Reply-To: <E17AZrv-0002Ia-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.10.10205221034210.4611-100000@www.transvirtual.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > Alan you are thinking to PC here. On embedded devices that run X it is
> > just extra over head to use the VT interface. It would be much lighter
> > weigth to use the /dev/input/event interface. Personally I like to see
> > KBDRATE and alot of other junk go away in the console code. Intead we
> > just use the input api and /dev/fb with DRI. I have talked to Jim Getty
> > about this and likes to see things head in this direction.
> 
> DRI ? What good is DRI to me on an embedded box. 

You be surprised what is coming out soon into the embedded market :-) 3D
will soon be coming to small hand held devices!!

> What good is an fb driver when my hardware does text mode ? 

Text mode is the expection not the norm. 

> Why do I want the whole input layer loaded for a single fixed keyboard
> controller, or a serial interface driven by user mode ?

One is portablity. The input layer handles more than just keyboards.
All input devices look the same. Most embedded devices with input
interfaces have more than one type of input device (touchscreen,
attachable keyboards, buttons etc). Plus the input layer is modular and it
is small. 

