Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275750AbRJBBH5>; Mon, 1 Oct 2001 21:07:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275752AbRJBBHr>; Mon, 1 Oct 2001 21:07:47 -0400
Received: from krusty.E-Technik.Uni-Dortmund.DE ([129.217.163.1]:54789 "HELO
	krusty.e-technik.uni-dortmund.de") by vger.kernel.org with SMTP
	id <S275753AbRJBBHa>; Mon, 1 Oct 2001 21:07:30 -0400
Date: Mon, 1 Oct 2001 22:35:40 +0200
From: Matthias Andree <matthias.andree@stud.uni-dortmund.de>
To: linux-kernel@vger.kernel.org
Subject: Re: VM: 2.4.10 vs. 2.4.10-ac2 and qsort()
Message-ID: <20011001223540.B19559@emma1.emma.line.org>
Mail-Followup-To: linux-kernel@vger.kernel.org
In-Reply-To: <3.0.6.32.20011001203320.02381600@pop.tiscalinet.it> <Pine.LNX.4.33L.0110011604310.4835-100000@imladris.rielhome.conectiva>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33L.0110011604310.4835-100000@imladris.rielhome.conectiva>
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 01 Oct 2001, Rik van Riel wrote:

> I'm not sure either, since qsort doesn't really have much
> locality of reference but just walks all over the place.
> 
> This is direct contrast with the basic assumption on which
> VM and CPU caches are built ;)
> 
> I wonder how eg. merge sort would perform ...

Just rip it off NetBSD and there you go. (FreeBSD's breaks on machines
like SPARC, NetBSD's does not.)

http://www.de.freebsd.org/cgi/cvsweb.cgi/basesrc/lib/libc/stdlib/merge.c?rev=1.10&cvsroot=netbsd
