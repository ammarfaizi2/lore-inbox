Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317887AbSHHSmO>; Thu, 8 Aug 2002 14:42:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317874AbSHHSlY>; Thu, 8 Aug 2002 14:41:24 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:53258 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S317872AbSHHSkd>; Thu, 8 Aug 2002 14:40:33 -0400
Date: Thu, 8 Aug 2002 15:44:06 -0300 (BRT)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: riel@duckman.distro.conectiva
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>,
       Andrew Morton <akpm@zip.com.au>, Anton Blanchard <anton@samba.org>,
       William Lee Irwin III <wli@holomorphy.com>,
       <linux-kernel@vger.kernel.org>, <riel@imladris.surriel.com>
Subject: Re: fix CONFIG_HIGHPTE
In-Reply-To: <1028836757.28883.73.camel@irongate.swansea.linux.org.uk>
Message-ID: <Pine.LNX.4.44L.0208081541560.2589-100000@duckman.distro.conectiva>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 8 Aug 2002, Alan Cox wrote:
> On Thu, 2002-08-08 at 15:51, Rik van Riel wrote:
> > Linux isn't yet up to having 500 simultaneous interactive
> > users, in fact I don't think it has ever been up to this
> > situation.
>
> It works suprisingly well. I know people who are doing it. It does not
> work when those users are all running arbitarly large jobs. In most
> conventional (non student compile) type setups 500 is fine. The O(1)
> scheduler and highio are pretty essential as is a real I/O subsystem.

Agreed, it'll work when things are well behaved and the
system isn't overloaded.

However, having been a curious student myself I'm pretty
sure student workloads aren't always well behaved and do
have a tendency to overload the system once in a while.

I'm not sure Linux will be able to deal with the "I wonder
what happens if I ..." type students ;)

regards,

Rik
-- 
	http://www.linuxsymposium.org/2002/
"You're one of those condescending OLS attendants"
"Here's a nickle kid.  Go buy yourself a real t-shirt"

http://www.surriel.com/		http://distro.conectiva.com/

