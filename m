Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310548AbSCSXZ0>; Tue, 19 Mar 2002 18:25:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310654AbSCSXZF>; Tue, 19 Mar 2002 18:25:05 -0500
Received: from bitmover.com ([192.132.92.2]:20196 "EHLO bitmover.com")
	by vger.kernel.org with ESMTP id <S310548AbSCSXZE>;
	Tue, 19 Mar 2002 18:25:04 -0500
Date: Tue, 19 Mar 2002 15:25:02 -0800
From: Larry McVoy <lm@bitmover.com>
To: Pavel Machek <pavel@suse.cz>
Cc: Dave Jones <davej@suse.de>, kernel list <linux-kernel@vger.kernel.org>
Subject: Re: Bitkeeper licence issues
Message-ID: <20020319152502.J14877@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	Pavel Machek <pavel@suse.cz>, Dave Jones <davej@suse.de>,
	kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <20020318212617.GA498@elf.ucw.cz> <20020318144255.Y10086@work.bitmover.com> <20020318231427.GF1740@atrey.karlin.mff.cuni.cz> <20020319002241.K17410@suse.de> <20020319220631.GA1758@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 19, 2002 at 11:06:32PM +0100, Pavel Machek wrote:
> >  > > Pavel, the problem here is your fundamental distrust.  
> >  > By giving me binary-only installer you ask me to trust you. You ask me
> >  > to trust you without good reason [it only generates .tar.gz and
> >  > shellscript, why should it be binary? Was not shar designed to handle
> >  > that?], and that's pretty suspect.
> > 
> >  Bitmover doing anything remotely suspect in an executable installer
> >  would be commercial suicide, do you distrust realplayer too?
> 
> Actually, the installer contains security hole allowing any user to
> overwrite any file on system if you install it as root with simple
> symlink. 

Come on Pavel, in order to make this happen, you have to

	a) run the installer as root
	b) know the next pid which will be allocated
	c) put the symlink in /tmp/installer$pid

and do all before that pid gets used.  Have you actually be able to
do that?  I'd like to see how you did so without knowing exactly when
root was going to install the package and without filling up /tmp with
64,000 symlinks.

I'll grant you this is something we can trivially make go away as an 
issue, and we have, but it's mostly to make you go away as an issue,
not because we believe for one second this is a realistic problem.
-- 
---
Larry McVoy            	 lm at bitmover.com           http://www.bitmover.com/lm 
