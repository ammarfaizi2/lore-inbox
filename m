Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310783AbSCTABq>; Tue, 19 Mar 2002 19:01:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310924AbSCTABh>; Tue, 19 Mar 2002 19:01:37 -0500
Received: from arsenal.visi.net ([206.246.194.60]:15016 "EHLO visi.net")
	by vger.kernel.org with ESMTP id <S310920AbSCTABa>;
	Tue, 19 Mar 2002 19:01:30 -0500
X-Virus-Scanner: McAfee Virus Engine
Date: Tue, 19 Mar 2002 18:56:47 -0500
From: Ben Collins <bcollins@debian.org>
To: Larry McVoy <lm@work.bitmover.com>, "David S. Miller" <davem@redhat.com>,
        lm@bitmover.com, pavel@suse.cz, davej@suse.de,
        linux-kernel@vger.kernel.org
Subject: Re: Bitkeeper licence issues
Message-ID: <20020319235647.GD20722@blimpo.internal.net>
In-Reply-To: <20020319002241.K17410@suse.de> <20020319220631.GA1758@elf.ucw.cz> <20020319152502.J14877@work.bitmover.com> <20020319.152759.06816290.davem@redhat.com> <20020319154436.N14877@work.bitmover.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 19, 2002 at 03:44:36PM -0800, Larry McVoy wrote:
> On Tue, Mar 19, 2002 at 03:27:59PM -0800, David S. Miller wrote:
> >    From: Larry McVoy <lm@bitmover.com>
> >    Date: Tue, 19 Mar 2002 15:25:02 -0800
> > 
> >    Come on Pavel, in order to make this happen, you have to
> >    
> >    	a) run the installer as root
> >    	b) know the next pid which will be allocated
> >    	c) put the symlink in /tmp/installer$pid
> >    
> > Exploit: Make all 65535 $pid simlinks
> > 
> > It's very exploitable actually, and is similar in vein to
> > all the ancient mktemp stuff.
> 
> Hey Dave, are you suggesting that no such exploits exist in Red Hat's 
> rpm system?  In order for that to be true, rpm would have to be making
> sure that each and every directory along any path that it writes is
> not writable except by priviledged users.  I just checked, it doesn't.

That's because the admin would have had to change those perms on
purpose, which means they left themselves open to the attack.

Larry, check bugtraq archives. You'll see mounds of these types of
exploitable problems. All of them very serious.

> At some point, people get to take responsibility for their own choices.

Then just admit it was a bad thing and leave it be? :) Come on, it was a
mistake, and a very common one. Just don't make it out to be less than
what it is.

-- 
 .----------=======-=-======-=========-----------=====------------=-=-----.
/       Ben Collins    --    Debian GNU/Linux    --    WatchGuard.com      \
`          bcollins@debian.org   --   Ben.Collins@watchguard.com           '
 `---=========------=======-------------=-=-----=-===-======-------=--=---'
