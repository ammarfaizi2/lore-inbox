Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287133AbRL2EwV>; Fri, 28 Dec 2001 23:52:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287134AbRL2EwM>; Fri, 28 Dec 2001 23:52:12 -0500
Received: from garrincha.netbank.com.br ([200.203.199.88]:49417 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S287133AbRL2Ev5>;
	Fri, 28 Dec 2001 23:51:57 -0500
Date: Sat, 29 Dec 2001 02:52:29 -0200
From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
To: Keith Owens <kaos@ocs.com.au>
Cc: Mike Castle <dalgoda@ix.netcom.com>, linux-kernel@vger.kernel.org
Subject: Re: State of the new config & build system
Message-ID: <20011229025229.A2103@conectiva.com.br>
Mail-Followup-To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
	Keith Owens <kaos@ocs.com.au>, Mike Castle <dalgoda@ix.netcom.com>,
	linux-kernel@vger.kernel.org
In-Reply-To: <20011229042139.GC14067@thune.mrc-home.com> <9467.1009601050@ocs3.intra.ocs.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9467.1009601050@ocs3.intra.ocs.com.au>
User-Agent: Mutt/1.3.23i
X-Url: http://advogato.org/person/acme
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Em Sat, Dec 29, 2001 at 03:44:10PM +1100, Keith Owens escreveu:
> On Fri, 28 Dec 2001 20:21:39 -0800, 
> Mike Castle <dalgoda@ix.netcom.com> wrote:
> >On Fri, Dec 28, 2001 at 10:58:03PM -0500, Legacy Fishtank wrote:
> >> s/break/update dependencies/
> >> 
> >> I assumed this was blindingly obvious, but I guess not.
> >
> >To YOU and other kernel hackers, yes.
> >
> >But not to everyone.
> >
> >Plus, as I understand it, it will be faster to:
> >
> >apply a patch and rebuild with kbuild 2.5
> >
> >than to:
> >
> >apply a patch, make dep && make bzImage.
> >
> >Correct?
> 
> As long as the patch does not change an include file that is used a
> lot, yes, a patch and make will be significantly faster using kbuild

And thats something I encourage people to work on: to reduce the includes
dependencies hell, I hope to have the cleanup I did to include/net/sock.h
removing the protocol specific headers from there and the cleanup that
Daniel Phillips is doing in include/net/fs.h in the tree soon, of course if
there's not issues, that we're very interesting to know.

- Arnaldo
