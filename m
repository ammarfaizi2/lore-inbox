Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282313AbRKXAXI>; Fri, 23 Nov 2001 19:23:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282305AbRKXAXB>; Fri, 23 Nov 2001 19:23:01 -0500
Received: from windsormachine.com ([206.48.122.28]:55058 "EHLO
	router.windsormachine.com") by vger.kernel.org with ESMTP
	id <S282313AbRKXAWG>; Fri, 23 Nov 2001 19:22:06 -0500
Date: Fri, 23 Nov 2001 19:21:48 -0500 (EST)
From: Mike Dresser <mdresser@windsormachine.com>
To: David Relson <relson@osagesoftware.com>
cc: "Paulo J. Matos aka PDestroy" <pocm@rnl.ist.utl.pt>,
        <linux-kernel@vger.kernel.org>
Subject: Re: Kernel Compilation Basics
In-Reply-To: <4.3.2.7.2.20011123191428.00db08a0@mail.osagesoftware.com>
Message-ID: <Pine.LNX.4.33.0111231920450.30808-100000@router.windsormachine.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 23 Nov 2001, David Relson wrote:

> At 04:57 PM 11/23/01, Paulo J. Matos aka PDestroy wrote:
> >Hi all,
> >
> >I'm trying to compile 2.4.15.
> >I've read Kernel Howto and I've done the quick compilation steps:
> >make xconfig
> >make dep
> >make clean
> >make bzImage
> >cp arch/i386/boot/bzImage /boot/vmlinuz-2.4.15
> Rather than "cp ... /boot/..."  use "make install".  If I remember
> correctly, "make install" will even add the proper entry to
> /etc/lilo.conf.  Assuming you are using lilo, you will also need to run it
> after "make modules_install".
>
> David

I've always done a make bzlilo after the dep clean, is this wrong?
Updates my lilo for me just fine.

Mike




