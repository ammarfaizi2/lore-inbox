Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282979AbRL0XFf>; Thu, 27 Dec 2001 18:05:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282998AbRL0XFZ>; Thu, 27 Dec 2001 18:05:25 -0500
Received: from Expansa.sns.it ([192.167.206.189]:56079 "EHLO Expansa.sns.it")
	by vger.kernel.org with ESMTP id <S282979AbRL0XFR>;
	Thu, 27 Dec 2001 18:05:17 -0500
Date: Fri, 28 Dec 2001 00:05:15 +0100 (CET)
From: Luigi Genoni <kernel@Expansa.sns.it>
To: Nikita Danilov <Nikita@Namesys.COM>
cc: <linux-kernel@vger.kernel.org>,
        Reiserfs mail-list <Reiserfs-List@Namesys.COM>
Subject: Re: reiserfs does not work with linux 2.4.17 on sparc64 CPUs
In-Reply-To: <15403.16930.233614.432899@laputa.namesys.com>
Message-ID: <Pine.LNX.4.33.0112280003390.26496-100000@Expansa.sns.it>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Will do this tomorrow in the afternoon, hopeing that nothing gets
corrupted...

Apart of this, on sparc64+2.4.16 reiserFS was rock solid (some warning
during compilation, about whom I already sended a report) also under
really eavy I/O.

Luigi


On Thu, 27 Dec 2001, Nikita Danilov wrote:

> Luigi Genoni writes:
>  > HI,
>  > I just upgraded to kernel 2.4.17 on a ultra2, sparc64, with 2 scsi disks.
>  >
>  > My system was on reiserfs,except for root partition, but the kernel 2.4.17
>  > is unable to mount reiserFS partitions.
>  > At boot i get an oops during the mount, but sincer I have no syslogd
>  > running I am not able to log it. Anyway the message talk about not been
>  > able to load a table map.
>
> Can you boot into single user, mount reiserfs partition manually and
> send decoded oops trace to the reiserfs list
> (Reiserfs-List@Namesys.COM)?
>
>  >
>  > gone back (sig!) to 2.4.16
>  >
>  > on x86 processors, instead, reiserfs semms to work as usual
>  >
>  > Luigi
>  >
>
> Nikita.
> --
> Harry Popper---bespectacled philosopher
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

