Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285229AbSCRP0w>; Mon, 18 Mar 2002 10:26:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285720AbSCRP0m>; Mon, 18 Mar 2002 10:26:42 -0500
Received: from cpe-24-221-152-185.az.sprintbbd.net ([24.221.152.185]:25731
	"EHLO opus.bloom.county") by vger.kernel.org with ESMTP
	id <S285229AbSCRP0a>; Mon, 18 Mar 2002 10:26:30 -0500
Date: Mon, 18 Mar 2002 08:25:12 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: David Woodhouse <dwmw2@infradead.org>
Cc: Larry McVoy <lm@bitmover.com>, Jeff Garzik <jgarzik@mandrakesoft.com>,
        James Bottomley <James.Bottomley@SteelEye.com>,
        linux-kernel@vger.kernel.org
Subject: Re: Problems using new Linux-2.4 bitkeeper repository.
Message-ID: <20020318152512.GE3762@opus.bloom.county>
In-Reply-To: <20020316083059.A10086@work.bitmover.com> <3C9375B7.3070808@mandrakesoft.com> <20020316085213.B10086@work.bitmover.com> <3C937B82.60500@mandrakesoft.com> <20020316091452.E10086@work.bitmover.com> <3C938027.4040805@mandrakesoft.com> <30393.1016362174@redhat.com> <20020317075443.A15420@work.bitmover.com> <16049.1016382201@redhat.com> <23384.1016390069@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 17, 2002 at 06:34:29PM +0000, David Woodhouse wrote:
> 
> lm@bitmover.com said:
> >  Then you get to save them as diffs, unedit the files, and put them
> > back  after the merge. 
> 
> I can do better than that. If I save them as diffs, I don't get to use your 
> cute merge tools. I could commit them with a throwaway changelog, do the 
> pull and use the merge tools, then copy the resulting files, undo both the 
> pull and the previous merge, do the pull again and then lock the files and 
> drop the previously-saved copies into place.

Well, what we're doing in PPC-land is we've got one tree, 'linuxppc-2.5'
which is linux-2.5 + for-linus-ppc* trees + hacks/fixes for current
problems.  So when we do any work you make a clone of a linux-2.5 tree
to work in, a clone of the linuxppc-2.5 tree (to pull your work tree
into and then test).  Once things are good in the linux-2.5-work tree,
you pull that into a for-linus tree and tell linus to merge that. 

-- 
Tom Rini (TR1265)
http://gate.crashing.org/~trini/
