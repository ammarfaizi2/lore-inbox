Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315267AbSEaNWI>; Fri, 31 May 2002 09:22:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315275AbSEaNWH>; Fri, 31 May 2002 09:22:07 -0400
Received: from chaos.analogic.com ([204.178.40.224]:4736 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S315267AbSEaNWG>; Fri, 31 May 2002 09:22:06 -0400
Date: Fri, 31 May 2002 09:22:07 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Andrey Panin <pazke@orbita1.ru>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] FAT fs printk() cleanup
In-Reply-To: <20020531131454.GC310@pazke.ipt>
Message-ID: <Pine.LNX.3.95.1020531091429.256A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 31 May 2002, Andrey Panin wrote:

> On Fri, May 31, 2002 at 08:59:08AM -0400, Richard B. Johnson wrote:
> > 
> > I think it needs to go only to the console....
> > 
> > File-system error...
> >    printk(...to the file system)
> >       makes a file-system error...
> >           <forever>
> 
> Do you have /var/log on FAT partition or on the floppy ?
> Yes, I know about umsdos, but show me one who *really* use it.
> 

Yes, that's what caught my attention. Also floppies are the most
likely drives to produce errors. You might need a bit less "perfection"
in your rule-making to accommodate real-world problems. Many servers
have the root file-system mounted r/o with writable "throw-aways" mounted
on the usual mount-points like /tmp and /var.



Cheers,
Dick Johnson

Penguin : Linux version 2.4.18 on an i686 machine (797.90 BogoMips).

                 Windows-2000/Professional isn't.

