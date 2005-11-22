Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750702AbVKVIwn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750702AbVKVIwn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Nov 2005 03:52:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751274AbVKVIwn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Nov 2005 03:52:43 -0500
Received: from mail.gmx.net ([213.165.64.20]:32131 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1750702AbVKVIwm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Nov 2005 03:52:42 -0500
X-Authenticated: #428038
Date: Tue, 22 Nov 2005 09:52:39 +0100
From: Matthias Andree <matthias.andree@gmx.de>
To: linux-kernel@vger.kernel.org
Subject: Re: what is our answer to ZFS?
Message-ID: <20051122085239.GC16295@merlin.emma.line.org>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <11b141710511210144h666d2edfi@mail.gmail.com> <20051121095915.83230.qmail@web36406.mail.mud.yahoo.com> <20051121101959.GB13927@wohnheim.fh-wedel.de> <20051121114654.GA25180@merlin.emma.line.org> <1132574831.15938.14.camel@localhost> <20051121131832.GB26068@merlin.emma.line.org> <1132582713.15938.22.camel@localhost> <20051121144150.GA10189@merlin.emma.line.org> <1132585711.15938.28.camel@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1132585711.15938.28.camel@localhost>
X-PGP-Key: http://home.pages.de/~mandree/keys/GPGKEY.asc
User-Agent: Mutt/1.5.11
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 21 Nov 2005, Kasper Sandberg wrote:

> > As mentioned, a file system cannot possibly be stable right after merge.
> > Having to change formatting is a sweeping change and certainly is a
> > barrier across which to look for auditing is all the more difficult.
> before reiser4 was changed alot, to match the codingstyle (agreed, they
> have to obey by the kernels codingstyle), it was stable, so had it been
> merged there it wouldnt have been any less stable.

Code reformatting, unless 100% automatic with a 100% proven and C99
aware formatting tool, also introduces instability.

> > Lucky you. I haven't dared try it yet for lack of a test computer to
> > trash.
> i too was reluctant, i ended up using it for the things i REALLY dont
> want to loose.

So did many when reiser 3 was fresh, it was much raved about its speed,
stability, its alleged recoverability and recovery speed, and then
people started sending full filesystem dumps on tape and other media to
Namesys...

It's impossible to fully test nontrivial code, every option, every
possible state exponentiates the number of possibilities you have to
test to claim 100% coverage.

-- 
Matthias Andree
