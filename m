Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281640AbRKUHG6>; Wed, 21 Nov 2001 02:06:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281641AbRKUHGs>; Wed, 21 Nov 2001 02:06:48 -0500
Received: from vger.timpanogas.org ([207.109.151.240]:21888 "EHLO
	vger.timpanogas.org") by vger.kernel.org with ESMTP
	id <S281640AbRKUHGc>; Wed, 21 Nov 2001 02:06:32 -0500
Message-ID: <004301c1725a$ec5f3490$f5976dcf@nwfs>
From: "Jeff Merkey" <jmerkey@timpanogas.org>
To: "Chris Abbey" <linux@cabbey.net>,
        "Jeff V. Merkey" <jmerkey@vger.timpanogas.org>
Cc: <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.33.0111210046440.3730-100000@tweedle.cabbey.net>
Subject: Re: [VM/MEMORY-SICKNESS] 2.4.15-pre7 kmem_cache_create invalid opcode
Date: Wed, 21 Nov 2001 00:05:38 -0700
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


This happens as well with the SCI drivers, which are not dependant on any
patches.

Jeff

----- Original Message -----
From: "Chris Abbey" <linux@cabbey.net>
To: "Jeff V. Merkey" <jmerkey@vger.timpanogas.org>
Cc: <linux-kernel@vger.kernel.org>
Sent: Tuesday, November 20, 2001 11:54 PM
Subject: Re: [VM/MEMORY-SICKNESS] 2.4.15-pre7 kmem_cache_create invalid
opcode


> Today, Jeff V. Merkey wrote:
> > [...] I went back
> > over how I did the build, and this is the result of the build
> > if you have unpacked, patched, then run "make oldconfig."  If I
> > do a "make dep" then this problem does not occur, [....]
>
> umm... lemme see if I understand you correctly, you patched the
> kernel and soemthing breaks if you don't run make dep after
> patching? Unless you can prove 100% that nothing in that
> patch affects the dependency structure of the code, nor any of
> the other things that are generated during the make dep stage,
> then what we have here is user error. The directions say, quite
> clearly, make oldconfig, make dep, make vmlinux, etc. Unless my
> memory is totally shot tonight the last thing make oldconfig
> spits out is in fact the direction to run make dep.
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

