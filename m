Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932505AbWI2DFW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932505AbWI2DFW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Sep 2006 23:05:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932513AbWI2DFW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Sep 2006 23:05:22 -0400
Received: from mail.gmx.net ([213.165.64.20]:985 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S932505AbWI2DFV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Sep 2006 23:05:21 -0400
X-Authenticated: #5039886
Date: Fri, 29 Sep 2006 05:05:19 +0200
From: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
To: Neil Brown <neilb@suse.de>
Cc: davids@webmaster.com,
       "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>
Subject: Re: GPLv3 Position Statement
Message-ID: <20060929030518.GA21048@atjola.homenet>
Mail-Followup-To: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>,
	Neil Brown <neilb@suse.de>, davids@webmaster.com,
	"Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>
References: <20060928144028.GA21814@wohnheim.fh-wedel.de> <MDEHLPKNGKAHNMBLJOLKCENGOLAB.davids@webmaster.com> <17692.35028.84683.896718@cse.unsw.edu.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <17692.35028.84683.896718@cse.unsw.edu.au>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2006.09.29 12:45:40 +1000, Neil Brown wrote:
> On Thursday September 28, davids@webmaster.com wrote:
> > 
> > > In my very uninformed opinion, your problem is a very minor one.  Your
> > > "v2 or later" code won't get the license v2 removed, it will become
> > > dual "v2 or v3" licensed.  And assuming that v3 only adds restrictions
> > > and doesn't allow the licensee any additional rights, you, as the
> > > author, shouldn't have to worry much.
> > >
> > > The problem arises later.  As with BSD/GPL dual licensed code, where
> > > anyone can take the code and relicense it as either BSD or GPL, "v2 or
> > > v3" code can get relicensed as v3 only.  At this point, nothing is
> > > lost, as the identical "v2 or v3" code still exists.  But with further
> > > development on the "v3 only" branch, you have a fork.  And one that
> > > doesn't just require technical means to get merged back, but has legal
> > > restrictions.
> > 
> > Unless I'm missing something, you *cannot* change the license from "v2 or
> > later at your option" to "v3 or later". Both GPLv2 and GPLv3 explicitly
> > prohibit modifying license notices. (Did the FSF goof big time? It's not too
> > late to change the draft.)
> 
> Could you point to the test in either license that prohibits modifying
> license notices?
> I certainly couldn't find it in section 2 of GPLv2, which seems to be
> the relevant section.

It's in section 1, where it says "keep intact all the notices that refer
to this License" (section 2 refers to section 1).
The current GPLv3 draft says (section 4): "keep intact all license
notices".

Notice a difference? I'm not a native speaker and of course IANAL, but
AFAICT, with "v2 or later", if you follow the terms of GPLv2, you are
only required to keep notices refering to THAT license, ie. GPLv2, so
you seem to be allowed to remove the GPLv3 notices. But if you follow
the terms of the GPLv3, you are required to keep ALL license notices,
including those that refer to v2.
So you could actually never ever make a "v2 or later" program a
"v3 only" program, but only a "v2 only".

Am I missing something?

> Interestingly, 2.b seem to say that if I received a program under
> GPLv2, and I pass it on, then I must pass it on under GPLv2-only...
> So to be able to distribute something written today under GPLv3 (when
> it comes into existence), you must be the original or have received it
> directly from the original author....

Section 9 states that the notices that refer to the license are
important. If you specify "v2-only" you can use v2 only. If you specify
"v2 or later" you are not bound to GPLv2 2.b at all if you choose to
follow the terms of any later version. And if no version is mentioned at
all, you can follow the terms of any version ever released.


Björn
