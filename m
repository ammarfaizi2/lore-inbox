Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281066AbRKTN7e>; Tue, 20 Nov 2001 08:59:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281067AbRKTN7Z>; Tue, 20 Nov 2001 08:59:25 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:10857 "EHLO
	frodo.biederman.org") by vger.kernel.org with ESMTP
	id <S281066AbRKTN7R>; Tue, 20 Nov 2001 08:59:17 -0500
To: RaXl NXXez de Arenas Coronado <dervishd@jazzfree.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: LOBOS (kexec)
In-Reply-To: <E1669v2-0000Cv-00@DervishD>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 20 Nov 2001 06:40:19 -0700
In-Reply-To: <E1669v2-0000Cv-00@DervishD>
Message-ID: <m1bshx5zng.fsf@frodo.biederman.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

RaXl NXXez de Arenas Coronado <dervishd@jazzfree.com> writes:

>     Hello Larry (or Eric) :)
> 
> >> I've been wanting Linux which can boot Linux for a long time.
> >I am maintaining a version of this functionality against 2.4.x
> >called kexec.  And I plan to work on integration into linux with 2.5.x.
> >After the details are worked out I will look at a backport to 2.4.x
> 
>     I think that this is a very important point, since will ease the
> making of installation disks, etc... Moreover, it will ease the
> creation of 'live' linux systems that can do a pretty work detecting
> the hardware and the like.

Yep it allows linux to sever a lot of very interesting roles.  Linux
doesn't act especially well as firmware (it is fairly big).  But otherwise
it does a good job.
 
> >The hard part is not linux booting linux but the passing of the
> >firmware/BIOS tables from one kernel to the next.
> 
>     Why?. I mean, I haven't read on this issue in the LOBOS project.
> I'm afraid I thought that this was easier than it really is...

The difficulty isn't in implementation but in freezing the API.  Which
is needed if you want a solid long term approach.

> 
> >I am doing this a part of the linuxBIOS effort and as such it is just
> 
>     I want to take a look at LinuxBIOS.

The documentation is sketchy but you can look at:
http://www.linuxbios.org  and ask questions on the mailing list.

Eric
