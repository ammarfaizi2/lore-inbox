Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135344AbRDZMJq>; Thu, 26 Apr 2001 08:09:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135346AbRDZMJg>; Thu, 26 Apr 2001 08:09:36 -0400
Received: from cr803443-a.flfrd1.on.wave.home.com ([24.156.64.178]:46978 "EHLO
	fxian.jukie.net") by vger.kernel.org with ESMTP id <S135344AbRDZMJb>;
	Thu, 26 Apr 2001 08:09:31 -0400
Date: Thu, 26 Apr 2001 08:09:06 -0400 (EDT)
From: Feng Xian <fxian@fxian.jukie.net>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
cc: <linux-kernel@vger.kernel.org>, Feng Xian <fxian@chrysalis-its.com>
Subject: Re: __alloc_pages: 4-order allocation failed
In-Reply-To: <Pine.LNX.4.21.0104252247480.1088-100000@freak.distro.conectiva>
Message-ID: <Pine.LNX.4.30.0104260807001.6221-100000@tiger>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 25 Apr 2001, Marcelo Tosatti wrote:

>
>
> On Wed, 25 Apr 2001, Feng Xian wrote:
>
> > Hi,
> >
> > I am running linux-2.4.3 on a Dell dual PIII machine with 128M memory.
> > After the machine runs a while, dmesg shows,
> >
> > __alloc_pages: 4-order allocation failed.
> > __alloc_pages: 3-order allocation failed.
> > __alloc_pages: 4-order allocation failed.
> > __alloc_pages: 4-order allocation failed.
> > __alloc_pages: 4-order allocation failed.
> > __alloc_pages: 4-order allocation failed.
> >
> >
> > and sometime the system will crash. I looked into the memory info,
> > there still has some free physical memory (20M) left and swap space is
> > almost not in use. (250M swap)
> >
> > I didn't have this problem when I ran 2.4.0 (I even didn't see it on
> > 2.4.2) could anybody tell me what's wrong or where should I look into this
> > problem?
>
> Feng,
>
> Which apps are you running when this happens ?

It looks like the X consumes most of the memory (almost used up all the
physical memory, more than 100M), it uses NVidia driver. I was also
running pppoe but that took less memory.

>
> Thanks
>
>

-- 
 Feng Xian

