Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262225AbVDLXKJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262225AbVDLXKJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Apr 2005 19:10:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262972AbVDLUe5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Apr 2005 16:34:57 -0400
Received: from smtp7.wanadoo.fr ([193.252.22.24]:16767 "EHLO smtp7.wanadoo.fr")
	by vger.kernel.org with ESMTP id S262551AbVDLSvH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Apr 2005 14:51:07 -0400
X-ME-UUID: 20050412185057663.A1E571C000A6@mwinf0709.wanadoo.fr
Date: Tue, 12 Apr 2005 20:45:45 +0200
To: Marco Colombo <marco@esi.it>
Cc: Sven Luther <sven.luther@wanadoo.fr>, linux-kernel@vger.kernel.org
Subject: Re: non-free firmware in kernel modules, aggregation and unclear copyright notice.
Message-ID: <20050412184545.GB18557@pegasos>
References: <1113235942.11475.547.camel@frodo.esi> <20050411162514.GA11404@pegasos> <1113252891.11475.620.camel@frodo.esi> <20050411210754.GA11759@pegasos> <Pine.LNX.4.61.0504120034490.27766@Megathlon.ESI> <20050412054002.GB22393@pegasos> <Pine.LNX.4.61.0504121458010.31686@Megathlon.ESI>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0504121458010.31686@Megathlon.ESI>
User-Agent: Mutt/1.5.6+20040907i
From: Sven Luther <sven.luther@wanadoo.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 12, 2005 at 06:14:17PM +0200, Marco Colombo wrote:
> No one will ever do that. If you are distributing the software I released
> under GPL, be sure I _will_ sue you if you break the licence. What do you
> want from me? A promise I won't sue you if you don't? That is implicit
> in the existance of the licence.
> 
> Are you implying debian will stop distributing _any_ software unless
> the all the copyright holders of GPL software "explicitly say" they
> won't sue you?

Well, we won't distribute binaries placed under the GPL, definitively not. And
if there is a dubious case, we ask for clarification of the author.

> >As an example, i package the unicorn driver for the bewan soft-ADSL pci and
> >usb modems. These being soft-ADSL modems which use a non-free binary-only 
> >ADSL
> >emulating library, but are otherwise GPL, i discussed the matter with
> >upstream, and after council from debian-legal, and possibly the FSF people
> >themselves, we got to use this as GPL exception :
> >
> > In addition, as a special exception, BeWAN systems gives permission
> > to link the code of this program with the modem SW library
> > (modem_ant_PCI.o, modem_ant_USB.o), and distribute linked combinations
> > including the two. You are also given permission to redistribute the
> > modem SW library (modem_ant_PCI.o, modem_ant_USB.o) with the rest of the
> > code.
> > You must obey the GNU General Public License in all respects for all of
> > the code used other than the modem SW library.
> 
> This is different. They are not giving the source at all. The licence
> for those object files _has_ to be different. _They_ want it to be
> different.

Sure, but in this case, the binary firmware blob is also a binary without
sources. If they really did write said firmware directly as it is, then they
should say so, but this is contrary to everyone's expectation, and a dangerous
precedent to set.

> >So, really, i doubt any manufacturer distributing non-free firmware would
> >really have trouble in adding to their licence something like this :
> >
> > In addition, <manufacturer>, considers the firmware blob, identified as 
> > <...>, as
> > a non-derivative piece of work, and thus not covered by the GPL of the 
> > rest
> > of it. <manufacturer> gives permission to distribute said firmware blob as
> > part of the linux kernel module driver for their hardware. The actual 
> > syntax
> > of the inclusion of the code is still covered by the GPL, as is the rest 
> > of
> > the driver code.
> 
> This is fine with me. It is the existance of legal threats versus 
> debian I don't agree upon.

Notice that debian can't afford to be sued even if they are right, so ...

> >>Yes, but it does not apply to our case here. There's no "all other
> >>copyright holders". _You_ stated that the firmware is included by mere
> >>aggregation, so there's no other holders involved. We're talking
> >>about the firmware case. A is one or two well identified subjects.
> >>And A wrote it is GPL'ed. Whether you agree or not, that's the licence
> >>A chose. A placed the copyright notice.
> >
> >This is where i would need legal counsel, as to whether this means C or
> >someone else may stop you from distributing unless you provide the source. 
> >And
> >the real problem is that A didn't state anything, so we are only working on
> >the assumption that this may be the case, and A can change its mind later, 
> >and
> >the costs to defend ourselves in front of a judge, even if your
> >interpretations are right, are enough prohibitive for debian not to 
> >distribute
> >said files.
> 
> A did put a GPL notice on it. He can't change his mind later.

Then he should give us the source.

> >>The licence is a matter between A and D. A may sue D and D may (less
> >>likely) sue A, if conditions are not met. I'm not sure at all GPL
> >>is enforceable by D upon A. Let's assume it is, for sake of discussion,
> >>anyway.
> >
> >Ah, but the licence is transitive, and if D may sue A, then C may also sue 
> >D,
> >since the GPL makes no distinction between who makes the distribution, 
> >apart
> >from the fact that A may relicence its code. But if he distributes it as 
> >part
> >of the GPL ...
> 
> Pardon me, I have no idea of what a "transitive" licence could be.
> Sublicencing or relicencing is _explicitly_ not covered by GPL anyway.

