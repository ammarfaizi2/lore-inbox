Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313416AbSDPPcr>; Tue, 16 Apr 2002 11:32:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313477AbSDPPcq>; Tue, 16 Apr 2002 11:32:46 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:6149 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S313416AbSDPPcq>; Tue, 16 Apr 2002 11:32:46 -0400
Date: Tue, 16 Apr 2002 12:32:25 -0300 (BRT)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: riel@duckman.distro.conectiva
To: Mark Mielke <mark@mark.mielke.cc>
Cc: Terje Eggestad <terje.eggestad@scali.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Liam Girdwood <l_girdwood@bitwise.co.uk>,
        BALBIR SINGH <balbir.singh@wipro.com>,
        William Olaf Fraczyk <olaf@navi.pl>,
        Lee Irwin III <wli@holomorphy.com>
Subject: Re: Why HZ on i386 is 100 ?
In-Reply-To: <20020416093824.A4025@mark.mielke.cc>
Message-ID: <Pine.LNX.4.44L.0204161231440.16531-100000@duckman.distro.conectiva>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 16 Apr 2002, Mark Mielke wrote:

> Increasing the HZ can only improve responsiveness, however, there is a
> cost (mentioned by others). The cost is that the scheduler is executed
> more often per second. If the scheduler does the same amount of work
> per tick, but there are more ticks per second, the scheduler does more
> work overall, and the CPU is free for use by the processes less.

Why are you discussing Linux 1.2 ?

Linux is not running the scheduler each cpu tick and hasn't
done this for years.

regards,

Rik
-- 
	http://www.linuxsymposium.org/2002/
"You're one of those condescending OLS attendants"
"Here's a nickle kid.  Go buy yourself a real t-shirt"

http://www.surriel.com/		http://distro.conectiva.com/

