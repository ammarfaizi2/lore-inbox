Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317590AbSHHOsX>; Thu, 8 Aug 2002 10:48:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317591AbSHHOsW>; Thu, 8 Aug 2002 10:48:22 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:12050 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S317590AbSHHOsW>; Thu, 8 Aug 2002 10:48:22 -0400
Date: Thu, 8 Aug 2002 11:51:51 -0300 (BRT)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: riel@duckman.distro.conectiva
To: Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>
Cc: Andrew Morton <akpm@zip.com.au>, Anton Blanchard <anton@samba.org>,
       William Lee Irwin III <wli@holomorphy.com>,
       <linux-kernel@vger.kernel.org>, <riel@imladris.surriel.com>
Subject: Re: fix CONFIG_HIGHPTE
In-Reply-To: <20020807204332.B5777@nightmaster.csn.tu-chemnitz.de>
Message-ID: <Pine.LNX.4.44L.0208081149410.2589-100000@duckman.distro.conectiva>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 7 Aug 2002, Ingo Oeser wrote:
> On Tue, Aug 06, 2002 at 07:57:07PM -0700, Andrew Morton wrote:
> > - We'll continue to suck for the University workload.
>
> Hop that's not an 2.6 option, because our University alone is
> using Linux on 1000+ machines, on 500+ private machines and lots
> of mission critical servers.
>
> If Linux becomes crap for the CPU-Server-Load, we would be VERY
> sorry here, since we are pushing it very hard[1].

Linux isn't yet up to having 500 simultaneous interactive
users, in fact I don't think it has ever been up to this
situation.

It'll probably work in many cases, but Linux just doesn't
have graceful degradation and code to cope with bad load
spikes (again, yet ... people are looking at handling this
stuff).

That doesn't mean Linux isn't working in your situation,
if it works right now it'll continue working right, chances
are it should run better in 2.6.

regards,

Rik
-- 
	http://www.linuxsymposium.org/2002/
"You're one of those condescending OLS attendants"
"Here's a nickle kid.  Go buy yourself a real t-shirt"

http://www.surriel.com/		http://distro.conectiva.com/

