Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262498AbSJ0Tnc>; Sun, 27 Oct 2002 14:43:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262500AbSJ0Tnc>; Sun, 27 Oct 2002 14:43:32 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:20499 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S262498AbSJ0Tnb>; Sun, 27 Oct 2002 14:43:31 -0500
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH] unified SysV and Posix mqueues as FS
Date: 27 Oct 2002 11:49:43 -0800
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <aphg0n$sk$1@cesium.transmeta.com>
References: <3DBC075B.AF32C23@mac.com> <Pine.GSO.4.21.0210271052170.1416-100000@steklov.math.psu.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2002 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <Pine.GSO.4.21.0210271052170.1416-100000@steklov.math.psu.edu>
By author:    Alexander Viro <viro@math.psu.edu>
In newsgroup: linux.dev.kernel
> 
> On Sun, 27 Oct 2002, Peter Waechtler wrote:
> 
> > I applied the patch from Jakub against 2.5.44
> > There are still open issues but it's important to get this in before
> > feature freeze.
> > 
> > While you can implement Posix mqueues in userland (Irix is doing this
> > with fcntl(fd,F_SETLKW,) and shmem) a kernel implementation has some advantages:
> 
> *thud*
> 
> ioctls on _directories_, of all things?
> 

Yup.  There are plenty of them already.

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt	<amsp@zytor.com>
