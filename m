Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129057AbQKHAQ5>; Tue, 7 Nov 2000 19:16:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129116AbQKHAQq>; Tue, 7 Nov 2000 19:16:46 -0500
Received: from vger.timpanogas.org ([207.109.151.240]:33543 "EHLO
	vger.timpanogas.org") by vger.kernel.org with ESMTP
	id <S129057AbQKHAQl>; Tue, 7 Nov 2000 19:16:41 -0500
Message-ID: <3A089A75.96C5F74@timpanogas.org>
Date: Tue, 07 Nov 2000 17:12:37 -0700
From: "Jeff V. Merkey" <jmerkey@timpanogas.org>
Organization: TRG, Inc.
X-Mailer: Mozilla 4.7 [en] (WinNT; I)
X-Accept-Language: en
MIME-Version: 1.0
To: Jeff Garzik <jgarzik@mandrakesoft.com>
CC: kernel@kvack.org, Tigran Aivazian <tigran@veritas.com>,
        linux-kernel@vger.kernel.org, hpa@transmeta.com
Subject: Re: Installing kernel 2.4
In-Reply-To: <Pine.LNX.3.96.1001107175009.1482C-100000@kanga.kvack.org> <3A088C02.4528F66B@timpanogas.org> <3A0896F3.AB36C3EE@mandrakesoft.com> <3A0897F5.563552AD@timpanogas.org> <3A089A01.ECAEABBD@mandrakesoft.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Jeff Garzik wrote:
> 
> "Jeff V. Merkey" wrote:
> > We need a format that allow multiple executable segments to be combined
> > in a single executable and the loader have enough smarts to grab the
> > right one based on architecture.  two options:
> >
> > 1.  extend gcc to support this or rearragne linux into segments based on
> > code type
> > 2.  Use PE.
> 
> The kernel isn't going non-ELF.  Too painful, for dubious advantages,
> namely:
> 

perhaps we should extend ELF.  After all, where linux goes, gcc
follows....

Jeff

> The current gcc toolchain already supports what you suggest.
> 
> I understand that some people have even put some thought into a
> bootloader that dynamically links your kernel on bootup, so this idea
> isn't new.  It's a good idea though.
> 
>         Jeff
> 
> --
> Jeff Garzik             | "When I do this, my computer freezes."
> Building 1024           |          -user
> MandrakeSoft            | "Don't do that."
>                         |          -level 1
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
