Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268411AbUHQUWQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268411AbUHQUWQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Aug 2004 16:22:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268410AbUHQUWP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Aug 2004 16:22:15 -0400
Received: from fw.osdl.org ([65.172.181.6]:26561 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S268412AbUHQUWG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Aug 2004 16:22:06 -0400
Date: Tue, 17 Aug 2004 13:21:04 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: Sam Ravnborg <sam@ravnborg.org>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: [PATCH] fix warnings in scripts/binoffset.c
Message-Id: <20040817132104.5f2dc7d8.rddunlap@osdl.org>
In-Reply-To: <20040817221332.GB23582@mars.ravnborg.org>
References: <20040816202805.356f134d.rddunlap@osdl.org>
	<20040817221332.GB23582@mars.ravnborg.org>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.10 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Face: +5V?h'hZQPB9<D&+Y;ig/:L-F$8p'$7h4BBmK}zo}[{h,eqHI1X}]1UhhR{49GL33z6Oo!`
 !Ys@HV,^(Xp,BToM.;N_W%gT|&/I#H@Z:ISaK9NqH%&|AO|9i/nB@vD:Km&=R2_?O<_V^7?St>kW
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 18 Aug 2004 00:13:32 +0200 Sam Ravnborg wrote:

| On Mon, Aug 16, 2004 at 08:28:05PM -0700, Randy.Dunlap wrote:
| > 
| > Correct gcc warnings for function return type, printf argument
| > types, and signed/unsigned compare.
| > 
| > Cross-compiled with no warnings/errors for alpha, ia64,
| > ppc32, ppc64, sparc32, sparc64, x86_64, and native on i386.
| > (-W -Wall)
| > 
| > [pre-built tool chains are available from:
| > http://developer.osdl.org/dev/plm/cross_compile/ ]
| > 
| > Signed-off-by: Randy Dunlap <rddunlap@osdl.org>
| 
| Added to my tree - but..
| How am I supposed to build binoffset when I decide
| to use extract-config?

Good question.  I'm (slowly) working on that.  I also have
some contributed patches that address that... patience.

I was thinking about 'make getconfig', but that would be only
one way to use it.  It would still need an external/out-of-tree
solution also.  ('make getconfig' would build binoffset and run
the extract-ikconfig script.)

--
~Randy
