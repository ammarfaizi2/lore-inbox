Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267650AbRHDTyW>; Sat, 4 Aug 2001 15:54:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267670AbRHDTyN>; Sat, 4 Aug 2001 15:54:13 -0400
Received: from garrincha.netbank.com.br ([200.203.199.88]:18960 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S267650AbRHDTyC>;
	Sat, 4 Aug 2001 15:54:02 -0400
Date: Sat, 4 Aug 2001 16:53:42 -0300 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@imladris.rielhome.conectiva>
To: Chris Wedgwood <cw@f00f.org>
Cc: Ivan Kalvatchev <iive@yahoo.com>, <linux-kernel@vger.kernel.org>
Subject: Re: DoS with tmpfs #3
In-Reply-To: <20010805063657.C20164@weta.f00f.org>
Message-ID: <Pine.LNX.4.33L.0108041652340.2526-100000@imladris.rielhome.conectiva>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 5 Aug 2001, Chris Wedgwood wrote:
> On Sat, Aug 04, 2001 at 03:07:31AM -0300, Rik van Riel wrote:
>
>     1) you create a tmpfs with a high limit, such that
>        (max size tmpfs) + (user memory) > ram + swap
>
> maybe, by default, tmpfs should choose a limit of 1/2 ram available or
> something?  if this is too small, people can change it

I guess this would be a decent default; good enough to
keep most people out of trouble and big enough to be
useful.

regards,

Rik
--
Virtual memory is like a game you can't win;
However, without VM there's truly nothing to lose...

http://www.surriel.com/		http://distro.conectiva.com/

Send all your spam to aardvark@nl.linux.org (spam digging piggy)

