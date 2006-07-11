Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750843AbWGKORD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750843AbWGKORD (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jul 2006 10:17:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750835AbWGKOQy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jul 2006 10:16:54 -0400
Received: from host36-195-149-62.serverdedicati.aruba.it ([62.149.195.36]:65187
	"EHLO mx.cpushare.com") by vger.kernel.org with ESMTP
	id S1750826AbWGKOQf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jul 2006 10:16:35 -0400
Date: Tue, 11 Jul 2006 16:17:09 +0200
From: andrea@cpushare.com
To: Ingo Molnar <mingo@elte.hu>
Cc: Adrian Bunk <bunk@stusta.de>, Andrew Morton <akpm@osdl.org>,
       Lee Revell <rlrevell@joe-job.com>, linux-kernel@vger.kernel.org,
       Alan Cox <alan@redhat.com>, Linus Torvalds <torvalds@osdl.org>
Subject: Re: [patch] let CONFIG_SECCOMP default to n
Message-ID: <20060711141709.GE7192@opteron.random>
References: <20060629192121.GC19712@stusta.de> <1151628246.22380.58.camel@mindpipe> <20060629180706.64a58f95.akpm@osdl.org> <20060630014050.GI19712@stusta.de> <20060630045228.GA14677@opteron.random> <20060630094753.GA14603@elte.hu> <20060630145825.GA10667@opteron.random> <20060711073625.GA4722@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060711073625.GA4722@elte.hu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 11, 2006 at 09:36:25AM +0200, Ingo Molnar wrote:
> 
> * andrea@cpushare.com <andrea@cpushare.com> wrote:
> 
> > On Fri, Jun 30, 2006 at 11:47:53AM +0200, Ingo Molnar wrote:
> > > and both are pledged and available to GPL users. [..]
> > 
> > If the GPL offered any protection to my system software I would 
> > consider it too, but the GPL can't protect software that runs behind 
> > the corporate firewall. [...]
> 
> so you admit and confirm that you explicitly and intentionally do not 
> pledge your patent to GPL users. [..]

How many times do I need to say it. The pending patent has nothing to do
with the kernel, and it is _not_ pledged under the GPL.

The software world is moving from proprietary software that runs on top
of end user computers, to proprietary software that runs behind the
firewall. And the GPL is getting old and not capable to cope with the
second kind of usage of the software. This is being discussed in gplv3
context.

This isn't too bad, because as long as the software you run is open
source, you're guaranteed to be in control of what runs on your
computer, in control of your privacy, and in control of your security.
So it's a better model, you pratically run the proprietary software on
the server through the firefox open source client stack, but but the
general forced-contribution-mode that the GPL allows, tends to weaken
signficantly when software is only meant to run behind the firewall of
large corporations that don't depend on external companies for their own
software support.

I've no magic solution for this, I'm not a lawyer so I've no idea if
anything more than the GPL would be enforceable under US law in the
first place (until recently it wasn't even 100% sure that the GPL was
enforceable), so I certainly can't help on this side.

> [..] That is troubling (and unethical) in my 

You should talk about ethics to the people that written the law,
certainly not with me. I've to comply with the law and with the rules of
economy. It's not my fault the fact that if I don't file patents I risk
troubles ahead. I'm against patents too and it wasn't fun to pay for the
legal costs of the filing. I seem to recall that transmeta also filed a
software patent over the CMS but it seems people had not many problems
to work for them (you once sent emails @transmeta.com too). Transmeta
perhaps was the smallest player, there are many more bigger examples
that I won't be making.

Furthermore I obtained no patents yet, it could be the way I written the
text is wrong or whatever, I'm not the most expert in terms of patents,
I did my best just to be sure I couldn't regret having done a fatal
and obvious mistake later and it seems everything is going fine, but
doing my best is definitely no guarantee of success. So it could be all
this will be void if I've bad luck and they reject my application.

> opinion and strengthens my argument that this feature should be _at a 
> minimum_ be made default-off, just like hundreds of other kernel 
> features are.

See the below email of yours.

Also note, seccomp is the basic mode, at some point trusted
computing will be supported by xen so then I'll have a compelling reason
to switch the client side from seccomp to xen. But even then I'll be
always supporting seccomp for a long time because it's the most solid
and simplest mode of all.

> I'm also wondering what the upstream decision would have been, had you 
> disclosed this patent licensing intention of yours. (to use the GPL-ed 

Talking about patents when submitting seccomp, would be like talking
about mp3 patents when submitting alsa code or talking about google
server side patents when submitting a new tcp/ip feature that could
allow google render html faster. This whole discussion is officially
offtopic and it's a pure waste of bandwidth(tm), believe it or not.

All grid computing providers out there are welcome to start using
seccomp today to make their clients more secure against possible
software bugs in the remote computed bytecode. I welcome boinc to start
using seccomp too, I welcome worldcommunitygrid to use seccomp on the
linux client, I welcome all OS vendors to add seccomp to their OS, I
even tried to contact apple since it should be easy to port seccomp to
their kernels.

As far as cpushare is concerned, I never had anything to hide. The legal
part of the website is there since day zero I think.

> Linux kernel as a vehicle for your 'invention', while not fully living 
> up to the basic quid-pro-quo.).

If you prefer I can move all patent pending code on top of windows,
though I believe the "powered by" ads on my site were nice ads for free
software and open source (and obviously I'm very proud to be using them
like I'm very proud to be able to contribute to free software as well).
If you check the user agreement I even stated that any income generated
by cpucoins transactions started by cpushare will be donated to the
development of open source software.

> So i'd like to request the patch below to be included in v2.6.18.

Here the email that now you're forcing me to remind you:

http://www.cpushare.com/hypermail/cpushare-discuss/06/01/0080.html

	"ok, i agree with you here - having it on by default does make
	sense from an API uniformity POV."

I didn't feel the need of mentioning this opinion of yours before as
backing for my arguments pro Y, because I thought you were agreeing with
my previous post and that my arguments alone were enough, but since you
changed your mind again...

Note that I don't think Y or N makes any difference at the end for my
project. But fedora could set it to N under your advice and that would
do more damage to my project than whatever default setting we have
in-kernel. So if you want to hurt my project, you should ask Dave to
turn off seccomp instead of asking Linus to turn off it in the kernel
source.

Even more significant is that fact that it turns out 90% of the
interested userbase seems windows based, so for 90% of users it won't
matter if seccomp is even in the kernel.

Even if you seem to believe I don't care about the kernel when I talk
about seccomp, I really think Y is the right setting for the kernel, and
I'm not speaking for my own personal usages of seccomp, for the reason
why you also agreed with it in the above email a few months ago.

But like I said in previous emails, if these discussion about Y or N
have to keep going, then feel free to apply Ingo patch to make him
happy. I'm happy either ways even but I think Y is the appropriate
setting like with EPOLL and friends, now that all overhead triggered by
the purely paranoid additional feature has been removed by default.

config EPOLL
        bool "Enable eventpoll support" if EMBEDDED
        default y
