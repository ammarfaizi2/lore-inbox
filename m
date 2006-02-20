Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161020AbWBTQeP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161020AbWBTQeP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Feb 2006 11:34:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161017AbWBTQcz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Feb 2006 11:32:55 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:64396 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1161015AbWBTQcY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Feb 2006 11:32:24 -0500
Date: Mon, 20 Feb 2006 14:01:25 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Sebastian =?iso-8859-1?Q?K=FCgler?= <sebas@kde.org>
Cc: Matthias Hensler <matthias@wspse.de>,
       kernel list <linux-kernel@vger.kernel.org>, nigel@suspend2.net,
       rjw@sisk.pl, suspend2-devel@lists.suspend2.net
Subject: Re: Which is simpler? (Was Re: [Suspend2-devel] Re: [ 00/10] [Suspend2] Modules support.)
Message-ID: <20060220130125.GA17627@elf.ucw.cz>
References: <20060201113710.6320.68289.stgit@localhost.localdomain> <20060218142610.GT3490@openzaurus.ucw.cz> <20060220093911.GB19293@kobayashi-maru.wspse.de> <200602201105.35378.sebas@kde.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <200602201105.35378.sebas@kde.org>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Po 20-02-06 11:05:34, Sebastian Kügler wrote:
> On Monday 20 February 2006 10:39, Matthias Hensler wrote:
> > > > The only con I see is the complexity of the code, but then again,
> > > > Nigel
> > >
> > > ..but thats a big con.
> >
> > So why is that? From what I see, most of the code is completly independ
> > of the rest of the kernel, and just does not affect if it is disabled.
> >
> > It won't do any harm to the kernel, and again, Nigel is constantly
> > improving that situation, so for sure, that is no _big_ con.
> 
> I might add that you'd drag a devoted developer into the kernel team more 
> closely, which probably makes up for the 'added complexity' anyway.

I'd love to have Nigel helping me and kernel, but he's not
interested. He wants suspend2 merged, he does not want better suspend
in kernel.

> The gain in working *together* on suspend2 is worth much more than the 'added 
> complexity' Pavel complains about. Nigel has stated more than once that he'd 
> be happy to maintain suspend2, and he's done so for quite some time already, 
> which proves his point. Nigel is paid to work on suspend2, so it's not likely 
> to go away once he has a new hobby (and again, he's been doing great work for 
> some time already). 

I do not think he's paid for suspend2 any more.

> So what about working on merging suspend2 finally? Having a proven, stable and 
> feature-rich implemenation available quickly, *and* someone who maintains 
> *and* support it actively does not sound like a bad deal to me.

Nigel is not really maintaining it. He's willing to solve small
problems, but not the big ones.

> One should not underestimate the gains that a suspend2 merge has on the 
> development merely by stating 'added complexity', that pays off _any_day_.
> 
> By the way, does 'working on uswsusp' mean that Pavel and will put less work 
> in maintaining swsusp? That does not sound too promising to my sore ears.

uswsusp and swsusp share most of the important code (go take a
look). No, in-kernel swap writing is not going to be improved too
much, just the bugs fixed. That means very stable swsusp in kernel...

> Personally, to work with, I'd prefer a developer who's responsibly dealing 
> with users' questions and problems any day to one who rejects 99% of emails 
> that don't contain a patch and 95% of those that contain one, stating 'WTF, I 
> don't like that'.

Fine, feel free to help with answering users mails.
									Pavel
-- 
Web maintainer for suspend.sf.net (www.sf.net/projects/suspend) wanted...
