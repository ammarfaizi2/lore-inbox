Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262038AbSJIVJV>; Wed, 9 Oct 2002 17:09:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262111AbSJIVJV>; Wed, 9 Oct 2002 17:09:21 -0400
Received: from cibs9.sns.it ([192.167.206.29]:3599 "EHLO cibs9.sns.it")
	by vger.kernel.org with ESMTP id <S262038AbSJIVJU>;
	Wed, 9 Oct 2002 17:09:20 -0400
Date: Wed, 9 Oct 2002 23:14:42 +0200 (CEST)
From: venom@sns.it
To: alan@cotse.com
cc: phil-list@redhat.com, <linux-kernel@vger.kernel.org>
Subject: Re: Patches from Redhat gcc 3.2
In-Reply-To: <YWxhbg==.35e5d37d477d0ddc01cb3484f9ef3349@1034183288.cotse.net>
Message-ID: <Pine.LNX.4.43.0210092312570.16359-100000@cibs9.sns.it>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am using glibc 2.3 compiled with gcc 3.2, and no problems at all.
Just pay atention to your binutils version if you want prelinking.
Well, due to some changes in glibc I was unable to run binary statically
linked against glibc 2.2.X, so I had to recompile root bash...

bests

Luigi


On Wed, 9 Oct 2002, Alan Willis wrote:

> Date: Wed, 9 Oct 2002 13:08:08 -0400 (EDT)
> From: Alan Willis <alan@cotse.net>
> Reply-To: alan@cotse.com
> To: phil-list@redhat.com
> Cc: linux-kernel@vger.kernel.org
> Subject: Patches from Redhat gcc 3.2
>
>
>   Which of the 69 patches in the redhat gcc-3.2 rpm from RH8 provide the
> functionality needed for the __thread keyword, and anything else needed for
> nptl to work correctly.  Also, are any modifications needed to glibc 2.3?
> Also, I do not wish to make my system unusable with 2.4.x kernels,.. if I
> build glibc with --enable-kernel=current, will that make glibc unusable with
> 2.4.x kernels?  I've been using 2.5 for a while now,. but I do want a sane
> recourse.  Is this line also correct: --enable-addons=nptl,nptl_db, where
> I've untarred the nptl dirs under in the main glibc directory.
>
>    I'm trying to set up an environment where I can use nptl on gentoo.
>
> Any assistance is most welcome :o)
>
> Thanks in advance,
>
> -alan
>
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

