Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280821AbRKGVlo>; Wed, 7 Nov 2001 16:41:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280991AbRKGVle>; Wed, 7 Nov 2001 16:41:34 -0500
Received: from smtp6.mindspring.com ([207.69.200.110]:43 "EHLO
	smtp6.mindspring.com") by vger.kernel.org with ESMTP
	id <S281005AbRKGVlZ>; Wed, 7 Nov 2001 16:41:25 -0500
Date: Wed, 7 Nov 2001 06:58:11 -0500 (EST)
From: rpjday <rpjday@mindspring.com>
X-X-Sender: <rpjday@localhost.localdomain>
To: J Sloan <jjs@lexus.com>
cc: "Mohammad A. Haque" <mhaque@haque.net>,
        Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: kernel 2.4.14 compiling fail for loop device
In-Reply-To: <3BE9A8D2.22D46175@lexus.com>
Message-ID: <Pine.LNX.4.33.0111070656540.4140-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 7 Nov 2001, J Sloan wrote:

> "Mohammad A. Haque" wrote:
> 
> > On Wednesday, November 7, 2001, at 03:49 PM, Roeland Th. Jansen wrote:
> >
> > > when mounting an EFS cd on the loop it also froze. this is _without_
> > > removing the lines. ...
> >
> > I'm a little confused. How did you even get a working kernel (or module)
> > without removing the lines?
> >
> 
> Probably compiled it modular -

if you try to compile it modular, the "make modules" will work, but
the "make modules_install" will choke after copying the modules under
/lib/modules when it tries to run the final "depmod" at the end.

so, yes, i'm curious -- how did he get a final kernel and modules
without removing those lines?

rday

