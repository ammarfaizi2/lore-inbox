Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279976AbRJ3Pnn>; Tue, 30 Oct 2001 10:43:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279989AbRJ3Pne>; Tue, 30 Oct 2001 10:43:34 -0500
Received: from longsword.omniti.com ([216.0.51.134]:38666 "EHLO
	longsword.omniti.com") by vger.kernel.org with ESMTP
	id <S279985AbRJ3PnW>; Tue, 30 Oct 2001 10:43:22 -0500
Message-ID: <3BDECBDD.DEE796EE@omniti.com>
Date: Tue, 30 Oct 2001 10:48:45 -0500
From: Robert Scussel <rscuss@omniti.com>
Reply-To: rscuss@omniti.com
Organization: OmniTI, Inc.
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.2.17 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Pablo Ninja <pablo.ninja@uol.com.br>
CC: linux-kernel@vger.kernel.org
Subject: Re: linux-2.4.13 high SWAP
In-Reply-To: <3BDE3174.7718D64B@omniti.com> <20011030082806.14e60268.pablo.ninja@uol.com.br>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pablo Ninja wrote:
> 
> Hi Robert,
> 
> I'm just a regular user of sgi xfs on my desktop and I noted It eats up all memory (maybe cos it caches too much). Don't know if it matters but have you ever tried to umount/mount these partitions ?
>

Yes, I have tried to unmount the partition, however, it is impossible
once the machine gets into this state. 

One thing that I have noticed is that when the load starts to increase,
a manual sync, although it takes a long time, appears to keep off an
immediate hang of the system. Once the load gets above 25 however, the
machines spiral out of control.

Robert


> []'s
> Pablo
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
Robert Scussel
1024D/BAF70959/0036 B19E 86CE 181D 0912  5FCC 92D8 1EA1 BAF7 0959
