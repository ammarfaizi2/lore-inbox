Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281274AbRKESmB>; Mon, 5 Nov 2001 13:42:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281273AbRKESlv>; Mon, 5 Nov 2001 13:41:51 -0500
Received: from perninha.conectiva.com.br ([200.250.58.156]:50181 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S281278AbRKESln>; Mon, 5 Nov 2001 13:41:43 -0500
Date: Mon, 5 Nov 2001 16:40:57 -0200 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@duckman.distro.conectiva>
To: Ben Greear <greearb@candelatech.com>
Cc: <dalecki@evision.ag>, Stephen Satchell <satch@concentric.net>,
        "Albert D. Cahalan" <acahalan@cs.uml.edu>,
        Jakob =?ISO-8859-1?Q?=D8stergaard?= <jakob@unthought.net>,
        Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>,
        Alexander Viro <viro@math.psu.edu>, John Levon <moz@compsoc.man.ac.uk>,
        <linux-kernel@vger.kernel.org>,
        Daniel Phillips <phillips@bonn-fries.net>, Tim Jansen <tim@tjansen.de>
Subject: Re: PROPOSAL: dot-proc interface [was: /proc stuff]
In-Reply-To: <3BE6DA52.6040100@candelatech.com>
Message-ID: <Pine.LNX.4.33L.0111051638230.27028-100000@duckman.distro.conectiva>
X-supervisor: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 5 Nov 2001, Ben Greear wrote:

> I would rather have a header block, as well as docs in the
> source. If the header cannot easily explain it, then the header
> can have a URL or other link to the full explanation.

I think you've hit the core of the problem. There is no magical
bullet which will stop badly written userland programs from
breaking, but the kernel developers should have the courtesy
of providing documentation for the /proc files so the writers
of userland programs can have an idea what to expect.

The inline docbook stuff in the kernel should make it easy for
kernel developers to keep code and documentation in sync, while
also making it easy to generate documentation in a format which
is nice to read ;)

regards,

Rik
-- 
DMCA, SSSCA, W3C?  Who cares?  http://thefreeworld.net/  (volunteers needed)

http://www.surriel.com/		http://distro.conectiva.com/

