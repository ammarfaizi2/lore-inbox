Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030247AbWI2G4t@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030247AbWI2G4t (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Sep 2006 02:56:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030383AbWI2G4t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Sep 2006 02:56:49 -0400
Received: from stat9.steeleye.com ([209.192.50.41]:11443 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S1030247AbWI2G4s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Sep 2006 02:56:48 -0400
Subject: Re: GPLv3 Position Statement
From: James Bottomley <James.Bottomley@SteelEye.com>
To: Neil Brown <neilb@suse.de>
Cc: tridge@samba.org, linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <17692.41932.957298.877577@cse.unsw.edu.au>
References: <1159498900.3880.31.camel@mulgrave.il.steeleye.com>
	 <17692.41932.957298.877577@cse.unsw.edu.au>
Content-Type: text/plain
Date: Thu, 28 Sep 2006 23:56:37 -0700
Message-Id: <1159512998.3880.50.camel@mulgrave.il.steeleye.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-4.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-09-29 at 14:40 +1000, Neil Brown wrote:
> You seem to be saying that including software in a product that you
> then distribute is *both* a USE and a DISTRIBUTION of that software.

Sort of ... I'm asserting that producing something (an appliance say, or
a PCI card) that runs linux to achieve its function is a "use" (an act
of running the program) within the meaning of GPLv2 clause 0.  Selling
the Box (or card, or whatever) also becomes a distribution.

> So if the software is obtained under the GPL, and the GPL asserts "no
> restrictions on use" then it should also not restrict distribution.
> It can place requirements that must be met before distribution is
> allowed, but they shouldn't be so onerous as to inhibit distribution.
> Does that sound right?

Not exactly.  Under v2, there are specific duties that go along with the
act of distributing (providing access to the source code and all
modifications), but explicitly none on end use.  You can't get out of
the distribution requirements simply by claiming it's also a use.

However I claim that, the GPLv3 requirement that you be able to "execute
modified versions from source code in the recommended or principal
context of use" does constitute an end use restriction on the embedded
system because the appliance (or card, or whatever) must be designed in
such a way as to allow this.

If my claim is valid, it means that GPLv3 violates the spirit of GPLv2
because it specifically goes against one of its terms (clause 0).  This
is the reason the FSF sees the act of running embedded Linux in
something to be a distribution; so they can apply the additional
restrictions without going against the spirit of GPLv2.

James


