Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314061AbSEMPhX>; Mon, 13 May 2002 11:37:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314065AbSEMPhW>; Mon, 13 May 2002 11:37:22 -0400
Received: from bitmover.com ([192.132.92.2]:33202 "EHLO bitmover.com")
	by vger.kernel.org with ESMTP id <S314061AbSEMPhV>;
	Mon, 13 May 2002 11:37:21 -0400
Date: Mon, 13 May 2002 08:37:21 -0700
From: Larry McVoy <lm@bitmover.com>
To: Tomas Szepe <szepe@pinerecords.com>
Cc: Russell King <rmk@arm.linux.org.uk>,
        "Dave Gilbert (Home)" <gilbertd@treblig.org>,
        Rik van Riel <riel@conectiva.com.br>, linux-kernel@vger.kernel.org
Subject: Re: Changelogs on kernel.org
Message-ID: <20020513083721.O3176@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	Tomas Szepe <szepe@pinerecords.com>,
	Russell King <rmk@arm.linux.org.uk>,
	"Dave Gilbert (Home)" <gilbertd@treblig.org>,
	Rik van Riel <riel@conectiva.com.br>, linux-kernel@vger.kernel.org
In-Reply-To: <20020512145802Z313578-22651+30503@vger.kernel.org> <Pine.LNX.4.44L.0205122146310.32261-100000@imladris.surriel.com> <20020513115800.GC4258@louise.pinerecords.com> <3CDFB41A.6070701@treblig.org> <20020513140158.B6024@flint.arm.linux.org.uk> <20020513132734.GA5134@louise.pinerecords.com> <20020513081256.B20864@work.bitmover.com> <20020513152923.GB5811@louise.pinerecords.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 13, 2002 at 05:29:23PM +0200, Tomas Szepe wrote:
> > BK reporting is keyed off of somehing called "dspecs" (for data
> > specification).  They are a lot like a primitive printf format.
> > The default dspec for changes is
> > 
> > 	":DPN:@:I:, :Dy:-:Dm:-:Dd: :T::TZ:, :P:$if(:HT:){@:HT:}\n$each(:C:){  (:C:)\n}$each(:TAG:){  TAG: (:TAG:)\n}\n"
> 
> Nice!
> 
> The idea with the perl script was, I reckon, to merely provide a tool
> thru which people could pipe the standard linux 2.5 ChangeLog and get
> an output that suits their own eye. Something like
> 
> $ wget -q ftp://ftp.kernel.org/pub/linux/kernel/v2.5/ChangeLog-2.5.16
> $ cat ChangeLog-2.5.16| CMODE=1 /usr/src/linux/scripts/cl.pl| less

That's cool by me, perl is the language of choice here.  If I could have
embedded perl into the dspecs, I would have :)  If you get to the point
where you want more information from the changelogs than is there, just
remember there is probably a way to get it easily.

Cheers,
-- 
---
Larry McVoy            	 lm at bitmover.com           http://www.bitmover.com/lm 
