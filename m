Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131404AbRCOVz5>; Thu, 15 Mar 2001 16:55:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131443AbRCOVzr>; Thu, 15 Mar 2001 16:55:47 -0500
Received: from perninha.conectiva.com.br ([200.250.58.156]:6927 "HELO
	postfix.conectiva.com.br") by vger.kernel.org with SMTP
	id <S131404AbRCOVzj>; Thu, 15 Mar 2001 16:55:39 -0500
Date: Fri, 16 Mar 2001 02:08:01 -0300 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@duckman.distro.conectiva>
To: Andrzej Krzysztofowicz <ankry@pg.gda.pl>
Cc: William T Wilson <fluffy@snurgle.org>,
        Torrey Hoffman <torrey.hoffman@myrio.com>,
        Linux Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: Is swap == 2 * RAM a permanent thing?
In-Reply-To: <200103152145.WAA22485@sunrise.pg.gda.pl>
Message-ID: <Pine.LNX.4.33.0103160205480.1320-100000@duckman.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 15 Mar 2001, Andrzej Krzysztofowicz wrote:
> "Rik van Riel wrote:"
> >   total usage == maximum(swap, ram)
>
> Does it mean that having swap<RAM you only lose some disk space ?

If you actually "rely" on swap, yes.

If you usually don't swap but want to have it for "overflow"
in some situations, or if only a few things end up on swap,
then it's actually useful.

regards,

Rik
--
Linux MM bugzilla: http://linux-mm.org/bugzilla.shtml

Virtual memory is like a game you can't win;
However, without VM there's truly nothing to lose...

		http://www.surriel.com/
http://www.conectiva.com/	http://distro.conectiva.com/

