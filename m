Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265404AbRFVNXe>; Fri, 22 Jun 2001 09:23:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265405AbRFVNXO>; Fri, 22 Jun 2001 09:23:14 -0400
Received: from tonib-gw-old.customer.0rbitel.net ([195.24.39.218]:13065 "HELO
	mail.ludost.net") by vger.kernel.org with SMTP id <S265404AbRFVNXH>;
	Fri, 22 Jun 2001 09:23:07 -0400
Date: Fri, 22 Jun 2001 16:23:05 +0300 (EEST)
From: Vasil Kolev <lnxkrnl@mail.ludost.net>
X-X-Sender: <lnxkrnl@doom.bastun.net>
To: Nikita Danilov <NikitaDanilov@Yahoo.COM>
Cc: <reiserfs-list@namesys.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [reiserfs-list] Incompatibility between the reisrefs patches
 for 2.2.x and 2.4.x
In-Reply-To: <15155.17923.423044.21965@beta.namesys.com>
Message-ID: <Pine.LNX.4.33.0106221622060.24629-100000@doom.bastun.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Can I use the new format with 2.2? I don't have enough space to do that...
I would live with the limitations ... I just want it to work :)

On Fri, 22 Jun 2001, Nikita Danilov wrote:

> Vasil Kolev writes:
>  > Maybe this is a know issue, but nonetheless.....
>  > I have dual coppermine/930 machine with 1.2G ram, kernel 2.4.5. I used
>  > reiserfs for my  /home and /var partitions. When tried downgrading to
>  > 2.2.19, I got errors  in syslog like 'can't find superblock' ... ( I don't
>  > have them, /var wasn't mounted, and i had to return the machine in
>  > production state... ). Does someone has any idea about this, how could I
>  > downgrade to 2.2.19 ?
>
> 2.4 kernels can work with both 3.5 reiserfs disk format (old) and 3.6
> (new). 2.2 kernels---only with 3.5. Probably, you have created your
> file-systems in the new format.
>
> You can boot 2.4 kernel, create new file-system large enough with
> /sbin/mkreiserfs -v1 (old format), copy existing files there by tar or
> cpio and then update /etc/fstab to mount file-system just created. Now,
> you can work both with 2.2 and 2.4 kernels.
>
> Keep in mind, that 3.5 format has some limitations concerning file size
> etc. Check faq at namesys.com for details. On the other hand, 3.5 often
> considered more stable.
>
> Nikita.
>