You give away the source to someone, he has the same rights you had, except
relicencing, this is what i meant by transitive.

> Also I have no idea of what you mean "GPL makes no distinction between
> who makes the distribution". GPL for sure places no restrictions on
> how A can distribute his software. A needs no license for exercising

No, it gives A the choice to distribute its software under the GPL, or under
another licence.

> rights on the software. He is the _owner_ of rights. A cannot "break"
> the GPL. A needs no GPL to distribute. Are you saying A may sue himself?

Yes, he can break the commonly accepted expectation of a GPLed software, which
is what happens here. He is free to distribute the software under any other
licence he sees fit, which is what i am asking here.

> >>>No. The source code is clearly the prefered form of modification, not 
> >>>some
> >>>random intermediate state A may be claiming is source.
> >>
> >>In this context, it is. Only A may sue D for not distributing the source.
> >>Whatever D distributes, D has to make A happy. If A is happy with D
> >>distributing `dd if=/dev/random count=1` as source, no one can stop D
> >>from doing that. Keep in mind A is the copyright holder. He grants
> >>rights to third parties. No one but A can remove them.
> >
> >Yep, so if A was giving us an explicit right to distribute his sources,
> >everyone would be happy, this not being the case, we have to take the
> >hypothesis that A will sue us at a later time.
> 
> A placed it under GPL. If that is not "explicit right to distribute his
> source", I'm not able to think of anything that could be it.

He is not distributing sources here, he is distributing binaries, my error.

> >The GPL says :
> >
> > If, as a consequence of a court judgment or allegation of patent
> > infringement or for any other reason (not limited to patent issues),
> > conditions are imposed on you (whether by court order, agreement or
> > otherwise) that contradict the conditions of this License, they do not
> > excuse you from the conditions of this License.  If you cannot
> > distribute so as to satisfy simultaneously your obligations under this
> > License and any other pertinent obligations, then as a consequence you
> > may not distribute the Program at all.
> >
> >The conditions of this licence are clear, the source code is the prefered 
> >form
> >of modification, so, if for "any other reason", you are not able to 
> >distribute
> >the source, then you "may not distribute the Program at all". The copyright
> >holder can, but there is no redistribution allowed. I will investigate 
> >about
> >if only A can sue over this though.
> 
> So you seriously think this makes sense?
> 
> A: you have to distribute the source, or the licence will be void
> D: i am, i'm distributing the source you gave me
> A: that is not the source, i was lying about it
> D: then give me the right source, and I'll distribute it
> A: No. I refuse to give you the right source, but expect you to distribute
>    it anyway, or i'll terminate the licence.

No, the licence auto-terminate and the software becomes undistributable.

> >he could claim, as some did here, that obviously the fimrware was not 
> >GPLed,
> >but mere aggregation, and that he nowhere gave any right to distribute 
> >them.
> 
> "mere aggregation" refers to an action taken by a distributor. _You_
> as debian are distributing the firmware as merely aggregated to the
> kernel, assuming your intrepretation is right. That has nothing to do
> with .c files.

The fact remains that those firmware blob have no licence, and thus defacto
fall under the GPL.

> Moreover, the firmare in not in binary form, but is part of a C source
> file.

It is in binary form. Disguised binary form maybe but still binary form.

> I think you're going no where. A cannot put a licence statement on
> the top of a .c file stating it's GPL'ed, and then say that some part
> of it is not covered because it was "merely aggregated". It makes no
> sense, and there's nothing in the GPL about mere aggregation of sources.

What i want is that A aknolwedges that he is not distributing the sources of
the firmware, and thus cannot place the binary blob under the GPL but should
chose another licence.

> >>>>That, in court? Is this really what you're afraid of?
> >>>>The outcome is, very likely A will be forced to release the full source.
> >>>>(and D forced to distribute it, but all D's we're talking of here are
> >>>>very happy with the full disclosure scenario, aren't they?)
> >>>
> >>>Imagine A refusing to give away the source code, and D is ordered to 
> >>>remove
> >>>the incriminated code it is illegally distributing from all its servers,
> >>>and
> >>>recall all those thousands of CD and DVD isos containing the code it
> >>>distributed, and being fined for each day it doesn't do so ?
> >>
> >>Sorry, this is nonsense. D is well willing to distribute the source.
> >>In this case, he _is_ distributing what A publicly stated to be the 
> >>source.
> >
> >Yep, apart from the fact that A never did publicly state such issue, but 
> >just
> >passed it under silence.
> 
> On the top of a .c file there's a nice copyright notice and licence 
> statement,
> isn't there? A placed it there. _You_ think it may be changed. But what
> if A is fine with it?

Not in the tg3.c case, no.

> >But the GPL states that we must be able to distribute the sources, clearly
> >defines what said sources are, and states what happens if you can't 
> >fullfill
> >a clause of the GPL -> no right to distribute at all.
> 
> No. GPL says you must be _willing_ to distribute the sources, as received
> by A. See, GPL covers the source. There's no way you can distribute
> the software in binary/executable form, unless you get the source and
> complile it. That's what you do here. You compile the hexstring, and
> the firmware (in binary form) gets "aggregated" to the kernel binary.
> If you distribute the result, you have to distribute the source _as
> you received it_. That's all. If you do, you're fine.

And where did those hexstrings come from ? 

Friendly,

Sven Luther

