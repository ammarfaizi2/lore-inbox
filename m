Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262440AbSJ0PrS>; Sun, 27 Oct 2002 10:47:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262441AbSJ0PrS>; Sun, 27 Oct 2002 10:47:18 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:21472 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S262440AbSJ0PrR>;
	Sun, 27 Oct 2002 10:47:17 -0500
Date: Sun, 27 Oct 2002 10:53:10 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Peter Waechtler <pwaechtler@mac.com>
cc: linux-kernel@vger.kernel.org, jakub@redhat.com, torvalds@transmeta.com
Subject: Re: [PATCH] unified SysV and Posix mqueues as FS
In-Reply-To: <3DBC075B.AF32C23@mac.com>
Message-ID: <Pine.GSO.4.21.0210271052170.1416-100000@steklov.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 27 Oct 2002, Peter Waechtler wrote:

> I applied the patch from Jakub against 2.5.44
> There are still open issues but it's important to get this in before
> feature freeze.
> 
> While you can implement Posix mqueues in userland (Irix is doing this
> with fcntl(fd,F_SETLKW,) and shmem) a kernel implementation has some advantages:

*thud*

ioctls on _directories_, of all things?

