Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262681AbRFQTa2>; Sun, 17 Jun 2001 15:30:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262702AbRFQTaS>; Sun, 17 Jun 2001 15:30:18 -0400
Received: from spiral.extreme.ro ([212.93.159.205]:2944 "HELO
	spiral.extreme.ro") by vger.kernel.org with SMTP id <S262681AbRFQTaF>;
	Sun, 17 Jun 2001 15:30:05 -0400
Date: Sun, 17 Jun 2001 22:31:47 +0300
From: Dan Podeanu <pdan@spiral.extreme.ro>
To: Tom Rini <trini@kernel.crashing.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4 VM & swap question
Message-ID: <20010617223147.A5849@spiral.extreme.ro>
Mail-Followup-To: Tom Rini <trini@kernel.crashing.org>,
	linux-kernel@vger.kernel.org
In-Reply-To: <20010617104836.B11642@opus.bloom.county> <20010617221239.B1027@spiral.extreme.ro> <20010617122033.F11642@opus.bloom.county>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.15i
In-Reply-To: <20010617122033.F11642@opus.bloom.county>; from trini@kernel.crashing.org on Sun, Jun 17, 2001 at 12:20:33PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Yes, I know there's no hard and fast rule for the exact ammount of ram/swap one
> needs that will always work.  However, in 2.2 for a 'workstation' one could
> usually quite happily get away with having 128:128 and never have much of a
> problem.  with 2.4.0 and up this isn't the case.  This has been the cause
> of many people complaining quite loudly about 2.4 VM sucking and having
> lots of OOM kills going about.  It's also been called an 'aritificial limit'
> since one of the VM people had a patch to 'fix' this.  What I'm trying to
> figure out is if this problem exists linearly or just with 'lower' ammounts
> of total physical ram.  ie if I jump up to 512mb and don't have a webserver
> or database (ie I've got 512mb so I end up with a big disk cache) will I need
> to have 1gb of swap just to keep the VM happy?  Will 256 be enough?  Could I
> even live w/o swap?

Probably you'd live with 512MB of swap. As for w/o swap? You need it
atleast to hear the disks trashing and know you have to ctrl-c the damn
process, if not anything else.

I have:
spiral:~# free
             total       used       free     shared    buffers     cached
Mem:        254572      89936     164636          0       4352      48016
-/+ buffers/cache:      37568     217004
Swap:       530136          0     530136

With X, netscape and a gcc running and doing quite fine.
