Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132370AbRDCDAG>; Mon, 2 Apr 2001 23:00:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132471AbRDCC74>; Mon, 2 Apr 2001 22:59:56 -0400
Received: from warden.digitalinsight.com ([208.29.163.2]:58338 "HELO
	warden.diginsite.com") by vger.kernel.org with SMTP
	id <S132459AbRDCC7q>; Mon, 2 Apr 2001 22:59:46 -0400
Date: Mon, 2 Apr 2001 19:52:49 -0700 (PDT)
From: David Lang <dlang@diginsite.com>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
cc: Jeremy Jackson <jerj@coplanar.net>, Ian Soboroff <ian@cs.umbc.edu>,
        <linux-kernel@vger.kernel.org>
Subject: Re: /proc/config idea
In-Reply-To: <3AC91E05.F11BFF43@mandrakesoft.com>
Message-ID: <Pine.LNX.4.33.0104021951450.30568-100000@dlang.diginsite.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


a module for 2.4.3 will work for any 2.4.3 kernel that supports modules
at all (except for the SMP vs UP issue) so it's not the same thing as
trying to figure out which if the 2.4.3 kernels matches what you are
running.

David Lang

On Mon, 2 Apr 2001, Jeff Garzik wrote:

> Date: Mon, 02 Apr 2001 20:49:09 -0400
> From: Jeff Garzik <jgarzik@mandrakesoft.com>
> To: Jeremy Jackson <jerj@coplanar.net>
> Cc: Ian Soboroff <ian@cs.umbc.edu>, linux-kernel@vger.kernel.org
> Subject: Re: /proc/config idea
>
> Jeremy Jackson wrote:
> > If you have a lot of kernels around, which Config-2.4.3 applies to kernel 2.4.3
> > given 5 to choose from...the idea (same for System.map) is that it being in the
> > same
> > file they can't be confused.  Kinda like forks under Mac (but let's not go there
> > now)
>
> The same applies to kernel modules too.  Are you going to put all those
> in the kernel image too?
>
> If it's a file, read it from a filesystem after the kernel has booted.
> There is no need to special case this stuff.
>
> --
> Jeff Garzik       | May you have warm words on a cold evening,
> Building 1024     | a full moon on a dark night,
> MandrakeSoft      | and a smooth road all the way to your door.
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

