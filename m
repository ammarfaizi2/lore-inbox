Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261687AbTCPAdg>; Sat, 15 Mar 2003 19:33:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261698AbTCPAdg>; Sat, 15 Mar 2003 19:33:36 -0500
Received: from x35.xmailserver.org ([208.129.208.51]:58497 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP
	id <S261687AbTCPAde>; Sat, 15 Mar 2003 19:33:34 -0500
X-AuthUser: davidel@xmailserver.org
Date: Sat, 15 Mar 2003 16:53:59 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@blue1.dev.mcafeelabs.com
To: Petr Baudis <pasky@ucw.cz>
cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: BitBucket: GPL-ed KitBeeper clone
In-Reply-To: <20030316001840.GB11761@pasky.ji.cz>
Message-ID: <Pine.LNX.4.50.0303151649200.1884-100000@blue1.dev.mcafeelabs.com>
References: <200303151621.h2FGLgaD003246@eeyore.valparaiso.cl>
 <20030315212205.CDE923D979@mx01.nexgo.de> <1047765218.9619.124.camel@lan1>
 <20030316001840.GB11761@pasky.ji.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 16 Mar 2003, Petr Baudis wrote:

> I'm not sure if arch is the right thing to base on. Its concepts are surely
> interesting, however there are several problems (some of them may be
> subjective):
>
> * Terrible interface. Work with arch involves much more typing out of long
> commands (and sequences of these), subcommands and parameters to get
> functionality equivalent to the one provided much simpler by other SCMs. I see
> it is in sake of genericity and sometimes more sophisticated usage scheme, but
> I fear it can be PITA in practice for daily work.
>
> * Awful revision names (just unique ids format). Again, it involves much more
> typing and after some hours of work, the dashes will start to dance around and
> regroup at random places in front of your eyes. The concepts behind (like
> seamless division to multiple archives; I can't say I see sense in categories)
> are intriguing, but the result again doesn't seem very practical.
>
> * Evil directory naming. {arch} seems much more visible than CVS/ and SCCS/,
> particularly as it gets sorted as last in a directory, thus you see it at the
> bottom of ls output. Also it's a PITA with bash, as the stuff starting by '='
> (arch likes to spawn that as well) is. The files starting by '+' are problem
> for vi, which is kind of flaw when they are probably the only arch files
> dedicated for editting by user (they are supposed to contain log messages).
>
> * Cloud of shell scripts. It poses a lot of limitations which are pain to work
> around (including speed, two-fields version numbers [eek] and I can imagine
> several others; I'm not sure about these though, so I won't name further; you
> can possibly imagine something by yourself).
>
> * Absence of sufficient merging ability, at least impression I got from the
> documentation. Merging on the *.rej files level I cannot call sufficient ;-).
> Also, history is not preserved during merging, which is quite fatal.  And it
> looks to me at least from the documentation that arch is still in the
> update-before-commit stage.
>
> * Absence of checkin/commit distinction. File revisions and changesets seem to
> be tied together, losing some of the cute flexibility BK has.
>
> I must have missed terribly something in the documentation given how arch is
> being recommended, please feel encouraged to correct me. But as I see it, most

I must have missed too. Last time I checked I had the same impression. A
bunch of shell scripts ( speed and portability goodbye ) and even
diff&patch were ran as external programs. Maybe it has the right concepts
but the architecture is *at least* weak. Subversion looked ( last time I
checked ) a better organized project, with *real* source code. Ok, it has
*insane* symbol names, but IMHO it's way better than the shell script
cloud.




- Davide

