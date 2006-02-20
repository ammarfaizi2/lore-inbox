Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161109AbWBTUIm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161109AbWBTUIm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Feb 2006 15:08:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161116AbWBTUIm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Feb 2006 15:08:42 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:27321 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1161109AbWBTUIm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Feb 2006 15:08:42 -0500
Date: Mon, 20 Feb 2006 21:08:07 +0100
From: Pavel Machek <pavel@ucw.cz>
To: "Theodore Ts'o" <tytso@mit.edu>, Sebastian K?gler <sebas@kde.org>,
       nigel@suspend2.net, Matthias Hensler <matthias@wspse.de>, rjw@sisk.pl,
       kernel list <linux-kernel@vger.kernel.org>,
       suspend2-devel@lists.suspend2.net
Subject: Re: Which is simpler? (Was Re: [Suspend2-devel] Re: [ 00/10] [Suspend2] Modules support.)
Message-ID: <20060220200807.GB21557@elf.ucw.cz>
References: <20060201113710.6320.68289.stgit@localhost.localdomain> <20060218142610.GT3490@openzaurus.ucw.cz> <20060220093911.GB19293@kobayashi-maru.wspse.de> <200602201105.35378.sebas@kde.org> <20060220130125.GA17627@elf.ucw.cz> <20060220191242.GB8512@osgiliath.brixandersen.dk> <20060220195155.GB7444@thunk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060220195155.GB7444@thunk.org>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Po 20-02-06 14:51:55, Theodore Ts'o wrote:
> On Mon, Feb 20, 2006 at 08:12:42PM +0100, Henrik Brix Andersen wrote:
> > > I'd love to have Nigel helping me and kernel, but he's not
> > > interested. He wants suspend2 merged, he does not want better suspend
> > > in kernel.
> > 
> > If you made comments like that about me on a public mailing list I
> > would feel it would be very difficult trying to cooperate with you.
> > 
> > Please reconsider your public replies regarding this already delicate
> > issue a bit more before you criticize people who has spent a great
> > deal of time trying to get a working solution.
> 
> I'm going to have to second Henrik here.  Pavel, there are times when
> you are starting to sound almost as strident as our cdrecord
> "friend".

Heh, I hope I'm not that bad.

> Maybe you feel you are in a power position because your code happened
> to enter the kernel first, so you few you can have veto power over all
> other contenders.  It sometimes works that way, but only up to a

Unfortunately, I do not need to veto suspend2. It is so complex that
it vetoes itself. Last time akpm stopped it, IIRC.

You are welcome to take a look at those patches and try to get them
into suitable form. But please don't compare me with Joerg unless you
seen the patches.

> point.  The fact of the matter is, Nigel code's *works* and swsusp has
> been at best slow and painful and unreliable.  And while your been

Painful and unreliable? Yep, it slow, at least it does not make rest
of kernel slower. We are adressing "slow" with uswsusp...
								Pavel
-- 
Web maintainer for suspend.sf.net (www.sf.net/projects/suspend) wanted...
