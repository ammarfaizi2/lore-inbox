Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277068AbRJ3N1s>; Tue, 30 Oct 2001 08:27:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278447AbRJ3N1j>; Tue, 30 Oct 2001 08:27:39 -0500
Received: from mailout03.sul.t-online.com ([194.25.134.81]:63153 "EHLO
	mailout03.sul.t-online.de") by vger.kernel.org with ESMTP
	id <S277068AbRJ3N1b>; Tue, 30 Oct 2001 08:27:31 -0500
Date: Tue, 30 Oct 2001 14:29:34 +0100
From: Ulrich Wiederhold <U.Wiederhold@gmx.net>
To: linux-kernel@vger.kernel.org
Subject: Re: linux-2.4.13 high SWAP
Message-ID: <20011030142934.C3406@sky.net>
In-Reply-To: <3BDE3174.7718D64B@omniti.com> <20011030082806.14e60268.pablo.ninja@uol.com.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20011030082806.14e60268.pablo.ninja@uol.com.br>
User-Agent: Mutt/1.3.23i
Organization: Using Linux Only
X-Operating-System: Debian GNU/Linux testing/unstable (Kernel 2.4.13-xfs)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
* Pablo Ninja <pablo.ninja@uol.com.br> [011030 11:28]:
> I'm just a regular user of sgi xfs on my desktop and I noted It eats up all memory (maybe cos it caches too much). Don't know if it matters but have you ever tried to umount/mount these partitions ?
> 
No problems here with sgi xfs on a lvm-volume and 2.4.13, 192MB RAM,
K6-2/400.

Uli

> 
> On Mon, 29 Oct 2001 23:49:56 -0500
> Robert Scussel <rscuss@omniti.com> wrote:
> 
> > Just thought that I would add our experience.
> > 
> > We have experienced the same kind of swap symptoms described, however we
> > have no mounted tmpfs, or ramfs partitions. We have, in fact,
> > experienced the same symptoms on the 2.4.2,2.4.5,2.4.7 and 2.4.12
> > kernel, haven't yet tried the 2.4.13 kernel.  The symptoms include hung
> > processes which can not be killed, system cannot right to disk, and
> > files accessed during this time are filled with binary zeros.  As sync
> > does not work as well, the only resolution is to do a reboot -f -n.
> > 
> > All systems are comprised of exclusively SGI XFS partitions, with dual
> > pentium II/III processors.
> > 
> > Any insight would be helpful,
> > 
> > Robert Scussel
> > --
> > Robert Scussel
> > 1024D/BAF70959/0036 B19E 86CE 181D 0912  5FCC 92D8 1EA1 BAF7 0959
> > -
> > To unsubscribe from this list: send the line "unsubscribe linux-kernel"
> > in the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > Please read the FAQ at  http://www.tux.org/lkml/
> > 
> 
> 
> 
> =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
> Pablo Borges                                pablo.borges@uol.com.br
> -------------------------------------------------------------------
>   ____                                               Tecnologia UOL
>  /    \    Debian:
>  |  =_/      The 100% suck free linux distro.
>   \
>     \      SETI is lame. http://www.distributed.net
>                                                      Dnetc is XNUG!
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
-- 
'The box said, 'Requires Windows 95 or better', so i installed Linux - TKK 5
