Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286303AbSAIW6B>; Wed, 9 Jan 2002 17:58:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288566AbSAIW5w>; Wed, 9 Jan 2002 17:57:52 -0500
Received: from garrincha.netbank.com.br ([200.203.199.88]:13066 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S286303AbSAIW5k>;
	Wed, 9 Jan 2002 17:57:40 -0500
Date: Wed, 9 Jan 2002 20:57:24 -0200 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@imladris.surriel.com>
To: Daniel Tuijnman <daniel@ATComputing.nl>
Cc: "M. Edward (Ed) Borasky" <znmeb@aracnet.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: Memory management problems in 2.4.16
In-Reply-To: <20020109234706.B4555@ATComputing.nl>
Message-ID: <Pine.LNX.4.33L.0201092053010.2985-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 9 Jan 2002, Daniel Tuijnman wrote:

> > Well ... maybe *in theory* 2.4.16 should work on a machine with that
> > little RAM but I'd say in practice Linux has simply outgrown your
> > machine. Have you tried any other 2.4 kernels, say, before 2.4.10 when
> > the VM changed?

Rubbish, a VM is supposed to improve, not make it impossible to
run programs after an upgrade. Keeping Linux working on low memory
machines is definately a big issue for the VM I'm developing and
I suspect it's near the top of Andrea's list too...

> No I haven't. Was the older VM better, then? Sorry to put it so blunt,
> but if it can't swap out unneeded data, it is broken.

> 2. My first Linux experience was on a P60 with 8MB of memory, 16MB swap.
> I ran X and used TeX on my 300p. Ph.D. thesis, and that ran fine.
> So why should I need more to get less?

Absolutely agreed, the thing should just work.

If you have the time, you could try my latest -rmap patch,
available at:

	http://surriel.com/patches/2.4/2.4.17-rmap-11a

I've done some testing with 'mem=9m' (using a rather fat
kernel w/ profiling) and it seems to work decently.

regards,

Rik
-- 
"Linux holds advantages over the single-vendor commercial OS"
    -- Microsoft's "Competing with Linux" document

http://www.surriel.com/		http://distro.conectiva.com/

