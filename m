Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281691AbRLFRxX>; Thu, 6 Dec 2001 12:53:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281717AbRLFRxO>; Thu, 6 Dec 2001 12:53:14 -0500
Received: from perninha.conectiva.com.br ([200.250.58.156]:12552 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S281691AbRLFRxB> convert rfc822-to-8bit; Thu, 6 Dec 2001 12:53:01 -0500
Date: Thu, 6 Dec 2001 14:36:18 -0200 (BRST)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
To: =?ISO-8859-1?Q?Ren=E9_Scharfe?= <l.s.r@web.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Michael H.Warfield" <mhw@commandcorp.com>,
        "David S. Miller" <davem@redhat.com>
Subject: Re: 2.4.17-pre2: unclean cleanup in i2ellis.c
In-Reply-To: <20011206185406.7873518d.l.s.r@web.de>
Message-ID: <Pine.LNX.4.21.0112061435580.21480-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Could you please send me a patch to undo that change ? 

Thanks

On Thu, 6 Dec 2001, René Scharfe wrote:

> Hi,
> 
> in 2.4.17-pre2 the definition of iiEllisCleanup() in
> drivers/char/i2ellis.c got #if 0'd because it's unused. Problem is,
> drivers/char/ip2main.c still calls this function in line 559.
> 
> René
> 

