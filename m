Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131638AbRCZPfc>; Mon, 26 Mar 2001 10:35:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131644AbRCZPfW>; Mon, 26 Mar 2001 10:35:22 -0500
Received: from perninha.conectiva.com.br ([200.250.58.156]:530 "HELO
	postfix.conectiva.com.br") by vger.kernel.org with SMTP
	id <S131638AbRCZPfN>; Mon, 26 Mar 2001 10:35:13 -0500
Date: Mon, 26 Mar 2001 11:55:02 -0300 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
To: John Cowan <cowan@mercury.ccil.org>
Cc: esr@thyrsus.com, Peter Samuelson <peter@cadcamlab.org>,
        "Eric S. Raymond" <esr@snark.thyrsus.com>,
        linux-kernel@vger.kernel.org, kbuild-devel@lists.sourceforge.net
Subject: Re: [kbuild-devel] Re: CML1 cleanup patch
In-Reply-To: <E14hVd6-0007eK-00@mercury.ccil.org>
Message-ID: <Pine.LNX.4.21.0103261153510.1863-100000@imladris.rielhome.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 26 Mar 2001, John Cowan wrote:

> esr scripsit:
> 
> > it needs is more overhead, and (2) interpreting symbols with leading digits
> > as nonnumeric tokens is just *wrong*.  Ugh.  Violates the Principle of Least
> > Surprise big-time.
> 
> In fact this has come up before: in Usenet software, which has to
> differentiate between an article and a sub-newsgroup.  An article has
> to have an all-numeric name, and It Would Have Been Nice if all
> newsgroup names began with non-digits, but then there was
> comp.bugs.4bsd.

What's wrong with using the _file type_ for these things ?

Conversely, why can't CML2 use the CONFIG_ prefix to
determine if a symbol is a configuration option, like
we're doing now?

Please do point out if I'm missing something, but I
really fail to see what the fuss is about.

regards,

Rik
--
Virtual memory is like a game you can't win;
However, without VM there's truly nothing to lose...

		http://www.surriel.com/
http://www.conectiva.com/	http://distro.conectiva.com.br/

