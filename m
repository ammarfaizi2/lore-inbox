Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135796AbRD2PNd>; Sun, 29 Apr 2001 11:13:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135802AbRD2PNO>; Sun, 29 Apr 2001 11:13:14 -0400
Received: from asterix.hrz.tu-chemnitz.de ([134.109.132.84]:62186 "EHLO
	asterix.hrz.tu-chemnitz.de") by vger.kernel.org with ESMTP
	id <S135796AbRD2PMx>; Sun, 29 Apr 2001 11:12:53 -0400
Date: Sun, 29 Apr 2001 17:12:46 +0200
From: Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>
To: Hugh Dickins <hugh@veritas.com>
Cc: Rik van Riel <riel@conectiva.com.br>, LA Walsh <law@sgi.com>,
        linux-kernel@vger.kernel.org
Subject: Re: 2.4 and 2GB swap partition limit
Message-ID: <20010429171246.N679@nightmaster.csn.tu-chemnitz.de>
In-Reply-To: <Pine.LNX.4.33.0104271842550.17635-100000@duckman.distro.conectiva> <Pine.LNX.4.21.0104272337120.5472-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <Pine.LNX.4.21.0104272337120.5472-100000@localhost.localdomain>; from hugh@veritas.com on Fri, Apr 27, 2001 at 11:40:40PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 27, 2001 at 11:40:40PM +0100, Hugh Dickins wrote:
> > >     An interesting option (though with less-than-stellar performance
> > > characteristics) would be a dynamically expanding swapfile.  If you're
> > > going to be hit with swap penalties, it may be useful to not have to
> > > pre-reserve something you only hit once in a great while.
> > This makes amazingly little sense since you'd still need to
> > pre-reserve the disk space the swapfile grows into.
> It makes roughly the same sense as over-committing memory.
> Both are useful, both are unreliable.

And we have the one, so we should also implement the other one to
be totally unreliable.

*gd&r*

Ingo Oeser
-- 
10.+11.03.2001 - 3. Chemnitzer LinuxTag <http://www.tu-chemnitz.de/linux/tag>
         <<<<<<<<<<<<     been there and had much fun   >>>>>>>>>>>>
