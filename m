Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315894AbSEGPhX>; Tue, 7 May 2002 11:37:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315895AbSEGPhW>; Tue, 7 May 2002 11:37:22 -0400
Received: from angband.namesys.com ([212.16.7.85]:18311 "HELO
	angband.namesys.com") by vger.kernel.org with SMTP
	id <S315894AbSEGPhU>; Tue, 7 May 2002 11:37:20 -0400
Date: Tue, 7 May 2002 19:37:19 +0400
From: Oleg Drokin <green@namesys.com>
To: Chris Mason <mason@suse.com>
Cc: Hans Reiser <reiser@namesys.com>, marcelo@conectiva.com.br,
        linux-kernel@vger.kernel.org, reiserfs-dev@namesys.com
Subject: Re: [reiserfs-dev] [BK] [2.4] Reiserfs changeset 2 out of 4, please apply.
Message-ID: <20020507193719.A28170@namesys.com>
In-Reply-To: <200205071505.g47F5iE04039@namesys.com> <1020785252.32097.165.camel@tiny>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On Tue, May 07, 2002 at 11:27:32AM -0400, Chris Mason wrote:
> >  You can get this changeset from bk://thebsh.namesys.com/bk/reiser3-linux-2.4
> >  This changeset are cleaning up reiserfscode, removes stale comments, and
> >  rewrites some "borrowed" functions so that all of the code in reiserfs subdir
> >  should now only belong to NAMESYS.
> It is the end of a release cycle on a stable kernel with huge changes to
> the IDE layer, and we have at least one unconfirmed report of problems
> with reiserfs+IDE after a crash.

That's true.

> This is not the right time to send in cleanups like this, especially
> when they bits as useless as the stuff below.  #1, #2 and #4 look like
> valid fixes.  #3 should probably be mixed with the iput deadlock fix
> like Oleg did in 2.5, and should wait until after 2.4.19.

#2 and $4 are cleanups, #1 and #3 are bugfixes.
And iput deadlock fix is too big of a change for 2.4.19, so it is not included.
Let's see how will it behave in 2.5 first.
And cleanups are harmless ones, so there is no risk of getting these in.

In short, these changes are not "huge", and mostly non-intrusive.

Bye,
    Oleg
