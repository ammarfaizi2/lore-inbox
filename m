Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131495AbRCSPUl>; Mon, 19 Mar 2001 10:20:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131498AbRCSPUb>; Mon, 19 Mar 2001 10:20:31 -0500
Received: from mailhub2.shef.ac.uk ([143.167.2.154]:26847 "EHLO
	mailhub2.shef.ac.uk") by vger.kernel.org with ESMTP
	id <S131495AbRCSPUT>; Mon, 19 Mar 2001 10:20:19 -0500
Date: Mon, 19 Mar 2001 15:21:56 +0000 (GMT)
From: Guennadi Liakhovetski <g.liakhovetski@ragingbull.com>
To: Rik van Riel <riel@conectiva.com.br>
cc: Andrzej Krzysztofowicz <ankry@pg.gda.pl>,
        William T Wilson <fluffy@snurgle.org>,
        Torrey Hoffman <torrey.hoffman@myrio.com>,
        Linux Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: Is swap == 2 * RAM a permanent thing?
In-Reply-To: <Pine.LNX.4.33.0103160205480.1320-100000@duckman.distro.conectiva>
Message-ID: <Pine.LNX.4.21.0103191518580.25521-100000@erdos.shef.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 16 Mar 2001, Rik van Riel wrote:

> On Thu, 15 Mar 2001, Andrzej Krzysztofowicz wrote:
> > "Rik van Riel wrote:"
> > >   total usage == maximum(swap, ram)
> >
> > Does it mean that having swap<RAM you only lose some disk space ?
> 
> If you actually "rely" on swap, yes.

Sorry, I also don't understand this. Take a plain simple situation - your
RAM is full, swap (which is < RAM) empty, you start (or try to) another
application - will it start? If yes - it means you already have 
total > max(swap, RAM)
if you simply can't start another app in this situation - that'd be VERY
strange...

Guennadi

> 
> If you usually don't swap but want to have it for "overflow"
> in some situations, or if only a few things end up on swap,
> then it's actually useful.
> 
> regards,
> 
> Rik
> --
> Linux MM bugzilla: http://linux-mm.org/bugzilla.shtml
> 
> Virtual memory is like a game you can't win;
> However, without VM there's truly nothing to lose...
> 
> 		http://www.surriel.com/
> http://www.conectiva.com/	http://distro.conectiva.com/
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

___

Dr. Guennadi V. Liakhovetski
Department of Applied Mathematics
University of Sheffield, U.K.
email: G.Liakhovetski@sheffield.ac.uk


