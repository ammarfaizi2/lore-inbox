Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316155AbSEJWki>; Fri, 10 May 2002 18:40:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316154AbSEJWkh>; Fri, 10 May 2002 18:40:37 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:2565 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S316155AbSEJWkf>; Fri, 10 May 2002 18:40:35 -0400
Date: Fri, 10 May 2002 15:40:15 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: george anzinger <george@mvista.com>
cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: 64-bit jiffies, a better solution
In-Reply-To: <3CDC4B5C.C3DB2533@mvista.com>
Message-ID: <Pine.LNX.4.33.0205101538400.25826-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 10 May 2002, george anzinger wrote:
>
> If that were only true.  The problem is that some architectures can be
> built with either endian.  Mips, for example, seems to take the endian
> stuff in as an environment variable.  The linker seems to know this
> stuff, but does not provide the "built in" to allow it to be used.

Ignore those for now, and let the architecture maintainer sort it out. 
>From what I can tell, those architectures do things like generate the 
linker script dynamically anyway, so..

		Linus

