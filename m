Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269809AbRHDGHs>; Sat, 4 Aug 2001 02:07:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269810AbRHDGHh>; Sat, 4 Aug 2001 02:07:37 -0400
Received: from garrincha.netbank.com.br ([200.203.199.88]:7173 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S269809AbRHDGH2>;
	Sat, 4 Aug 2001 02:07:28 -0400
Date: Sat, 4 Aug 2001 03:07:31 -0300 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@imladris.rielhome.conectiva>
To: Ivan Kalvatchev <iive@yahoo.com>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: DoS with tmpfs #3
In-Reply-To: <20010803163409.62191.qmail@web13609.mail.yahoo.com>
Message-ID: <Pine.LNX.4.33L.0108040303030.2526-100000@imladris.rielhome.conectiva>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 3 Aug 2001, Ivan Kalvatchev wrote:

> I don't like stuped jokes.

> Oh maybe you have used to work in microsoft and this
> is not a bug but a feature :-{

I don't like insults.  Or people who don't read what
I write but complain about it anyway.

I'll explain things once more. Slowly.

1) you create a tmpfs with a high limit, such that
   (max size tmpfs) + (user memory) > ram + swap

2) you proceed to completely fill up ram and swap

3) now ram and swap is full and the computer has no
   place to put new data

Apart from adding swap space on the fly or going to the
shop to buy you more memory (neither of which is implemented
in the current kernel) there is very little the kernel can
do.

As long as you don't try to use more resources than you
have you will be ok.

regards,

Rik
--
Virtual memory is like a game you can't win;
However, without VM there's truly nothing to lose...

http://www.surriel.com/		http://distro.conectiva.com/

Send all your spam to aardvark@nl.linux.org (spam digging piggy)

