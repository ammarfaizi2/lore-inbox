Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030184AbWGSPdP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030184AbWGSPdP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Jul 2006 11:33:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030189AbWGSPdP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Jul 2006 11:33:15 -0400
Received: from posthamster.phnxsoft.com ([195.227.45.4]:57872 "EHLO
	posthamster.phnxsoft.com") by vger.kernel.org with ESMTP
	id S1030184AbWGSPdO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Jul 2006 11:33:14 -0400
Message-ID: <44BE50A0.9070107@imap.cc>
Date: Wed, 19 Jul 2006 17:32:48 +0200
From: Tilman Schmidt <tilman@imap.cc>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; de-AT; rv:1.7.8) Gecko/20050511
X-Accept-Language: de, en, fr
MIME-Version: 1.0
To: Pekka Enberg <penberg@cs.helsinki.fi>
CC: linux-kernel@vger.kernel.org, Jan Engelhardt <jengelh@linux01.gwdg.de>,
       Matthias Andree <matthias.andree@gmx.de>,
       Grzegorz Kulewski <kangur@polcom.net>,
       Diego Calleja <diegocg@gmail.com>, arjan@infradead.org,
       caleb@calebgray.com
Subject: Re: Reiser4 Inclusion
References: <44BAFDB7.9050203@calebgray.com>	 <1153128374.3062.10.camel@laptopd505.fenrus.org>	 <Pine.LNX.4.63.0607171242350.10427@alpha.polcom.net>	 <20060717160618.013ea282.diegocg@gmail.com>	 <Pine.LNX.4.63.0607171611080.10427@alpha.polcom.net>	 <20060717155151.GD8276@merlin.emma.line.org>	 <Pine.LNX.4.61.0607180951480.16615@yvahk01.tjqt.qr>	 <20060718204718.GD18909@merlin.emma.line.org>	 <fake-message-id-1@fake-server.fake-domain> <84144f020607190403y1a659c99oc795ae244390c2ee@mail.gmail.com>
In-Reply-To: <84144f020607190403y1a659c99oc795ae244390c2ee@mail.gmail.com>
X-Enigmail-Version: 0.90.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pekka Enberg wrote:

> On 7/19/06, Tilman Schmidt <tilman@imap.cc> wrote:
>> You can't have it both ways. Either you want everything in the main
>> kernel tree or you don't. Of course there will always be a limbo of
>> code waiting for inclusion. But if it has to linger there for too
>> long (again: no matter for what reason) then it invalidates the
>> whole concept of not having a stable API. And that would be a pity.
> 
> You seem to have this idea of everyone having some sacred right of
> having their code either in the kernel or supported by the kernel
> developers.

No, and seriously I cannot see how you could possibly get that
impression from what I wrote.

> It is up to the maintainers to decide what's included and what's not.

Ok. But then it's also up to them to stand by their decision and
take the heat for it. Don't jump from your left foot to your right
foot, saying "submit your code to the kernel" if someone wants to
maintain something off-tree and "maintain it separately" if they
try to submit it. State clearly: "We do not want Reiser4 in Linux"
and defend it, instead of creating a string of ifs and then
complaining that people go on about it.

> We obviously don't want _everything_ in the kernel anyway and don't
> want to stagnate the kernel development because of out-of-tree code
> either.

Well, that doesn't make sense. You can't have your cake and eat it
too. Either you have out-of-tree code or you haven't. Documents
like stable_api_nonsense.txt explicitly discourage out-of-tree code,
which is formally equivalent to saying that all kernel code should
be in-tree. Therefore an attitude which says "go on developing that
code out-of-tree, it's not ready for inclusion yet" is in direct
contradiction with the foundations of the no-stable-API policy.

> If you're unhappy about maintainer decisions, feel free to
> complain to them

Well, isn't that what the present thread is all about?

> or better yet, step up to do the necessary legwork to
> get the code included.

That's completely beside the point. There are enough people already
who are willing to do the legwork. The question is whether they and
the kernel maintainers will be able to bridge their differences
about how it should be done, and that would not be made easier by
another party entering the arena.

Seriously, what do you think would happen if I actually took the
Reiser4 code, modified it according to what I think the kernel
people would like to see, and submitted the result to lkml? I'll
tell you what'd happen: I would get heat from both sides, I would
be blamed both for perceived flaws in the original design and for
any deviation from it, my motives would be questioned, I would be
asked whether I'd commit to maintaining that code for the
foreseeable future, and there would be no right answer to that
question. No matter what I did, it would only make things worse.

(Please note that the scenario above is completely fictitious. I am
neither capable of, nor interested in, taking over the development
of Reiser4 or promoting its admission into the kernel tree.)

> After all, that's how Linux development works.

Obviously there's more to it than that. There are people involved.

HTH
Tilman
