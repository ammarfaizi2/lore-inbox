Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315760AbSFJS5s>; Mon, 10 Jun 2002 14:57:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315779AbSFJS5s>; Mon, 10 Jun 2002 14:57:48 -0400
Received: from loewe.cosy.sbg.ac.at ([141.201.2.12]:3007 "EHLO
	loewe.cosy.sbg.ac.at") by vger.kernel.org with ESMTP
	id <S315760AbSFJS5q>; Mon, 10 Jun 2002 14:57:46 -0400
Date: Mon, 10 Jun 2002 20:57:02 +0200 (MET DST)
From: "Thomas 'Dent' Mirlacher" <dent@cosy.sbg.ac.at>
To: "Maksim (Max) Krasnyanskiy" <maxk@qualcomm.com>
cc: Martin Dalecki <dalecki@evision-ventures.com>,
        Linus Torvalds <torvalds@transmeta.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.5.21 kill warnings 4/19
In-Reply-To: <5.1.0.14.2.20020610114308.09306358@mail1.qualcomm.com>
Message-ID: <Pine.GSO.4.05.10206102055280.17299-100000@mausmaki.cosy.sbg.ac.at>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 10 Jun 2002, Maksim (Max) Krasnyanskiy wrote:

> Hi Martin,
> 
> How about replacing __FUNCTION__ with __func__ ?
> GCC 3.x warns that __FUNCTION__ is obsolete and will be removed.

is __func__ already supported for gcc 2.96?

and what about C99 style named initializers for structs?

struct blah = {
	.open = driver_open
};

	tm

-- 
in some way i do, and in some way i don't.

