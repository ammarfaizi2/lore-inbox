Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261853AbVADVDw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261853AbVADVDw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jan 2005 16:03:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261832AbVADVDi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jan 2005 16:03:38 -0500
Received: from inti.inf.utfsm.cl ([200.1.21.155]:35263 "EHLO inti.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id S261700AbVADVBp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jan 2005 16:01:45 -0500
Message-Id: <200501042058.j04KwFED002211@laptop11.inf.utfsm.cl>
To: Felipe Alfaro Solana <lkml@mac.com>
cc: Horst von Brand <vonbrand@inf.utfsm.cl>, linux-kernel@vger.kernel.org,
       Adrian Bunk <bunk@stusta.de>, Rik van Riel <riel@redhat.com>,
       William Lee Irwin III <wli@holomorphy.com>,
       Maciej Soltysiak <solt2@dns.toxicfilms.tv>,
       Andries Brouwer <aebr@win.tue.nl>,
       William Lee Irwin III <wli@debian.org>
Subject: Re: starting with 2.7 
In-Reply-To: Message from Felipe Alfaro Solana <lkml@mac.com> 
   of "Tue, 04 Jan 2005 15:27:04 BST." <B470A11D-5E5C-11D9-A816-000D9352858E@mac.com> 
X-Mailer: MH-E 7.4.2; nmh 1.0.4; XEmacs 21.4 (patch 15)
Date: Tue, 04 Jan 2005 17:58:15 -0300
From: Horst von Brand <vonbrand@inf.utfsm.cl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Felipe Alfaro Solana <lkml@mac.com> said:
> On 4 Jan 2005, at 14:27, Horst von Brand wrote:
> > Felipe Alfaro Solana <lkml@mac.com> said:

[...]

> >> I think new developments will force a 2.7 branch: when 2.6 feature set
> >> stabilizes, people will keep more time testing a stable, relatively
> >> static kernel base, finding bugs, instead of trying to keep up with
> >> changes.

> > And when 2.7 opens, very few developers will tend 2.6; and as 2.7 
> > diverges from it, fewer and fewer fixes will find their way back. And
> > so you finally get a rock-stable (== unchanging) 2.6, but hopelessly
> > out of date and thus unfixable (if nothing else because there are no
> > people around who remember how it worked).

> I can see no easy solution for this... If Linus decides to fork off 
> 2.7, development efforts will go into 2.7 and fixes should get 
> backported to 2.6. If Linus decides to stay with 2.6, new development 
> will have to be "conservative" enough not to break things that were 
> working.

Exactly.

> I tend to prefer forking off 2.7: more agressive features can be 
> implemented and tested without bothering disrupting the stable 2.6 
> branch.

Have any particular features in mind? If you have some, you can fork off
your own BK repository and play there (wait... that is how (currently)
out-of-tree drivers are developed!). Or you could start an unofficial
experimental fork. If none of the above, I guess you'd just have to wait
until Our Fearless Leader decides it is time for 2.7.

Just forcing a 2.7 "because that'll stabilize 2.6" is nonsense. Because
then 2.6 won't stabilize any faster (probably slower).
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
