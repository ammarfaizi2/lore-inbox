Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266938AbSLPRVP>; Mon, 16 Dec 2002 12:21:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266927AbSLPRUN>; Mon, 16 Dec 2002 12:20:13 -0500
Received: from blowme.phunnypharm.org ([65.207.35.140]:45831 "EHLO
	blowme.phunnypharm.org") by vger.kernel.org with ESMTP
	id <S266926AbSLPRTb>; Mon, 16 Dec 2002 12:19:31 -0500
Date: Mon, 16 Dec 2002 12:27:22 -0500
From: Ben Collins <bcollins@debian.org>
To: Larry McVoy <lm@work.bitmover.com>, Arjan van de Ven <arjanv@redhat.com>,
       Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org,
       Larry McVoy <lm@bitmover.com>
Subject: Re: Notification hooks
Message-ID: <20021216172722.GX504@hopper.phunnypharm.org>
References: <20021216171218.GV504@hopper.phunnypharm.org> <1040059138.1438.1.camel@laptop.fenrus.com> <20021216092129.D432@work.bitmover.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021216092129.D432@work.bitmover.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 16, 2002 at 09:21:29AM -0800, Larry McVoy wrote:
> On Mon, Dec 16, 2002 at 06:18:55PM +0100, Arjan van de Ven wrote:
> > On Mon, 2002-12-16 at 18:12, Ben Collins wrote:
> > > Linus, is there anyway I can request a hook so that anything that
> > > changes drivers/ieee1394/ in your repo sends me an email with the diff
> > > for just the files in that directory, and the changeset log? Is this
> > > something that bkbits can do?
> > > 
> > > I'd bet lots of ppl would like similar hooks for their portions of the
> > > source.
> > 
> > well there is the bk commits list that has all individual changesets.
> > Add procmail and the patchutils program "grepdiff" to the recipe and I
> > think we have a winner.....
> 
> I suspect you want to look at all the files in the cset.  I think what
> you want is a script which is given a list of files and sends a patch
> for each new changeset which touches any of those files.  Because if 
> a changeset touched drivers/ieee1394/ and include/something then you
> probably want both.
> 
> bk help triggers.

Well, if it affects more than just the files I am interested in, I only
want the diff for those files, but the changeset log and files-affected
for the whole changeset.

If I want the full diff I can go to bkbits or the archive of the commit
list.

-- 
Debian     - http://www.debian.org/
Linux 1394 - http://www.linux1394.org/
Subversion - http://subversion.tigris.org/
Deqo       - http://www.deqo.com/
