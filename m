Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267372AbTA3Boz>; Wed, 29 Jan 2003 20:44:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267306AbTA3Boz>; Wed, 29 Jan 2003 20:44:55 -0500
Received: from shadow.bentonrea.com ([216.7.40.39]:14085 "EHLO
	shadow.bentonrea.com") by vger.kernel.org with ESMTP
	id <S267372AbTA3Box>; Wed, 29 Jan 2003 20:44:53 -0500
Message-ID: <001401c2c802$f266ac20$0101a8c0@localdomain>
From: "Enlight" <enlight@bentonrea.com>
To: "Catalin BOIE" <util@ns2.deuroconsult.ro>,
       "Alan Cox" <alan@lxorguk.ukuu.org.uk>
Cc: "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.33.0301281419510.10512-100000@hosting.rdsbv.ro>
Subject: Re: Problem - See attached dmesg dump
Date: Wed, 29 Jan 2003 17:57:28 -0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2720.3000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I did test memory and found no problems.

I regressed to kernel-2.4.8 and gcc-2.96 and was able to successfully build
XFCE without a glitch.

I now plan to progress to kernel-2.4.19, which I have, and attempt build
with gcc-2.96.  If that works or fails I will progress to kernel-2.4.20.
After that I will bump gcc up and see what happens.  I suspect gcc really
works the system with recursive system calls and memory paging.

I tried ksymoops and it ran soooooo sloooooow.  I am not sure I have it
right and I was not able to get results.  I just need to study more I guess.
I don't do this for a living so I beg your forgiveness and appreciate the
input and patience from everybody.

Jerry DeLisle (enlight)

----- Original Message -----
From: "Catalin BOIE" <util@ns2.deuroconsult.ro>
To: "Alan Cox" <alan@lxorguk.ukuu.org.uk>
Cc: "Enlight" <enlight@bentonrea.com>; "Linux Kernel Mailing List"
<linux-kernel@vger.kernel.org>
Sent: Tuesday, January 28, 2003 4:21 AM
Subject: Re: Problem - See attached dmesg dump


> > > While running make to build xfce3.8.18 I get an internal gcc error
> > > segmentation fault.  Also got similar error running rpmdrake.
Needless to
> > > say I can't finish the build.
>
> I get this error too. gcc 3.2.1 seg faults a lot when compiling a kernel.
> Motherboard: gigabyte 7avx (I think) K400.
> Under Windows 2000 (don't ask why, please...) no BSOD.
>
> >
> > Send reports about vendor kernels to the vendor concerned. Vendors add
various
> > custom changes to the base kernel, they also know a lot more about the
patterns
> > of problems their users see
> >
> > -
> > To unsubscribe from this list: send the line "unsubscribe linux-kernel"
in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > Please read the FAQ at  http://www.tux.org/lkml/
> >
>
> ---
> Catalin(ux) BOIE
> catab@deuroconsult.ro
>
>

