Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313867AbSEMPaL>; Mon, 13 May 2002 11:30:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314061AbSEMPaK>; Mon, 13 May 2002 11:30:10 -0400
Received: from louise.pinerecords.com ([212.71.160.16]:37894 "EHLO
	louise.pinerecords.com") by vger.kernel.org with ESMTP
	id <S313867AbSEMPaH>; Mon, 13 May 2002 11:30:07 -0400
Date: Mon, 13 May 2002 17:29:23 +0200
From: Tomas Szepe <szepe@pinerecords.com>
To: Larry McVoy <lm@work.bitmover.com>, Russell King <rmk@arm.linux.org.uk>,
        "Dave Gilbert (Home)" <gilbertd@treblig.org>,
        Rik van Riel <riel@conectiva.com.br>, linux-kernel@vger.kernel.org
Subject: Re: Changelogs on kernel.org
Message-ID: <20020513152923.GB5811@louise.pinerecords.com>
In-Reply-To: <20020512145802Z313578-22651+30503@vger.kernel.org> <Pine.LNX.4.44L.0205122146310.32261-100000@imladris.surriel.com> <20020513115800.GC4258@louise.pinerecords.com> <3CDFB41A.6070701@treblig.org> <20020513140158.B6024@flint.arm.linux.org.uk> <20020513132734.GA5134@louise.pinerecords.com> <20020513081256.B20864@work.bitmover.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.99i
X-OS: Linux/sparc 2.2.21-rc3-ext3-0.0.7a SMP (up 20:52)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> BK reporting is keyed off of somehing called "dspecs" (for data
> specification).  They are a lot like a primitive printf format.
> The default dspec for changes is
> 
> 	":DPN:@:I:, :Dy:-:Dm:-:Dd: :T::TZ:, :P:$if(:HT:){@:HT:}\n$each(:C:){  (:C:)\n}$each(:TAG:){  TAG: (:TAG:)\n}\n"

Nice!

The idea with the perl script was, I reckon, to merely provide a tool
thru which people could pipe the standard linux 2.5 ChangeLog and get
an output that suits their own eye. Something like

$ wget -q ftp://ftp.kernel.org/pub/linux/kernel/v2.5/ChangeLog-2.5.16
$ cat ChangeLog-2.5.16| CMODE=1 /usr/src/linux/scripts/cl.pl| less

T.
