Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932442AbWAFBuu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932442AbWAFBuu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jan 2006 20:50:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932163AbWAFBuu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jan 2006 20:50:50 -0500
Received: from kepler.fjfi.cvut.cz ([147.32.6.11]:1509 "EHLO
	kepler.fjfi.cvut.cz") by vger.kernel.org with ESMTP
	id S1751097AbWAFBut (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jan 2006 20:50:49 -0500
Date: Fri, 6 Jan 2006 02:49:42 +0100 (CET)
From: Martin Drab <drab@kepler.fjfi.cvut.cz>
To: Marcin Dalecki <martin@dalecki.de>
cc: Lee Revell <rlrevell@joe-job.com>, Hannu Savolainen <hannu@opensound.com>,
       Takashi Iwai <tiwai@suse.de>, linux-sound@vger.kernel.org,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: [OT] ALSA userspace API complexity
In-Reply-To: <942EC96F-580B-4F4C-B019-F38D4964942C@dalecki.de>
Message-ID: <Pine.LNX.4.60.0601060201200.31782@kepler.fjfi.cvut.cz>
References: <20050726150837.GT3160@stusta.de> <20060103193736.GG3831@stusta.de>
 <Pine.BSO.4.63.0601032210380.29027@rudy.mif.pg.gda.pl>
 <mailman.1136368805.14661.linux-kernel2news@redhat.com>
 <20060104030034.6b780485.zaitcev@redhat.com> <Pine.LNX.4.61.0601041220450.9321@tm8103.perex-int.cz>
 <Pine.BSO.4.63.0601051253550.17086@rudy.mif.pg.gda.pl>
 <Pine.LNX.4.61.0601051305240.10350@tm8103.perex-int.cz>
 <Pine.BSO.4.63.0601051345100.17086@rudy.mif.pg.gda.pl> <s5hmziaird8.wl%tiwai@suse.de>
 <Pine.LNX.4.61.0601060028310.27932@zeus.compusonic.fi> <1136504460.847.91.camel@mindpipe>
 <4A284096-E889-4E6D-B017-B8241CD72A0D@dalecki.de>
 <Pine.LNX.4.60.0601060122290.31782@kepler.fjfi.cvut.cz>
 <942EC96F-580B-4F4C-B019-F38D4964942C@dalecki.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 6 Jan 2006, Marcin Dalecki wrote:
> On 2006-01-06, at 01:29, Martin Drab wrote:
> 
> > Because as much as we all don't like it, it is
> > a realistic fact. There's just NO WAY you can responsibly say about any
> > piece software, that it is completely error free.
> 
> You would be for example surprised to see how complex the software controlling
> the breaks
> of a reasonable modern car turns out to be... This is just a technical example

No doubts it is.

> running contrary
> to your "wisdom". In numerical computations you can find reasonable amounts of
> software
> which is precisely just that - bug free. There are mathematical proofs running
> for hundreds of pages,
> which are just valid.

Yes, I know. That, however, still doesn't necesarilly mean that it has to 
be completely error free. (An error must not necessarily mean a complete 
screw-up.)

> Do you think this kind of guys doesn't ever sit down and
> write
> some piece of software to help out well for example in determining some
> aerodynamics of a plane?

I know they do. Again, it doesn't mean that that software has to be 
completely error free.

> Are you assuming this kind of applications is trivial and by virtue of a
> natural law bug ridden?

Well, I'm moving in an environment of nuclear energy, physics, and 
mathematical modelling a bit for quite some while. And I know, that you 
can never be absolutely certain that any (reasonably complex) software is 
completely error free.

Apart from that, that in those really critical cases (such as a primary 
controlling system of a nuclear reactor), you are actually forced to just 
a strict subset of a strictly defined programming languages, it is just 
that, that forces you to have tons of various sophisticated checking and 
safety mechanisms implemented in the software to prevent any possible bugs 
to do any serious harm, which in this case can no doubt be very terminal.
Overconfidence in these cases is not in place, even though these really 
are the ones that are really thotoughly checked for bugs.

> And by the way: the zero program which has nothing to do is bug free. QED.

Ah, OK, you got me on that one. :) But that's not quite what I had in 
mind.

Anyway, I guess we're quite by far OT with this. So I think we should just 
leave it at that, and let everybody draw their own conclusions to their 
own best knowledge. Sorry for bothering with this.

Martin
