Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314325AbSE1MVV>; Tue, 28 May 2002 08:21:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314340AbSE1MVU>; Tue, 28 May 2002 08:21:20 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:62468 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S314325AbSE1MVT>; Tue, 28 May 2002 08:21:19 -0400
Date: Tue, 28 May 2002 14:21:20 +0200
From: Jan Kara <jack@suse.cz>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Jan Kara <jack@suse.cz>, dalecki@evision-ventures.com,
        Nathan Scott <nathans@wobbly.melbourne.sgi.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 1/2 Quota changes
Message-ID: <20020528122120.GF20235@atrey.karlin.mff.cuni.cz>
In-Reply-To: <20020527130413.GA17926@atrey.karlin.mff.cuni.cz> <Pine.LNX.4.44.0205271122390.3172-100000@home.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Mon, 27 May 2002, Jan Kara wrote:
> >
> >   here I'm sending a bit altered (finally I decided to add 'version'
> > field) Martin's patch which moves quota info from proc to sysctl...
> > Please apply.
> 
> Well, Martin's patch is already in 2.5.18.
> 
> Also, I really don't like version numbers - that only shows that the
> author _designed_ for crap. I would suggest either:
> 
>  - no version number, and just confidence that you won't need any more
>    statistics.
> 
>  - no version number, and a file layout that is inherently expandable (or
>    rather: multiple files with clear names, one value per file).
  I choose multiple files with clear names :). I have a patch here but
it's against 2.5.17 so I'll rediff it against 2.5.18 and send it to you.
BTW have you applied the complatibility patch (I'm not sure whether
there wasn't some rejects against 2.5.18).

								Honza

-- 
Jan Kara <jack@suse.cz>
SuSE CR Labs
