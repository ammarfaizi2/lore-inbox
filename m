Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272580AbRHaBbI>; Thu, 30 Aug 2001 21:31:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272582AbRHaBa6>; Thu, 30 Aug 2001 21:30:58 -0400
Received: from jupter.networx.com.br ([200.187.100.102]:49052 "EHLO
	jupter.networx.com.br") by vger.kernel.org with ESMTP
	id <S272580AbRHaBar>; Thu, 30 Aug 2001 21:30:47 -0400
Message-Id: <200108310122.f7V1Mas12778@jupter.networx.com.br>
Content-Type: text/plain; charset=US-ASCII
From: Thiago Vinhas de Moraes <tvlists@networx.com.br>
Organization: NetWorx - A SuaCompanhia.com
To: Trond Myklebust <trond.myklebust@fys.uio.no>,
        "Kevin P. Fleming" <kevin@labsysgrp.com>
Subject: Re: 2.4.9-ac1/2/3 allows multiple mounts of NFS filesystem on same mountpoint
Date: Thu, 30 Aug 2001 22:23:57 -0300
X-Mailer: KMail [version 1.3.1]
Cc: <linux-kernel@vger.kernel.org>
In-Reply-To: <000901c13179$be7b9ae0$6caaa8c0@kevin> <shsd75d2whg.fsf@charged.uio.no>
In-Reply-To: <shsd75d2whg.fsf@charged.uio.no>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Em Qui, 30 de Ago de 2001 16:12, Trond Myklebust escreveu:
> >>>>> " " == Kevin P Fleming <kevin@labsysgrp.com> writes:
>      > Accidentally <G> I mounted a filesystem from my server onto my
>      > workstation twice. Mount gave me no error....
>
> That's right. The 2.4 VFS removed the global restriction on the number
> of mounts on a single mountpoint. So?
>
> If people expect this to be an error, then the correct thing is for
> the VFS restriction to be reinstated. I see no reason why it should be
> the responsibility of the filesystem to check for this sort of
> thing. A mountpoint is after all the one place where the VFS is
> actually *designed* to override the filesystem.

I think it should be reinstated. We must have in mind, that currently, the 
most part of end-users are newbies, and if we want Linux to be a true Desktop 
Enviroment, we must allow people that do not want to understand it, to run it.

Just IMHO.

Regards,
Thiago Vinhas
