Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262784AbSJJB3T>; Wed, 9 Oct 2002 21:29:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262799AbSJJB3T>; Wed, 9 Oct 2002 21:29:19 -0400
Received: from members.cotse.com ([216.112.42.58]:2472 "EHLO cotse.com")
	by vger.kernel.org with ESMTP id <S262784AbSJJB3Q>;
	Wed, 9 Oct 2002 21:29:16 -0400
Message-ID: <YWxhbg==.0fe94bb5b241e24ad12bab0586a50d3e@1034213801.cotse.net>
Date: Wed, 9 Oct 2002 21:36:41 -0400 (EDT)
X-Abuse-To: abuse@cotse.com
X-AntiForge: http://packetderm.cotse.com/antiforge.php
Subject: Re: Patches from Redhat gcc 3.2
From: "Alan Willis" <alan@cotse.net>
To: <roland@redhat.com>
In-Reply-To: <200210100109.g9A19FL11530@magilla.sf.frob.com>
References: <200210100109.g9A19FL11530@magilla.sf.frob.com>
Cc: <linux-kernel@vger.kernel.org>, <phil-list@redhat.com>
Reply-To: alan@cotse.com
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> Also, are any modifications needed to glibc 2.3?
>
> Nope, but you are always best off using the CVS head for glibc during
> the experimental period of NPTL.
>

Cool, I think I'll wait for 2.3.1.

>> Also, I do not wish to make my system unusable with 2.4.x kernels,..
>> if I build glibc with --enable-kernel=current, will that make glibc
>> unusable with 2.4.x kernels?
>
> Use --enable-kernel=2.4.x for whatever earliest 2.4.x you want to work
> with.
>

I suspected as much but I wanted to be sure.

>> I've been using 2.5 for a while now,. but I do want a sane recourse.
>> Is this line also correct: --enable-addons=nptl,nptl_db, where I've
>> untarred the nptl dirs under in the main glibc directory.
>
> Just --enable-add-ons=nptl

Thank you Roland.  I will probably end up installing RH8 anyway, for the
patches to gcc.  Do binutils need to be rebuilt / linked against glibc?
I doubt it, but I figure it's better to just ask.

-alan


