Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313764AbSDPQlI>; Tue, 16 Apr 2002 12:41:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313765AbSDPQlH>; Tue, 16 Apr 2002 12:41:07 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:48657 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S313764AbSDPQlG>; Tue, 16 Apr 2002 12:41:06 -0400
Date: Tue, 16 Apr 2002 13:40:49 -0300 (BRT)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: riel@duckman.distro.conectiva
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Andrea Arcangeli <andrea@suse.de>,
        Moritz Franosch <jfranosc@physik.tu-muenchen.de>,
        <marcelo@conectiva.com.br>, <linux-kernel@vger.kernel.org>
Subject: Re: IO performance problems in 2.4.19-pre5 when writing to DVD-RAM/ZIP/MO
In-Reply-To: <E16xVW9-0000Fq-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.44L.0204161334250.16531-100000@duckman.distro.conectiva>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 16 Apr 2002, Alan Cox wrote:

> > > benchmarks 1-4, kernel 2.4.19-pre5 performed much worse than
> > > 2.4.18. The reason may be that the main throughput stems from the
> > > short moments where, for what reason whatsoever, read speed increases
>
> Fairness, throughput, latency - pick any two..

Personally I try to go for fairness and latency in -rmap,
since most real workloads I've encountered don't seem to
have throughput problems.

The standard "it's getting slow" complaint has been about
response time and fairness 90% of the time, usually when
the system stalls one process during some other activity.

> > Right fix is different but not suitable for 2.4.
>
> Curious - what do you think the right fix is ?

Tuning the current system for latency and fairness should
keep most people happy. Desktop users really won't notice
if unpacking an RPM takes 20% longer, but having their
mp3 skip during RPM unpacking is generally considered
unacceptable.

regards,

Rik
-- 
	http://www.linuxsymposium.org/2002/
"You're one of those condescending OLS attendants"
"Here's a nickle kid.  Go buy yourself a real t-shirt"

http://www.surriel.com/		http://distro.conectiva.com/

