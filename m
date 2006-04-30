Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750926AbWD3J7X@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750926AbWD3J7X (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Apr 2006 05:59:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750917AbWD3J7X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Apr 2006 05:59:23 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:42630 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1750928AbWD3J7X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Apr 2006 05:59:23 -0400
Subject: Re: Simple header cleanups
From: David Woodhouse <dwmw2@infradead.org>
To: Peter Chubb <peterc@gelato.unsw.edu.au>
Cc: Linus Torvalds <torvalds@osdl.org>, Adrian Bunk <bunk@stusta.de>,
       akpm@osdl.org, linux-kernel@vger.kernel.org
In-Reply-To: <17492.34204.844839.262357@wombat.chubb.wattle.id.au>
References: <1146104023.2885.15.camel@hades.cambridge.redhat.com>
	 <Pine.LNX.4.64.0604261917270.3701@g5.osdl.org>
	 <1146105458.2885.37.camel@hades.cambridge.redhat.com>
	 <Pine.LNX.4.64.0604261954480.3701@g5.osdl.org>
	 <1146107871.2885.60.camel@hades.cambridge.redhat.com>
	 <Pine.LNX.4.64.0604262028130.3701@g5.osdl.org>
	 <20060427213754.GU3570@stusta.de>
	 <Pine.LNX.4.64.0604271439100.3701@g5.osdl.org>
	 <17492.34204.844839.262357@wombat.chubb.wattle.id.au>
Content-Type: text/plain
Date: Sun, 30 Apr 2006 10:59:48 +0100
Message-Id: <1146391189.10561.157.camel@shinybook.infradead.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 (2.6.1-1.fc5.2.dwmw2.1) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2006-04-30 at 19:38 +1000, Peter Chubb wrote:
> So now we need something new.

No we don't. We need only what we've already got. Our headers are
perfectly sufficient in principle -- we're already _relatively_ careful
not to pollute them with random kernel-private type and other stuff.
It's just that we need to be a little more competent at that, and that's
why we need the set of cleanups I've made and a tool to make life
easier. There's nothing particularly exciting to see here; there's no
need for any more fundamental change in the way things work.

Eliminating ifdefs and moving stuff into appropriate directories might
make it even easier still, if we do end up going that far. Certainly
it's the kind of cleanup which is _welcomed_ in C files, although
headers seem to be a touchy subject so I'm avoiding that question for
now.

But if we keep talking like this about crap like random userland
namespaces then I have a feeling Linus is just going to shut down and
not even take the normal, uncontentious cleanup patches which I was
careful to limit myself to because I didn't want to have wasted my time.

-- 
dwmw2

