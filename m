Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316422AbSFJVwk>; Mon, 10 Jun 2002 17:52:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316423AbSFJVwj>; Mon, 10 Jun 2002 17:52:39 -0400
Received: from 213-152-55-49.dsl.eclipse.net.uk ([213.152.55.49]:33179 "EHLO
	monkey.daikokuya.demon.co.uk") by vger.kernel.org with ESMTP
	id <S316422AbSFJVwi>; Mon, 10 Jun 2002 17:52:38 -0400
Date: Mon, 10 Jun 2002 22:51:16 +0100
To: "Maksim (Max) Krasnyanskiy" <maxk@qualcomm.com>
Cc: Martin Dalecki <dalecki@evision-ventures.com>,
        Linus Torvalds <torvalds@transmeta.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.5.21 kill warnings 4/19
Message-ID: <20020610215116.GA13380@daikokuya.demon.co.uk>
In-Reply-To: <Pine.LNX.4.33.0206082235240.4635-100000@penguin.transmeta.com> <5.1.0.14.2.20020610114308.09306358@mail1.qualcomm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
From: Neil Booth <neil@daikokuya.demon.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Maksim (Max) Krasnyanskiy wrote:-

> Hi Martin,
> 
> How about replacing __FUNCTION__ with __func__ ?
> GCC 3.x warns that __FUNCTION__ is obsolete and will be removed.

No, it doesn't, it warns that string concatenation with __FUNCTION__
is deprecated and will be removed (I wrote the code).

__FUNCTION__ itself will stay forever.

Neil.
