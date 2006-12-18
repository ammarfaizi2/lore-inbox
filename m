Return-Path: <linux-kernel-owner+w=401wt.eu-S1754404AbWLRSza@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754404AbWLRSza (ORCPT <rfc822;w@1wt.eu>);
	Mon, 18 Dec 2006 13:55:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754405AbWLRSz3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Dec 2006 13:55:29 -0500
Received: from nic.NetDirect.CA ([216.16.235.2]:42549 "EHLO
	rubicon.netdirect.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754403AbWLRSz3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Dec 2006 13:55:29 -0500
X-Originating-Ip: 24.148.236.183
Date: Mon, 18 Dec 2006 13:46:27 -0500 (EST)
From: "Robert P. J. Day" <rpjday@mindspring.com>
X-X-Sender: rpjday@localhost.localdomain
To: Adrian Bunk <bunk@stusta.de>
cc: zippel@linux-m68k.org,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>,
       kbuild-devel@lists.sourceforge.net
Subject: Re: [2.6 patch] kconfig: remove the unused "requires" syntax
In-Reply-To: <20061218180447.GF10316@stusta.de>
Message-ID: <Pine.LNX.4.64.0612181341090.28308@localhost.localdomain>
References: <Pine.LNX.4.64.0612181138360.27491@localhost.localdomain>
 <20061218180447.GF10316@stusta.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Net-Direct-Inc-MailScanner-Information: Please contact the ISP for more information
X-Net-Direct-Inc-MailScanner: Found to be clean
X-Net-Direct-Inc-MailScanner-SpamCheck: not spam, SpamAssassin (not cached,
	score=-14.754, required 5, ALL_TRUSTED -1.80, BAYES_00 -15.00,
	RCVD_IN_SORBS_DUL 2.05)
X-Net-Direct-Inc-MailScanner-From: rpjday@mindspring.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 18 Dec 2006, Adrian Bunk wrote:

> On Mon, Dec 18, 2006 at 11:41:59AM -0500, Robert P. J. Day wrote:
> >
> >   Remove the note in the documentation that suggests people can use
> > "requires" for dependencies in Kconfig files.
> >...
>
> Considering that noone uses it, what about the patch below to also
> remove the implementation?

... big snip ...

i have no problem knocking out of the parser anything related to
"depends" or "requires."  in fact, i did note in earlier patch
submissions that i was just cleaning the Kconfig files but i was
leaving the parser alone, and someone else was welcome to take care of
that.

if the kbuild folks are good with this, i certainly have no objection.

rday

p.s.  i didn't look closely enough to see if your patch took out
support for both "depends" *and* "requires".  at this point, neither
of those are necessary anymore -- it's all "depends on" except for
three remaining Kconfig files.

