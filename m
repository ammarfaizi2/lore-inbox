Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310740AbSCSXhF>; Tue, 19 Mar 2002 18:37:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310769AbSCSXg4>; Tue, 19 Mar 2002 18:36:56 -0500
Received: from cpe-24-221-152-185.az.sprintbbd.net ([24.221.152.185]:41607
	"EHLO opus.bloom.county") by vger.kernel.org with ESMTP
	id <S310740AbSCSXgl>; Tue, 19 Mar 2002 18:36:41 -0500
Date: Tue, 19 Mar 2002 16:34:32 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Larry McVoy <lm@work.bitmover.com>, Pavel Machek <pavel@suse.cz>,
        Dave Jones <davej@suse.de>, kernel list <linux-kernel@vger.kernel.org>
Subject: Re: Bitkeeper licence issues
Message-ID: <20020319233432.GS3762@opus.bloom.county>
In-Reply-To: <20020318212617.GA498@elf.ucw.cz> <20020318144255.Y10086@work.bitmover.com> <20020318231427.GF1740@atrey.karlin.mff.cuni.cz> <20020319002241.K17410@suse.de> <20020319220631.GA1758@elf.ucw.cz> <20020319152502.J14877@work.bitmover.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 19, 2002 at 03:25:02PM -0800, Larry McVoy wrote:
> On Tue, Mar 19, 2002 at 11:06:32PM +0100, Pavel Machek wrote:
> > >  > > Pavel, the problem here is your fundamental distrust.  
> > >  > By giving me binary-only installer you ask me to trust you. You ask me
> > >  > to trust you without good reason [it only generates .tar.gz and
> > >  > shellscript, why should it be binary? Was not shar designed to handle
> > >  > that?], and that's pretty suspect.
> > > 
> > >  Bitmover doing anything remotely suspect in an executable installer
> > >  would be commercial suicide, do you distrust realplayer too?
> > 
> > Actually, the installer contains security hole allowing any user to
> > overwrite any file on system if you install it as root with simple
> > symlink. 
> 
> Come on Pavel, in order to make this happen, you have to
> 
> 	a) run the installer as root
> 	b) know the next pid which will be allocated
> 	c) put the symlink in /tmp/installer$pid

I hate to jump in here (really I do) but 'a' probably happens alot.  All
of the recommended locations are system directories.  As for 'b' and
'c', I think those are considered trivial things to do, since this would
be a relativly easy thing to expliot (search some of the security list
archives, this isn't quite as easy as the buffer overflow on x86
problem, but still trivial).

> I'll grant you this is something we can trivially make go away as an 
> issue, and we have, but it's mostly to make you go away as an issue,
> not because we believe for one second this is a realistic problem.

But yes, this is a trivial problem which is now fixed.  And in the grand
scheme of things, there'll be more important fixes in the next version
of BK than the possibility of overwriting files at installtime.

-- 
Tom Rini (TR1265)
http://gate.crashing.org/~trini/
