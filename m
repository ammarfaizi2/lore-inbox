Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262082AbVBUU32@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262082AbVBUU32 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Feb 2005 15:29:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262089AbVBUU32
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Feb 2005 15:29:28 -0500
Received: from inti.inf.utfsm.cl ([200.1.21.155]:54409 "EHLO inti.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id S262082AbVBUU3X (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Feb 2005 15:29:23 -0500
Message-Id: <200502212027.j1LKRvUg007130@laptop11.inf.utfsm.cl>
To: zander@kde.org, Andrea Arcangeli <andrea@suse.de>, darcs-users@darcs.net,
       lm@bitmover.com, linux-kernel@vger.kernel.org
Subject: Re: [darcs-users] Re: [BK] upgrade will be needed 
In-reply-to: <20050221194557.GA23251@factotummedia.nl> 
References: <20050214020802.GA3047@bitmover.com> <200502172105.25677.pmcfarland@downeast.net> <421551F5.5090005@tupshin.com> <20050218090900.GA2071@opteron.random> <bc647aafb53842b58dd0279161fb48e0@spy.net> <buosm3q5v5y.fsf@mctpc71.ucom.lsi.nec.co.jp> <20050221155306.GU7247@opteron.random> <20050221194557.GA23251@factotummedia.nl>
Comments: In-reply-to zander@kde.org
   message dated "Mon, 21 Feb 2005 20:45:57 +0100."
X-Mailer: MH-E 7.4.2; nmh 1.1; XEmacs 21.4 (patch 17)
Date: Mon, 21 Feb 2005 17:27:57 -0300
From: Horst von Brand <vonbrand@inf.utfsm.cl>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-2.0b2 (inti.inf.utfsm.cl [200.1.19.1]); Mon, 21 Feb 2005 17:27:59 -0300 (CLST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

zander@kde.org said:
> On Mon, Feb 21, 2005 at 04:53:06PM +0100, Andrea Arcangeli wrote:

[...]

> > AFIK all other SCM except arch and darcs always modify the repo, I never
> > heard complains about it, as long as incremental backups are possible
> > and they definitely are possible.

> Well, as you seem to have never been bitten by that bug; let me assure you
> the problem is very real.  Each file (,v file) can live in the repo for
> many years and has to servive any spurious writes to be usable.  The
> curruption of such files (in my experience) only shows itself if you try
> to access its history; which may be weeks after the corruption started,
> and you can't use a backup for that since you will overwrite new versions
> added since.

Marking files read-only won't save you from corruption by NFS or the disk
or the kernel or... randomly scribbling around.
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
