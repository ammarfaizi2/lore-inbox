Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281147AbRKOW7C>; Thu, 15 Nov 2001 17:59:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281153AbRKOW6w>; Thu, 15 Nov 2001 17:58:52 -0500
Received: from ppp01.ts1-1.NewportNews.visi.net ([209.8.196.1]:35068 "EHLO
	blimpo.internal.net") by vger.kernel.org with ESMTP
	id <S281147AbRKOW6n>; Thu, 15 Nov 2001 17:58:43 -0500
Date: Thu, 15 Nov 2001 17:58:33 -0500
From: Ben Collins <bcollins@debian.org>
To: Andrew Morton <akpm@zip.com.au>, linux-kernel@vger.kernel.org
Subject: Re: Bug in ext3
Message-ID: <20011115175833.K329@visi.net>
In-Reply-To: <20011115092452.Z329@visi.net> <3BF3F9ED.17D55B35@zip.com.au>, <3BF3F9ED.17D55B35@zip.com.au> <20011115153442.A329@visi.net> <3BF42A1A.5AE96A78@zip.com.au> <20011115160232.H329@visi.net> <20011115145803.R5739@lynx.no> <20011115170628.J329@visi.net> <20011115144904.C23386@mikef-linux.matchmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20011115144904.C23386@mikef-linux.matchmail.com>
User-Agent: Mutt/1.3.23i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 15, 2001 at 02:49:04PM -0800, Mike Fedyk wrote:
> > > 
> > > Please run e2fsck (1.25) to clear this up.  It may be that you have other
> > > corruption in your filesystem.  If you are sure you _never_ tried ext3
> > > on this filesystem before, yet the has_journal bit is set, this could
> > > be an indication of memory or cable problems.
> > 
> > Uh, something corrupted it. Believe me, there is no other corruption.
> > I've reverted to a non-ext3 kernel, and after a day of serious IO, no
> > problems have shown. So something is wrong, and it isn't my filesystem
> > (the erroneous flag needs to be cleared, yes, but the fact remains that
> > there is a problem in this case).
> 
> Yes, true.
> 
> Can you try again with a journal in this FS with ext3?

Can't really do that. This is a production system. I will however try to
reproduce it on another system. If I can do that, I'll try your
suggestion.


Ben

-- 
 .----------=======-=-======-=========-----------=====------------=-=-----.
/                   Ben Collins    --    Debian GNU/Linux                  \
`  bcollins@debian.org  --  bcollins@openldap.org  --  bcollins@linux.com  '
 `---=========------=======-------------=-=-----=-===-======-------=--=---'
