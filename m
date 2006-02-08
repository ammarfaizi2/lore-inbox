Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161006AbWBHG6n@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161006AbWBHG6n (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Feb 2006 01:58:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161008AbWBHG6n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Feb 2006 01:58:43 -0500
Received: from ogre.sisk.pl ([217.79.144.158]:14010 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S1161006AbWBHG6m (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Feb 2006 01:58:42 -0500
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Nigel Cunningham <nigel@suspend2.net>
Subject: Re: Which is simpler? (Was Re: [Suspend2-devel] Re: [ 00/10] [Suspend2] Modules support.)
Date: Wed, 8 Feb 2006 07:59:49 +0100
User-Agent: KMail/1.9.1
Cc: Pavel Machek <pavel@ucw.cz>, Lee Revell <rlrevell@joe-job.com>,
       Jim Crilly <jim@why.dont.jablowme.net>,
       suspend2-devel@lists.suspend2.net, linux-kernel@vger.kernel.org
References: <20060201113710.6320.68289.stgit@localhost.localdomain> <20060207230245.GD2753@elf.ucw.cz> <200602080911.08090.nigel@suspend2.net>
In-Reply-To: <200602080911.08090.nigel@suspend2.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200602080759.50579.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wednesday 08 February 2006 00:11, Nigel Cunningham wrote:
> On Wednesday 08 February 2006 09:02, Pavel Machek wrote:
> > > > > Personally I agree with you on suspend2, I think this is something that
> > > > > needed to Just Work yesterday, and every day it doesn't work we are
> > > > > losing users... but who am I to talk, I'm not the one who will have to
> > > > > maintain it.
> > > > 
> > > > It does just work in mainline now. If it does not please open bug
> > > > account at bugzilla.kernel.org.
> > > > 
> > > > If mainline swsusp is too slow for you, install uswsusp. If it is
> > > > still too slow for you, mail me a patch adding LZW to userland code
> > > > (should be easy).
> > > 
> > > <horrified rebuke>
> > > 
> > > Pavel!
> > > 
> > > Responses like this are precisely why you're not the most popular kernel 
> > > maintainer. Telling people to use beta (alpha?) code or fix it
> > 
> > I do not *want* to be the most popular maintainer. That is your place ;-).
> > 
> > > themselves 
> > > (and then have their patches rejected by you) is no way to maintain a part 
> > > of the kernel. Stop being a liability instead of an asset!
> > 
> > Ugh?
> > 
> > Lee is a programmer. He wants faster swsusp, and improving uswsusp is
> > currently best way to get that. It may be alpha/beta quality, but
> > someone has to start testing, and Lee should be good for that (played
> > with realtime kernels etc...). Actually it is in good enough state
> > that I'd like non-programmers to test it, too.
> 
> Ok. So Lee might be ok to test uswsusp. But this is your approach
> regardless of who is emailing you. You consistently tell people to fix
> problems themselves and send you a patch. That's not what a maintainer
> should do. They're supposed to maintain, not get other people to do the
> work. They're supposed to be helpful, not a source of anxiety. You might be
> the maintainer of swsusp in name, but you're not in practice. Please, lift
> your game!

I strongly disagree with this opinion.  I don't think there's any problem with
Pavel, at least I haven't had any problems in communicating with him.
Moreover, I don't think the role of maintainer must be to actually write the
code.  From my point of view Pavel is in the right place, because I need
someone to tell me if I'm going to do something stupid who knows the kernel
better than I do.

Furthermore, in many cases this is not Pavel who opposes your patches.
As we speak there is a discussion on linux-pm regarding a patch that you
have submitted and I'm sure you are following it.  Please note that Pavel
hasn't spoken yet, but the patch has already been opposed by at least
two people.  Is _this_ a Pavel's fault?  No, it isn't.

Greetings,
Rafael
