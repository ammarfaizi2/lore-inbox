Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262831AbRE3WI7>; Wed, 30 May 2001 18:08:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262852AbRE3WIj>; Wed, 30 May 2001 18:08:39 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:30471 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S262848AbRE3WIg>; Wed, 30 May 2001 18:08:36 -0400
Date: Wed, 30 May 2001 17:32:19 -0300 (BRT)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
To: lkml <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@transmeta.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] reclaim dirty dead swapcache pages 
In-Reply-To: <Pine.LNX.4.21.0105301420000.5231-100000@freak.distro.conectiva>
Message-ID: <Pine.LNX.4.21.0105301729080.5231-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 30 May 2001, Marcelo Tosatti wrote:

> 
> Hi, 
> 
> The following untested patch against 2.4.5-ac2 makes page_launder() free
> dead swap cache pages by ignoring their age and/or referenced bits.

I tested it and yes, it works. 

However I want more results before trying to push this to Alan. 

Its at
http://bazar.conectiva.com.br/~marcelo/patches/v2.4/2.4.5ac4/reapswap.patch

Please test. 

