Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316135AbSGASh1>; Mon, 1 Jul 2002 14:37:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316158AbSGASh0>; Mon, 1 Jul 2002 14:37:26 -0400
Received: from rtlab.med.cornell.edu ([140.251.145.175]:27532 "HELO
	openlab.rtlab.org") by vger.kernel.org with SMTP id <S316135AbSGAShZ>;
	Mon, 1 Jul 2002 14:37:25 -0400
Date: Mon, 1 Jul 2002 14:39:53 -0400 (EDT)
From: "Calin A. Culianu" <calin@ajvar.org>
X-X-Sender: <calin@rtlab.med.cornell.edu>
To: Timo Benk <t_benk@web.de>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: allocate memory in userspace
In-Reply-To: <20020701172659.GA4431@toshiba>
Message-ID: <Pine.LNX.4.33L2.0207011439410.26062-100000@rtlab.med.cornell.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Why don't you just exec a process?

On Mon, 1 Jul 2002, Timo Benk wrote:

> Hi,
>
> I am a kernel newbie and i am writing a module. I
> need to allocate some memory in userspace because
> i want to access syscalls like open(), lstat() etc.
> I need to call these methods in the kernel, and in
> my special case there is no other way, but i
> do not want to reimplement all the syscalls.
>
> I read that it should be possible, but i cannot
> find any example or recipe on how to do it.
> It should work with do_mmap() and fd=-1 and
> MAP_ANON, but i jusst can't get it to work.
>
> Do you now any working example, or a good reference
> for the do_mmap() call?
>
> Thanks in advance,
>
> -timo
>
>

