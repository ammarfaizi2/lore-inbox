Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291377AbSAaW3t>; Thu, 31 Jan 2002 17:29:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291378AbSAaW3a>; Thu, 31 Jan 2002 17:29:30 -0500
Received: from dsl-213-023-043-113.arcor-ip.net ([213.23.43.113]:13730 "EHLO
	starship.berlin") by vger.kernel.org with ESMTP id <S291377AbSAaW3Y>;
	Thu, 31 Jan 2002 17:29:24 -0500
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: "Drew P. Vogel" <dvogel@intercarve.net>
Subject: Re: Public patch penguin
Date: Thu, 31 Jan 2002 23:34:18 +0100
X-Mailer: KMail [version 1.3.2]
Cc: Dave Jones <davej@suse.de>, <linux-kernel@vger.kernel.org>,
        <patchbot-devel@killeri.net>
In-Reply-To: <Pine.LNX.4.33.0201311103450.15627-100000@northface.intercarve.net>
In-Reply-To: <Pine.LNX.4.33.0201311103450.15627-100000@northface.intercarve.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E16WPmc-0000Nz-00@starship.berlin>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On January 31, 2002 05:09 pm, Drew P. Vogel wrote:
> >Agreed.  Please have a look at what we're doing here:
> >
> >   http://killeri.net/cgi-bin/alias/ezmlm-cgi
> >
> >It's too early to try the code, currently at version 0.0 (thanks to Rasmus
> >Andersen for that, Kalle Kivimaa for the mail list).  The guilding design
> >rule is to do everything with MTAs that submitters and maintainers _are
> >already using_, and to do it _just as they do it now_, using a normal mail
> >archive as the data base.  The only thing that changes is: you mail the
> >patchbot instead of the maintainer.
> >
> >Submitters will need to put some minimal number of additional lines in the
> >body of the email, and it's possible we'll get the 'minimal number' down to
> >zero for common cases (one line description comes from subject, long
> >description comes from mail, purpose is implied by [BUGFIX] in subject line,
> >etc).
> >
> >Do you see anything to object to so far?
> 
> Well, I don't have any objections, per se. What I did notice immediately
> though is that the web browser is still involved.

Nope, no web browser.  What made you imagine that?

We would likely provide a web browser view of the patch database at some point,
but this is 'future work', it's not part of the fundamental operation of the
thing, which is all by mail.

> My *ideal*
> implementation would be very similar. The only significant difference
> would be that the patches would be sorted into directories, in a public
> ftp archive.

We haven't defined the database format yet.  The first purpose is to establish
the flow of patches from submitter to maintainer, with confirmation, rejection,
etc, flowing back in the other direction.  Then we move on to maintaining
state for each patch, and archiving the patches (kernel.org itself doesn't
archive, so we'll have to do that ourselves, not such a bad thing).

> The special comments would be display while changing
> directories in the archive. This way I can at least just type 'lynx
> ftp://kernel.patches.archive/patch_name/' and the first entry is the most
> current patch, and the special comments from the author would be displayed
> at the top.

OK, interesting, maybe that is the way to go.  This needs to be kicked around
a little.

-- 
Daniel
