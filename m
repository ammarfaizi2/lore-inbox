Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266841AbSLPRNk>; Mon, 16 Dec 2002 12:13:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266844AbSLPRNk>; Mon, 16 Dec 2002 12:13:40 -0500
Received: from bitmover.com ([192.132.92.2]:8853 "EHLO mail.bitmover.com")
	by vger.kernel.org with ESMTP id <S266841AbSLPRNj>;
	Mon, 16 Dec 2002 12:13:39 -0500
Date: Mon, 16 Dec 2002 09:21:29 -0800
From: Larry McVoy <lm@bitmover.com>
To: Arjan van de Ven <arjanv@redhat.com>
Cc: Ben Collins <bcollins@debian.org>, Linus Torvalds <torvalds@transmeta.com>,
       linux-kernel@vger.kernel.org, Larry McVoy <lm@bitmover.com>
Subject: Re: Notification hooks
Message-ID: <20021216092129.D432@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	Arjan van de Ven <arjanv@redhat.com>,
	Ben Collins <bcollins@debian.org>,
	Linus Torvalds <torvalds@transmeta.com>,
	linux-kernel@vger.kernel.org, Larry McVoy <lm@bitmover.com>
References: <20021216171218.GV504@hopper.phunnypharm.org> <1040059138.1438.1.camel@laptop.fenrus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1040059138.1438.1.camel@laptop.fenrus.com>; from arjanv@redhat.com on Mon, Dec 16, 2002 at 06:18:55PM +0100
X-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 16, 2002 at 06:18:55PM +0100, Arjan van de Ven wrote:
> On Mon, 2002-12-16 at 18:12, Ben Collins wrote:
> > Linus, is there anyway I can request a hook so that anything that
> > changes drivers/ieee1394/ in your repo sends me an email with the diff
> > for just the files in that directory, and the changeset log? Is this
> > something that bkbits can do?
> > 
> > I'd bet lots of ppl would like similar hooks for their portions of the
> > source.
> 
> well there is the bk commits list that has all individual changesets.
> Add procmail and the patchutils program "grepdiff" to the recipe and I
> think we have a winner.....

I suspect you want to look at all the files in the cset.  I think what
you want is a script which is given a list of files and sends a patch
for each new changeset which touches any of those files.  Because if 
a changeset touched drivers/ieee1394/ and include/something then you
probably want both.

bk help triggers.
-- 
---
Larry McVoy            	 lm at bitmover.com           http://www.bitmover.com/lm 
