Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161316AbWF0VfU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161316AbWF0VfU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 17:35:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161318AbWF0VfT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 17:35:19 -0400
Received: from xenotime.net ([66.160.160.81]:62907 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1161317AbWF0VfQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 17:35:16 -0400
Date: Tue, 27 Jun 2006 14:38:01 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: Lukas Jelinek <info@kernel-api.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Kernel API Reference Documentation
Message-Id: <20060627143801.d8352066.rdunlap@xenotime.net>
In-Reply-To: <44A1982C.1010008@kernel-api.org>
References: <44A1858B.9080102@kernel-api.org>
	<20060627132226.2401598e.rdunlap@xenotime.net>
	<44A1982C.1010008@kernel-api.org>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.5 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 27 Jun 2006 22:42:20 +0200 Lukas Jelinek wrote:

>  >
> > FYI, there are already some kernel-doc rules in
> > Documentation/kernel-doc-nano-HOWTO.txt.  These rules work with the
> > doc. generator in the kernel tree (scripts/kernel-doc).
> > Do you have suggestions for how to make them (the rules) better?
> > so that the in-tree kernel doc. will improve...
> 
> These rules seem to be good. I will try to use the generator
> (scripts/kernel-doc) and check the result.
> 
> But the bigger problem is that many headers are not documented at all.
> And some code is documented but not complying the rules.

Yes, well aware of both of those, plus a few minor problems
with scripts/kernel-doc itself.
I just added a minor rules-checker to the script and have
more plans for it.

We try to have new exported interfaces documented (I don't try
on static [private] interfaces).

I have had email with a professor in China who was going to have
some students do some work in this area, but I haven't heard back
from him (over 1 month ago).


> > 
> > Q2:  what do I get when I download one of the tarballs from kernel-api.org?
> > 
> 
> Each tarball contains exactly the same as can be browsed online at
> kernel-api.org. There is no difference.

OK.

> > Q3:  Can we see your sed scripts?
> > 
> 
> Yes, here it is (it's really small and mindless):

Thanks.

---
~Randy
