Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279496AbRJ3KFk>; Tue, 30 Oct 2001 05:05:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279908AbRJ3KFa>; Tue, 30 Oct 2001 05:05:30 -0500
Received: from cx147940-a.chnd1.az.home.com ([24.1.238.119]:35968 "EHLO
	newton.cevio.com") by vger.kernel.org with ESMTP id <S279496AbRJ3KF3>;
	Tue, 30 Oct 2001 05:05:29 -0500
Content-Type: text/plain; charset=US-ASCII
From: "Kevin D. Wooten" <kwooten@home.com>
To: TimO <hairballmt@mcn.net>, Ben Greear <greearb@candelatech.com>
Subject: Re: Module Licensing?
Date: Tue, 30 Oct 2001 00:24:52 -0700
X-Mailer: KMail [version 1.2]
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <01102920463500.03524@newton.cevio.com> <3BDE27BE.3569FE22@candelatech.com> <3BDE3360.80731876@mcn.net>
In-Reply-To: <3BDE3360.80731876@mcn.net>
MIME-Version: 1.0
Message-Id: <01103000245200.01138@newton.cevio.com>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 29 October 2001 21:58, TimO wrote:
> Ben Greear wrote:
> > "Kevin D. Wooten" wrote:
> > > After reading the posts about the MODULE_LICENSE macro, I am in
> > > disbelief. I was under the impression that one could write a
> > > "closed-source" module and distribute it in binary form, and be in
> > > compliance. Please tell me I am wrong? We use Linux as a platform for
> > > some data acquisition, and we are currently distributing ( in very
> > > limited quantity to people who would already have signed an NDA )
> > > modules that currently have no official license as yet. We are
> > > researching which license to use, but according to these post's we have
> > > almost no choice, Open Source or not at all!
> >
> > No, you just can't use certain symbols if you're not GPL.  If your
> > code already works, then you're fine, as previously existing symbols
> > will not be thus restricted...  You can just make your MODULE_LICENSE ==
> > "mine-all-mine...including-all-my-bugs"
>
> Ugghh!  Don't confuse/equate MODULE_LICENSE with EXPORT_SYMBOL_GPL_ONLY;
> two different animals, two differnet goals.  See archives for more info.
>


My apologies for the misinterpretation. 
This scheme seems fine as long as driver related symbols are not "GPL" only.


> > Ben
> >
> > > -kw
> > > -
