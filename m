Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269238AbRIBVIR>; Sun, 2 Sep 2001 17:08:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269326AbRIBVIH>; Sun, 2 Sep 2001 17:08:07 -0400
Received: from [145.254.149.228] ([145.254.149.228]:23534 "HELO
	schottelius.org") by vger.kernel.org with SMTP id <S269238AbRIBVHw>;
	Sun, 2 Sep 2001 17:07:52 -0400
Message-ID: <3B929F72.28BAF955@pcsystems.de>
Date: Sun, 02 Sep 2001 23:06:58 +0200
From: Nico Schottelius <nicos@pcsystems.de>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.7 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Martin Mares <mj@ucw.cz>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH]: problem: pc_keyb.h
In-Reply-To: <3B8FE42B.23804609@pcsystems.de> <20010831213050.A3217@albireo.ucw.cz>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Martin!


> > Why can't I include pc_keyb.h directtly into a C program ?
> > I need that for a part of GPM.
>
> pc_keyb.h is a kernel include, thus it uses the kernel set of types
> which unfortunately collides badly with the types used in user space.

Oh, didn't know that.

> The best solution is to create your own include and copy the
> relevant parts of pc_keyb.h there.

hmm.. I just use some definations:

AUX_*

> BTW what exactly do you plan to do? Sending keyboard controller
> or mouse controller commands from user space is probably very
> dangerous as it's going to collide with the commands sent by the
> kernel.

It's gpm what I am working on. I am the current maintainer.
We get the mouse id.

Martin, can't you add the line I sent in the last mail ?
This would make it possible to include
pc_keyb.h into many programs directly.

Nico

