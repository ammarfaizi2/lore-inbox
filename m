Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289542AbSAOTL1>; Tue, 15 Jan 2002 14:11:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289599AbSAOTLS>; Tue, 15 Jan 2002 14:11:18 -0500
Received: from 64-30-107-48.ftth.sac.winfirst.net ([64.30.107.48]:34054 "EHLO
	leng.internal") by vger.kernel.org with ESMTP id <S289542AbSAOTLB>;
	Tue, 15 Jan 2002 14:11:01 -0500
Message-ID: <0b8801c19df9$0784dd50$7e93a8c0@sac.unify.com>
From: "Manuel McLure" <manuel@mclure.org>
To: <root@chaos.analogic.com>, "Marco Colombo" <marco@esi.it>
Cc: "Thomas Duffy" <Thomas.Duffy.99@alumni.brown.edu>,
        "Linux Mailing List" <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.3.95.1020115133220.818B-100000@chaos.analogic.com>
Subject: Re: Aunt Tillie builds a kernel (was Re: ISA hardware discovery -- the elegant solution)
Date: Tue, 15 Jan 2002 11:15:43 -0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Red Hat provides a source RPM for their kernel - install the source RPM and
use rpm to build it. If you want to figure out what order the patches were
applied in, just look at the RPM spec file. I myself have applied patches to
a Red Hat kernel RPM in this fashion.

--
Manuel A. McLure KE6TAW | ...for in Ulthar, according to an ancient
<manuel@mclure.org>     | and significant law, no man may kill a cat.
<http://www.mclure.org> |             -- H.P. Lovecraft


----- Original Message -----
From: "Richard B. Johnson" <root@chaos.analogic.com>
To: "Marco Colombo" <marco@esi.it>
Cc: "Thomas Duffy" <Thomas.Duffy.99@alumni.brown.edu>; "Linux Mailing List"
<linux-kernel@vger.kernel.org>
Sent: Tuesday, January 15, 2002 10:52 AM
Subject: Re: Aunt Tillie builds a kernel (was Re: ISA hardware discovery --
the elegant solution)


> On Tue, 15 Jan 2002, Marco Colombo wrote:
>
> > On 15 Jan 2002, Thomas Duffy wrote:
> >
> > > On Tue, 2002-01-15 at 04:29, Andrew Pimlott wrote:
> > >
> > > > - Building from source is good karma.
>
> [SNIPPED...]
>
> >
> > Every distro supplies a package with the source used to build their own
> > kernel. Just recomplile it.
>
> Really???  Have you ever tried this? RedHat provides a directory
> of random patches that won't patch regardless of the order in
> which you attempt patches (based upon date-stamps on patches or
> date-stamps on files). It's like somebody just copied in some
> junk, thinking nobody would ever bother.
>
> Some distributions don't even provide source. They provide
> copies of /usr/src/linux/include/asm and /usr/src/linux/include/linux
> but nothing else. You have to "find" source on the internet.
>
> Some distributions don't even provide that, instead they provide
> copies of /usr/src/linux/include/linux and /usr/src/linux/include/asm
> under /usr/include.
>
> The "good-ol-days" where you could get 72 floppies from Yggdrasil,
> install Linux, and spend the next 48 hours watching it compile
> are long gone.
>
> I have never found a distribution that uses modules, in which is
> was even remotely possible to duplicate the kernel supplied.
>
> Cheers,
> Dick Johnson
>
> Penguin : Linux version 2.4.1 on an i686 machine (797.90 BogoMips).
>
>     I was going to compile a list of innovations that could be
>     attributed to Microsoft. Once I realized that Ctrl-Alt-Del
>     was handled in the BIOS, I found that there aren't any.
>
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
>

