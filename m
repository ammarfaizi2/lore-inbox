Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316532AbSILP55>; Thu, 12 Sep 2002 11:57:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316512AbSILP55>; Thu, 12 Sep 2002 11:57:57 -0400
Received: from 2-210.ctame701-1.telepar.net.br ([200.193.160.210]:55962 "EHLO
	2-210.ctame701-1.telepar.net.br") by vger.kernel.org with ESMTP
	id <S316491AbSILP54>; Thu, 12 Sep 2002 11:57:56 -0400
Date: Thu, 12 Sep 2002 13:02:28 -0300 (BRT)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: riel@imladris.surriel.com
To: Giuliano Pochini <pochini@shiny.it>
cc: Jim Sibley <jlsibley@us.ibm.com>, Troy Reed <tdreed@us.ibm.com>,
       <linux-kernel@vger.kernel.org>
Subject: RE: Killing/balancing processes when overcommited
In-Reply-To: <XFMail.20020912092526.pochini@shiny.it>
Message-ID: <Pine.LNX.4.44L.0209121301320.1857-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 12 Sep 2002, Giuliano Pochini wrote:
> On 11-Sep-2002 Jim Sibley wrote:
> > I have run into a situation in a multi-user Linux environment that when
> > memory is exhausted, random things happen. [...] In a "well tuned" system,
> > we are safe, but when the system accidentally (or deliberately) becomes
> > "detuned", oom_kill is entered and arbitrarily kills  a  process.
>
> It's not difficult to make the kerner choose the right processes
> to kill. It's impossible.

This assumes there is only 1 "good" process to kill.  In reality
there will often be a number of acceptable candidates, so we just
need to identify one of those ;)

Rik
-- 
Bravely reimplemented by the knights who say "NIH".

http://www.surriel.com/		http://distro.conectiva.com/

Spamtraps of the month:  september@surriel.com trac@trac.org

