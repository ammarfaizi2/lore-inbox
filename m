Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261835AbREZPmZ>; Sat, 26 May 2001 11:42:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261763AbREZPmS>; Sat, 26 May 2001 11:42:18 -0400
Received: from garrincha.netbank.com.br ([200.203.199.88]:14855 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S261827AbREZPmA>;
	Sat, 26 May 2001 11:42:00 -0400
Date: Sat, 26 May 2001 12:41:55 -0300 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
To: Ben LaHaise <bcrl@redhat.com>
Cc: Andrea Arcangeli <andrea@suse.de>, Linus Torvalds <torvalds@transmeta.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: Linux-2.4.5
In-Reply-To: <Pine.LNX.4.33.0105252206550.3806-100000@toomuch.toronto.redhat.com>
Message-ID: <Pine.LNX.4.21.0105261241130.30264-100000@imladris.rielhome.conectiva>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 25 May 2001, Ben LaHaise wrote:

> +++ work/mm/vmscan.c	Mon May 14 16:43:05 2001
> @@ -636,6 +636,12 @@

> +		if (gfp_mask & __GFP_WAIT) {

Without __GFP_WAIT, we will never call do_try_to_free_pages()

Rik
--
Virtual memory is like a game you can't win;
However, without VM there's truly nothing to lose...

http://www.surriel.com/		http://distro.conectiva.com/

Send all your spam to aardvark@nl.linux.org (spam digging piggy)

