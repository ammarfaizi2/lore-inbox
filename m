Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262074AbTJXXe3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Oct 2003 19:34:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262092AbTJXXe2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Oct 2003 19:34:28 -0400
Received: from smtp.bitmover.com ([192.132.92.12]:47011 "EHLO
	smtp.bitmover.com") by vger.kernel.org with ESMTP id S262074AbTJXXe1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Oct 2003 19:34:27 -0400
Date: Fri, 24 Oct 2003 16:34:17 -0700
From: Larry McVoy <lm@bitmover.com>
To: Chris Wright <chrisw@osdl.org>
Cc: Tom Rini <trini@kernel.crashing.org>, Frank Cusack <fcusack@fcusack.com>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: cset #'s stable?
Message-ID: <20031024233417.GA12636@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	Chris Wright <chrisw@osdl.org>,
	Tom Rini <trini@kernel.crashing.org>,
	Frank Cusack <fcusack@fcusack.com>,
	lkml <linux-kernel@vger.kernel.org>
References: <20031021091347.A7526@google.com> <20031021095209.A32703@osdlab.pdx.osdl.net> <20031024222054.GB972@ip68-0-152-218.tc.ph.cox.net> <20031024153907.D19313@osdlab.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031024153907.D19313@osdlab.pdx.osdl.net>
User-Agent: Mutt/1.4i
X-MailScanner-Information: Please contact the ISP for more information
X-MailScanner: Found to be clean
X-MailScanner-SpamCheck: not spam (whitelisted), SpamAssassin (score=0.2,
	required 7, AWL)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 24, 2003 at 03:39:07PM -0700, Chris Wright wrote:
> * Tom Rini (trini@kernel.crashing.org) wrote:
> > FWIW, it's easy to go back and forth as well, bash (pure sh?) functions
> > to do it:
> 
> <snipped useful shell funcs>
> 
> Nice.  I believe current bk lets you do bk changes -k -r<rev> to get key
> from ChangeSet file (identical to bk prs -r -hnd:Key ChangeSet), and
> echo key | bk key2rev ChangeSet to convert back.  Not much simpler, but
> a little ;-)

In general, we're moving towards a BK version where keys (internal revisions,
sort of like mail message id's) are useable anywhere a rev is useable.

One place we'll be using this is on BK/Web so that you guys can have 
URLs that don't change out from underneath you. 

We should fix that at the same time that we turn on the GNU patch server
so you can get any changeset as a patch.  The dual T1's are due in at the
end of this month.

There may be some delay, I'm away dealing with family stuff that is way
higher in priority than this but I'll try and get someone else to do it
if it takes longer than the end of the month before I'm back.
-- 
---
Larry McVoy              lm at bitmover.com          http://www.bitmover.com/lm
