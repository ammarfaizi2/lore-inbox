Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261938AbTJRSVO (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Oct 2003 14:21:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261939AbTJRSVN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Oct 2003 14:21:13 -0400
Received: from gaia.cela.pl ([213.134.162.11]:45583 "EHLO gaia.cela.pl")
	by vger.kernel.org with ESMTP id S261938AbTJRSVM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Oct 2003 14:21:12 -0400
Date: Sat, 18 Oct 2003 20:19:56 +0200 (CEST)
From: Maciej Zenczykowski <maze@cela.pl>
To: "Mudama, Eric" <eric_mudama@Maxtor.com>
cc: "'John Bradford'" <john@grabjohn.com>, Krzysztof Halasa <khc@pm.waw.pl>,
       Rogier Wolff <R.E.Wolff@BitWizard.nl>,
       Norman Diamond <ndiamond@wta.att.ne.jp>,
       Hans Reiser <reiser@namesys.com>, Wes Janzen <superchkn@sbcglobal.net>,
       <linux-kernel@vger.kernel.org>
Subject: RE: Blockbusting news, this is important (Re: Why are bad disk se
 ctors numbered strangely, and what happens to them?)
In-Reply-To: <785F348679A4D5119A0C009027DE33C105CDB2EE@mcoexc04.mlm.maxtor.com>
Message-ID: <Pine.LNX.4.44.0310182016590.7916-100000@gaia.cela.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> To pay for itself it would have to cost multiple millions of dollars.  The
> #1 constraint in an IDE drive is cost per gigabyte, since 99.9% of
> purchasers don't look at anything else.  This means that we strip down
> things like our electronics and internal mask ROMs to their minimum required
> size.  Specialized code with extra features would inherently be larger,
> which gives two choices:

Would a single command to read a sector ignoring drive remaps really be 
that hard/expensive/large in size to implement?  I'd expect this would 
easily fit in the spare room at the end of the ROM - the function is 
pretty much (no doubt) already implemented - it just lacks an external 
interface.

I think this is all we really need - sure more would be nice, but this 
would suffice for those who say remaps without reading in the data 
correctly first are bad.

Cheers,
MaZe.

