Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316060AbSEJQbb>; Fri, 10 May 2002 12:31:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316061AbSEJQba>; Fri, 10 May 2002 12:31:30 -0400
Received: from ahriman.Bucharest.roedu.net ([141.85.128.71]:14807 "HELO
	ahriman.bucharest.roedu.net") by vger.kernel.org with SMTP
	id <S316060AbSEJQb3>; Fri, 10 May 2002 12:31:29 -0400
Date: Fri, 10 May 2002 19:40:47 +0300 (EEST)
From: Mihai RUSU <dizzy@roedu.net>
X-X-Sender: <dizzy@ahriman.bucharest.roedu.net>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: mmap, SIGBUS, and handling it
In-Reply-To: <E176DEd-0006CC-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.33.0205101940200.9661-100000@ahriman.bucharest.roedu.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello again,

Thanks for all the answers and help.

On Fri, 10 May 2002, Alan Cox wrote:

> > truncates the file which was mmap-ed , our program will receive a SIGBUS
> > in write().
> >
> > If I understand right this is more POSIX compliant.
> >
> > Is there a clean/good way of handling this ?
>
> sigsetjmp/siglongjmp
>
>

----------------------------
Mihai RUSU

Disclaimer: Any views or opinions presented within this e-mail are solely
those of the author and do not necessarily represent those of any company,
unless otherwise specifically stated.

