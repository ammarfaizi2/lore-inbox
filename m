Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131586AbRCXGk6>; Sat, 24 Mar 2001 01:40:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131589AbRCXGks>; Sat, 24 Mar 2001 01:40:48 -0500
Received: from perninha.conectiva.com.br ([200.250.58.156]:28174 "HELO
	postfix.conectiva.com.br") by vger.kernel.org with SMTP
	id <S131587AbRCXGkk>; Sat, 24 Mar 2001 01:40:40 -0500
Date: Sat, 24 Mar 2001 02:55:59 -0300 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
To: george anzinger <george@mvista.com>
Cc: Paul Jakma <paulj@itg.ie>, Szabolcs Szakacsits <szaka@f-secure.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Stephen Clouse <stephenc@theiqgroup.com>,
        Guest section DW <dwguest@win.tue.nl>,
        "Patrick O'Rourke" <orourke@missioncriticallinux.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Prevent OOM from killing init
In-Reply-To: <3ABBC702.AC9C3C92@mvista.com>
Message-ID: <Pine.LNX.4.21.0103240255090.1863-100000@imladris.rielhome.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 23 Mar 2001, george anzinger wrote:

> What happens if you just make swap VERY large?  Does the system thrash
> it self to a virtual standstill?

It does.  I need to implement load control code (so we suspend
processes in turn to keep the load low enough so we can avoid
thrashing).

> Is this a possible answer?  Supposedly you could then sneak in and
> blow away the bad guys manually ...

This certainly works.

regards,

Rik
--
Virtual memory is like a game you can't win;
However, without VM there's truly nothing to lose...

		http://www.surriel.com/
http://www.conectiva.com/	http://distro.conectiva.com.br/

