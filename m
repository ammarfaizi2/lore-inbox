Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273041AbRIIUpu>; Sun, 9 Sep 2001 16:45:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273040AbRIIUpj>; Sun, 9 Sep 2001 16:45:39 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:25612 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S273039AbRIIUpY>; Sun, 9 Sep 2001 16:45:24 -0400
Date: Sun, 9 Sep 2001 17:45:36 -0300 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@duckman.distro.conectiva>
To: Davide Libenzi <davidel@xmailserver.org>
Cc: <torvalds@transmeta.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        <linux-kernel@vger.kernel.org>, Andrea Arcangeli <andrea@suse.de>,
        Manfred Spraul <manfred@colorfullife.com>
Subject: Re: Purpose of the mm/slab.c changes
In-Reply-To: <XFMail.20010909134444.davidel@xmailserver.org>
Message-ID: <Pine.LNX.4.33L.0109091745130.21049-100000@duckman.distro.conectiva>
X-supervisor: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 9 Sep 2001, Davide Libenzi wrote:

> Do You see it as a plus ?
> The new allocated slab will be very likely written ( w/o regard
> about the old content ) and an L2 mapping will generate
> invalidate traffic.

If your invalidates are slower than your RAM, you should
consider getting another computer.

Rik
--
IA64: a worthy successor to the i860.

		http://www.surriel.com/
http://www.conectiva.com/	http://distro.conectiva.com/

