Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751758AbWFLKRu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751758AbWFLKRu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jun 2006 06:17:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751764AbWFLKRu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jun 2006 06:17:50 -0400
Received: from mx1.suse.de ([195.135.220.2]:49325 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751758AbWFLKRt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jun 2006 06:17:49 -0400
From: Neil Brown <neilb@suse.de>
To: Matthias Andree <matthias.andree@gmx.de>
Date: Mon, 12 Jun 2006 20:17:26 +1000
Message-ID: <17549.16182.237312.734481@cse.unsw.edu.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: Avi Kivity <avi@argo.co.il>, Rik van Riel <riel@redhat.com>,
       Theodore Tso <tytso@mit.edu>, David Woodhouse <dwmw2@infradead.org>,
       Matti Aarnio <matti.aarnio@zmailer.org>, linux-kernel@vger.kernel.org
Subject: Re: VGER does gradual SPF activation  (FAQ matter)
In-Reply-To: message from Matthias Andree on Monday June 12
References: <Pine.LNX.4.64.0606110952560.29891@cuia.boston.redhat.com>
	<448C2298.5000409@argo.co.il>
	<20060612084739.GD11649@merlin.emma.line.org>
X-Mailer: VM 7.19 under Emacs 21.4.1
X-face: v[Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday June 12, matthias.andree@gmx.de wrote:
> On Sun, 11 Jun 2006, Avi Kivity wrote:
> 
> > Can't it be corrected by having the thunk.org MTA relay messages from 
> > @mit.edu through the MIT MTA? Presumably the MIT MTA will only be open 
> > to authenticated users.
> 
> That isn't "corrected", but "broken even further".
> 
> What difference does it to the authenticity of the message or perhaps
> its envelope make who the postman is and into which mailbox the letter
> is posted?

"A bad analogy is like a leaky screw driver."

Your screwdriver is leaking!

If you get a letter from your aunt in Rome, and it is post-marked
'Moscow', you might doubt the authenticity.  If it claims to be from
your swiss bank with the same post mark you would doubt it even more.

I'm not saying that postmarks are a particularly good analogy,
but if I got had a knock on my door (SYN) and opened it (ACK /
SYN-ACK), and the person said
 Hi, I'm from the Thunk group (HELO thunk.org) and I have a letter
 from Ted at MIT (MAIL FROM: <tytso@mit.edu>) 
then I'm not sure I would believe them (well, I might, but my butler
shouldn't).

> 
> Use something sane please, not SPF.
> 
> All the world break their mailers at Wong's command because a half-baked
> idea is raved about without thinking.

"half-baked" - maybe that is appropriate.
I've been thinking lately that SPF is one of those "125mls of water in
a 250ml glass" things.
To some it is half full, to others it is half empty.

It's probably like monolithic kernels - there is no future in it!

NeilBrown

> 
> It's bad enough GMX are posting SPF records - I disabled SPF on my
> inbound path, because GMX enable a per-recipient configuration of this
> nonsense - I can't opt out of their posting SPF records though...
> 
> There's no need to repeat David's arguments counter to SPF for me.
> David's document says it all.
> 
> -- 
> Matthias Andree
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
