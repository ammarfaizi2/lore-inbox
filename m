Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279743AbRJ3Kad>; Tue, 30 Oct 2001 05:30:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279745AbRJ3KaY>; Tue, 30 Oct 2001 05:30:24 -0500
Received: from toole.uol.com.br ([200.231.206.186]:35310 "EHLO
	toole.uol.com.br") by vger.kernel.org with ESMTP id <S279743AbRJ3KaJ>;
	Tue, 30 Oct 2001 05:30:09 -0500
Date: Tue, 30 Oct 2001 08:28:06 -0200
From: Pablo Ninja <pablo.ninja@uol.com.br>
To: Robert Scussel <rscuss@omniti.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: linux-2.4.13 high SWAP
Message-Id: <20011030082806.14e60268.pablo.ninja@uol.com.br>
In-Reply-To: <3BDE3174.7718D64B@omniti.com>
In-Reply-To: <3BDE3174.7718D64B@omniti.com>
X-Mailer: Sylpheed version 0.6.3claws18 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Robert,

I'm just a regular user of sgi xfs on my desktop and I noted It eats up all memory (maybe cos it caches too much). Don't know if it matters but have you ever tried to umount/mount these partitions ?

[]'s
Pablo

On Mon, 29 Oct 2001 23:49:56 -0500
Robert Scussel <rscuss@omniti.com> wrote:

> Just thought that I would add our experience.
> 
> We have experienced the same kind of swap symptoms described, however we
> have no mounted tmpfs, or ramfs partitions. We have, in fact,
> experienced the same symptoms on the 2.4.2,2.4.5,2.4.7 and 2.4.12
> kernel, haven't yet tried the 2.4.13 kernel.  The symptoms include hung
> processes which can not be killed, system cannot right to disk, and
> files accessed during this time are filled with binary zeros.  As sync
> does not work as well, the only resolution is to do a reboot -f -n.
> 
> All systems are comprised of exclusively SGI XFS partitions, with dual
> pentium II/III processors.
> 
> Any insight would be helpful,
> 
> Robert Scussel
> --
> Robert Scussel
> 1024D/BAF70959/0036 B19E 86CE 181D 0912  5FCC 92D8 1EA1 BAF7 0959
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel"
> in the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 



=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
Pablo Borges                                pablo.borges@uol.com.br
-------------------------------------------------------------------
  ____                                               Tecnologia UOL
 /    \    Debian:
 |  =_/      The 100% suck free linux distro.
  \
    \      SETI is lame. http://www.distributed.net
                                                     Dnetc is XNUG!

