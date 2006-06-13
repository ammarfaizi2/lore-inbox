Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750928AbWFMKqE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750928AbWFMKqE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jun 2006 06:46:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750929AbWFMKqE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jun 2006 06:46:04 -0400
Received: from mail.gmx.de ([213.165.64.21]:22150 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1750926AbWFMKqD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jun 2006 06:46:03 -0400
X-Authenticated: #428038
Date: Tue, 13 Jun 2006 12:45:57 +0200
From: Matthias Andree <matthias.andree@gmx.de>
To: David Woodhouse <dwmw2@infradead.org>
Cc: Horst von Brand <vonbrand@inf.utfsm.cl>, jdow <jdow@earthlink.net>,
       Jesper Juhl <jesper.juhl@gmail.com>, nick@linicks.net,
       Bernd Petrovitsch <bernd@firmix.at>, marty fouts <mf.danger@gmail.com>,
       Matti Aarnio <matti.aarnio@zmailer.org>, linux-kernel@vger.kernel.org
Subject: Re: VGER does gradual SPF activation (FAQ matter)
Message-ID: <20060613104557.GA13597@merlin.emma.line.org>
Mail-Followup-To: David Woodhouse <dwmw2@infradead.org>,
	Horst von Brand <vonbrand@inf.utfsm.cl>, jdow <jdow@earthlink.net>,
	Jesper Juhl <jesper.juhl@gmail.com>, nick@linicks.net,
	Bernd Petrovitsch <bernd@firmix.at>,
	marty fouts <mf.danger@gmail.com>,
	Matti Aarnio <matti.aarnio@zmailer.org>,
	linux-kernel@vger.kernel.org
References: <200606130300.k5D302rc004233@laptop11.inf.utfsm.cl> <1150189506.11159.93.camel@shinybook.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1150189506.11159.93.camel@shinybook.infradead.org>
X-PGP-Key: http://home.pages.de/~mandree/keys/GPGKEY.asc
User-Agent: Mutt/1.5.11-2006-06-08
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 13 Jun 2006, David Woodhouse wrote:

> On Mon, 2006-06-12 at 23:00 -0400, Horst von Brand wrote:
> > > Greylist those who have not subscribed.
> > 
> > That is not easy to do. 
> 
> It's fairly trivial with a decent MTA. I use all kinds of conditions to
> trigger greylisting -- HTML mail, 'Re:' in subject with no References:,
> lack of reverse DNS or CSA on the sending host, >=0.1 SA points, etc.
> Adding "is not subscribed to the mailing list they're trying to post to"
> should be trivial.

Given that list drivers are separate from the MTA (and that's good),
it's less trivial than simple looking at message headers or DNS info
that the MTA shuffles around anyways. The MTA doesn't need the
subscription list however, since "exploding" the subscriber list is a
separate problem handled by Majordomo, Mailman, Sympa, whatever.

-- 
Matthias Andree
