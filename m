Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279853AbRJ3FKw>; Tue, 30 Oct 2001 00:10:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279866AbRJ3FKm>; Tue, 30 Oct 2001 00:10:42 -0500
Received: from cx97923-a.phnx3.az.home.com ([24.9.112.194]:32648 "EHLO
	grok.yi.org") by vger.kernel.org with ESMTP id <S279853AbRJ3FKY>;
	Tue, 30 Oct 2001 00:10:24 -0500
Message-ID: <3BDE3662.D73DFE86@candelatech.com>
Date: Mon, 29 Oct 2001 22:10:58 -0700
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.12 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: TimO <hairballmt@mcn.net>
CC: "Kevin D. Wooten" <kwooten@home.com>, linux-kernel@vger.kernel.org
Subject: Re: Module Licensing?
In-Reply-To: <01102920463500.03524@newton.cevio.com> <3BDE27BE.3569FE22@candelatech.com> <3BDE3360.80731876@mcn.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

TimO wrote:
> 
> Ben Greear wrote:
> >
> > "Kevin D. Wooten" wrote:
> > >
> > > After reading the posts about the MODULE_LICENSE macro, I am in disbelief. I
> > > was under the impression that one could write a "closed-source" module and
> > > distribute it in binary form, and be in compliance. Please tell me I am
> > > wrong? We use Linux as a platform for some data acquisition, and we are
> > > currently distributing ( in very limited quantity to people who would already
> > > have signed an NDA ) modules that currently have no official license as yet.
> > > We are researching which license to use, but according to these post's we
> > > have almost no choice, Open Source or not at all!
> >
> > No, you just can't use certain symbols if you're not GPL.  If your
> > code already works, then you're fine, as previously existing symbols
> > will not be thus restricted...  You can just make your MODULE_LICENSE == "mine-all-mine...including-all-my-bugs"
> 
> Ugghh!  Don't confuse/equate MODULE_LICENSE with EXPORT_SYMBOL_GPL_ONLY;
> two different animals, two differnet goals.  See archives for more info.

Ok, but regardless of the politics, if you're not GPL as was the original
poster's issued, then you will not be able to use the GPL_ONLY symbols,
right?  They aren't the same, but they are inter-related, unless I completely
mis-understand....

Ben

-- 
Ben Greear <greearb@candelatech.com>       <Ben_Greear AT excite.com>
President of Candela Technologies Inc      http://www.candelatech.com
ScryMUD:  http://scry.wanfear.com     http://scry.wanfear.com/~greear
