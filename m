Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314078AbSINMAU>; Sat, 14 Sep 2002 08:00:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315374AbSINMAU>; Sat, 14 Sep 2002 08:00:20 -0400
Received: from krusty.dt.E-Technik.uni-dortmund.de ([129.217.163.1]:39436 "EHLO
	mail.dt.e-technik.uni-dortmund.de") by vger.kernel.org with ESMTP
	id <S314078AbSINMAT>; Sat, 14 Sep 2002 08:00:19 -0400
Date: Sat, 14 Sep 2002 14:05:07 +0200
From: Matthias Andree <matthias.andree@stud.uni-dortmund.de>
To: linux-kernel@vger.kernel.org
Subject: Re: ADMIN: DON'T try to be clever with email headers!
Message-ID: <20020914120507.GA16598@merlin.emma.line.org>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <20020910225530.A17094@mars.ravnborg.org> <20020910230656.D18386@mars.ravnborg.org> <9500000.1031706478@aslan.btc.adaptec.com> <20020911071219.A1352@mars.ravnborg.org> <slrnao427d.si3.abuse@madhouse.demon.co.uk> <20020913173709.GG30392@mea-ext.zmailer.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020913173709.GG30392@mea-ext.zmailer.org>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 13 Sep 2002, Matti Aarnio wrote:

>   Folks, when aiming to post into VGER's lists, DO NOT
>   try to make any cute things in headers.  Any such
>   are bound to cause TONS of bounces, which did happen
>   in this particular case...

The fix is to normalize headers. Any mailing list should do that. I have
seen ISODE PP 5.0, running the uni-dortmund secondary MX (which is in
fact the only reachable outside the intranet), bounce on perfectly-legal
addresses, and mails containing double Date: headers and for other
frivolous reasons. Recently I got unsubscribed for reasons Dave Miller
could not recall, he had not kept the bounce :-(

Does anybody know of an opensource real-time anti-relay SMTP proxy that
can do aliasing?

I like the way ezmlm-idx, a mailing list manager, handles things, it
stores bounces, and after some days, notifies the list members, and if
the notice does not get through, kills the subscription after another
verification. I'd be good if the vger lists could do the same, so users
could actually figure what goes through and what is rejected.

Anyhow, by all means, DO KEEP THE BOUNCES YOU GET, use a script and keep
them for two weeks, and then weed them out. Feel free to weed all
subsequent bounces from one address that has the same bounce reason.
This should be possible with low effort, but allows users to figure
what's up should they ask.

BTW, his header showed up escaped at my site:

Reply-To: "andy@"@his.domain

And, FWIW, this looks legal to me according to RFC-2822 EBNF.
