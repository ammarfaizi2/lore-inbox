Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280585AbRKFVYp>; Tue, 6 Nov 2001 16:24:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280583AbRKFVYf>; Tue, 6 Nov 2001 16:24:35 -0500
Received: from perninha.conectiva.com.br ([200.250.58.156]:1028 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S280579AbRKFVYY>; Tue, 6 Nov 2001 16:24:24 -0500
Date: Tue, 6 Nov 2001 19:24:13 -0200 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@duckman.distro.conectiva>
To: <erik@hensema.net>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: PROPOSAL: /proc standards (was dot-proc interface [was: /proc
In-Reply-To: <slrn9ugh1g.dld.spamtrap@dexter.hensema.xs4all.nl>
Message-ID: <Pine.LNX.4.33L.0111061921240.27028-100000@duckman.distro.conectiva>
X-supervisor: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 6 Nov 2001, Erik Hensema wrote:

> >1)  IT SHOULD NOT BE PRETTY.  No tabs to line up columns.  No "progress
> >bars."  No labels except as "proc comments" (see later).  No in-line labelling.
>
> It should not be pretty TO HUMANS. Slight difference. It should
> be pretty to shellscripts and other applications though.

I really fail to see your point, it's trivial to make
files which are easy to read by humans and also very
easy to parse by shellscripts.

PROCESSOR=0
VENDOR_ID=GenuineIntel
CPU_FAMILY=6
MODEL=6
MODEL_NAME="Celeron (Mendocino)"
.....

As you can see, this is easily readable by humans,
while "parsing" by a shell script would be as follows:

. /proc/cpuinfo

After which you could just "echo $PROCESSOR" or
something like that ...

Yes, this is probably a bad example, but it does show
that machine-readable and human-readable aren't mutually
exclusive.

regards,

Rik
-- 
DMCA, SSSCA, W3C?  Who cares?  http://thefreeworld.net/

http://www.surriel.com/		http://distro.conectiva.com/

