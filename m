Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316225AbSEVQD1>; Wed, 22 May 2002 12:03:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316228AbSEVQD0>; Wed, 22 May 2002 12:03:26 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:43023 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S316225AbSEVQDY>; Wed, 22 May 2002 12:03:24 -0400
Date: Wed, 22 May 2002 09:02:51 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Russell King <rmk@arm.linux.org.uk>
cc: Martin Dalecki <dalecki@evision-ventures.com>, <jack@suse.cz>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux-2.5.17
In-Reply-To: <20020522131441.C16934@flint.arm.linux.org.uk>
Message-ID: <Pine.LNX.4.44.0205220901430.7580-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 22 May 2002, Russell King wrote:
>
> /proc/sys has a clean and clear purpose.

Yes, but it _:would_ be good to make the quota stuff use the existign
helper functions to make it much cleaner.

And some of those helper functions are definitely from sysctl's: splitting
up the quota file into multiple sysctls (_and_ moving it to /proc/sys/fs)
sounds like a good idea to me.

		Linus

