Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281016AbRKGVpo>; Wed, 7 Nov 2001 16:45:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281015AbRKGVpU>; Wed, 7 Nov 2001 16:45:20 -0500
Received: from freeside.toyota.com ([63.87.74.7]:33543 "EHLO toyota.com")
	by vger.kernel.org with ESMTP id <S281006AbRKGVof>;
	Wed, 7 Nov 2001 16:44:35 -0500
Message-ID: <3BE9AB3A.DFC6855F@lexus.com>
Date: Wed, 07 Nov 2001 13:44:27 -0800
From: J Sloan <jjs@lexus.com>
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.14 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: rpjday <rpjday@mindspring.com>
CC: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: kernel 2.4.14 compiling fail for loop device
In-Reply-To: <Pine.LNX.4.33.0111070656540.4140-100000@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

rpjday wrote:

> On Wed, 7 Nov 2001, J Sloan wrote:
>
> > "Mohammad A. Haque" wrote:
> >
> > > On Wednesday, November 7, 2001, at 03:49 PM, Roeland Th. Jansen wrote:
> > >
> > > > when mounting an EFS cd on the loop it also froze. this is _without_
> > > > removing the lines. ...
> > >
> > > I'm a little confused. How did you even get a working kernel (or module)
> > > without removing the lines?
> > >
> >
> > Probably compiled it modular -
>
> if you try to compile it modular, the "make modules" will work, but
> the "make modules_install" will choke after copying the modules under
> /lib/modules when it tries to run the final "depmod" at the end.
>
> so, yes, i'm curious -- how did he get a final kernel and modules
> without removing those lines?

I got a kernel and modules without removing those
lines - it complains at depmod, but the kernel and
modules do build and install -

I didn't ever boot to that kernel since the warning
bothered me, and I fixed the source and recompiled
before booting into 2.4.14 -

cu

jjs

