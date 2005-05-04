Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261608AbVEDK7F@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261608AbVEDK7F (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 May 2005 06:59:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261612AbVEDK7F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 May 2005 06:59:05 -0400
Received: from world.rdmcorp.com ([204.225.180.10]:36577 "EHLO
	mailhost.rdmcorp.com") by vger.kernel.org with ESMTP
	id S261608AbVEDK7B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 May 2005 06:59:01 -0400
Date: Wed, 4 May 2005 06:54:48 -0400 (EDT)
From: "Robert P. J. Day" <rpjday@mindspring.com>
X-X-Sender: rpjday@localhost.localdomain
To: "Bodo Eggert <harvested.in.lkml@posting.7eggert.dyndns.org>" 
	<7eggert@gmx.de>
cc: Roman Zippel <zippel@linux-m68k.org>, Adrian Bunk <bunk@stusta.de>,
       Andrew Morton <akpm@osdl.org>, kbuild-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org, Jesper Juhl <juhl-lkml@dif.dk>
Subject: Re: [kbuild-devel] Re: [2.6 patch] Kconfig: rename "---help---" to
 "help" in Kconfig  files (first part)
In-Reply-To: <E1DSxtF-0001Dz-N6@be1.7eggert.dyndns.org>
Message-ID: <Pine.LNX.4.61.0505040651400.6658@localhost.localdomain>
References: <3ZTLT-3D3-1@gated-at.bofh.it> <401Js-1AH-1@gated-at.bofh.it>
 <401Tf-1Hp-9@gated-at.bofh.it> <402FB-2mN-15@gated-at.bofh.it>
 <E1DSxtF-0001Dz-N6@be1.7eggert.dyndns.org>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323328-164173524-1115204088=:6658"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-164173524-1115204088=:6658
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT

On Tue, 3 May 2005, Bodo Eggert <harvested.in.lkml@posting.7eggert.dyndns.org> wrote:

> Roman Zippel <zippel@linux-m68k.org> wrote:
> > On Tue, 3 May 2005, Adrian Bunk wrote:
>
> >> IMHO, Kconfig files are quite readable due to this indentation even
> >> though only a minority of the entries was using "---help---" even
> >> before this patch.
> >
> > So why exactly has to be removed? Is it ugly?
>
> IMO yes, it's less readable for me than "help". ¢¢

the main problem with having two alternatives for the same thing (in
*any* context) is that it gives beginners a distorted sense of what is
acceptable usage.

if you accept both "help" and "---help---", then you just *know* that
a beginner will notice that and start thinking, "hmmm ... well, if
both of those are alright, maybe "--help--" or "-help-" is alright,
too.  and maybe it's just the leading hyphens that really count, not
the trailing hyphens.  and maybe ..."

kbuild is already over-convoluted as it is.  please don't give folks
even more redundant ways to do exactly the same thing.

rday
--8323328-164173524-1115204088=:6658--
