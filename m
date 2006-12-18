Return-Path: <linux-kernel-owner+w=401wt.eu-S1754256AbWLRQoH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754256AbWLRQoH (ORCPT <rfc822;w@1wt.eu>);
	Mon, 18 Dec 2006 11:44:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754257AbWLRQoG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Dec 2006 11:44:06 -0500
Received: from nic.NetDirect.CA ([216.16.235.2]:41830 "EHLO
	rubicon.netdirect.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754256AbWLRQoF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Dec 2006 11:44:05 -0500
X-Originating-Ip: 24.148.236.183
Date: Mon, 18 Dec 2006 11:38:14 -0500 (EST)
From: "Robert P. J. Day" <rpjday@mindspring.com>
X-X-Sender: rpjday@localhost.localdomain
To: Adrian Bunk <bunk@stusta.de>
cc: Linux kernel mailing list <linux-kernel@vger.kernel.org>,
       trivial@kernel.org
Subject: Re: [PATCH] Remove reference to "depends" directive from Kconfig
 documentation.
In-Reply-To: <20061218163522.GE10316@stusta.de>
Message-ID: <Pine.LNX.4.64.0612181137300.27491@localhost.localdomain>
References: <Pine.LNX.4.64.0612181038560.26878@localhost.localdomain>
 <20061218163522.GE10316@stusta.de>
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

> On Mon, Dec 18, 2006 at 10:40:25AM -0500, Robert P. J. Day wrote:
> >
> >   Remove from the documentation the notion of using "depends" rather
> > than "depends on" in Kconfig files.
> >
> > Signed-off-by: Robert P. J. Day <rpjday@mindspring.com>
> >
> > ---
> >
> >   given that there are only three Kconfig files left that still use
> > "depends" rather than "depends on", there's no point encouraging
> > anyone to still use it (although the parser itself still accepts both
> > "depends" and "requires").
> >
> >
> > diff --git a/Documentation/kbuild/kconfig-language.txt b/Documentation/kbuild/kconfig-language.txt
> > index 536d5bf..658abb5 100644
> > --- a/Documentation/kbuild/kconfig-language.txt
> > +++ b/Documentation/kbuild/kconfig-language.txt
> > @@ -77,7 +77,7 @@ applicable everywhere (see syntax).
> >    Optionally, dependencies only for this default value can be added with
> >    "if".
> >
> > -- dependencies: "depends on"/"requires" <expr>
> > +- dependencies: "depends on" <expr>
> >    This defines a dependency for this menu entry. If multiple
> >    dependencies are defined, they are connected with '&&'. Dependencies
> >    are applied to all other options within this menu entry (which also
>
> Your patch does something different:
> It's not about "depends", it's about the unused alternative "requires".
>
> Removing "requires" sounds reasonable (even for the implementation, not
> only the documentation), but that's different from what you were
> thinking about.

argh, sorry, brain glitch there.  i'll resubmit with the right
wording.

rday
