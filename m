Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284176AbRLKWtt>; Tue, 11 Dec 2001 17:49:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284171AbRLKWtj>; Tue, 11 Dec 2001 17:49:39 -0500
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:17420 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S284178AbRLKWt3>; Tue, 11 Dec 2001 17:49:29 -0500
Date: Tue, 11 Dec 2001 17:42:43 -0500 (EST)
From: Bill Davidsen <davidsen@tmr.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Configure.help 2.4.17 update patch
In-Reply-To: <20011206003108.A3552@thyrsus.com>
Message-ID: <Pine.LNX.3.96.1011211173829.21150C-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 6 Dec 2001, Eric S. Raymond wrote:

> Steven Cole <elenstev@mesatop.com>:
> > I suggest that Marcelo go ahead and apply Eric's patch, with the two
> > meaningless rejects, and let the resulting Configure.help be the new
> > baseline for the 2.4.x series, and fork Configure.help for the 2.4.x
> > and 2.5.x series, since we have different sets of patches coming in
> > and it is just not practical (or reasonable) to try to fit the same
> > Configure.help file to both the stable and development series.
> 
> I specifically do *not* want to fork Configure.help.  
> 
> Reason: it's going to go away anyway when CML2 drops in, which (unless
> Linus has changed his mind) is scheduled for sometime in 2.5.1-xxx. At
> that point it will be functionally replaced by the contents of the
> master symbols.cml file, which will have been mechanically derived
> from it.

I hope that in the excitement of re-re-inventing the build process no one
has lost sight of the Configure.help file being very useful with the
database tools `more' and `grep.' Having to run a configure to get access
to that info is a step backwards.

It would be nice if the information gave a link between options and module
names as well, poking through Makefiles and source code to see how it's
done is educational, but a real waste of time.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

