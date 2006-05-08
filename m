Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750768AbWEHUBy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750768AbWEHUBy (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 May 2006 16:01:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751291AbWEHUBy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 May 2006 16:01:54 -0400
Received: from pasmtp.tele.dk ([193.162.159.95]:22538 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S1750768AbWEHUBx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 May 2006 16:01:53 -0400
Date: Mon, 8 May 2006 22:01:53 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Atsushi Nemoto <anemo@mba.ocn.ne.jp>,
       Chris Wright <chrisw@sous-sol.org>, linux-mips@linux-mips.org,
       ralf@linux-mips.org, Stephen Hemminger <shemminger@osdl.org>
Subject: Re: [git patches] kbuild fixes for -rc
Message-ID: <20060508200153.GA3762@mars.ravnborg.org>
References: <20060508050809.GA2247@mars.ravnborg.org> <20060508190312.GB2697@moss.sous-sol.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060508190312.GB2697@moss.sous-sol.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus.

Please revert this bogus commit:
> > commit c8d8b837ebe4b4f11e1b0c4a2bdc358c697692ed

I was discussed on mips list but apparently the fix was bogus.
I will not have time to look into it so mips can carry this local
fix until we get a proper fix in mainline.

[And I now have i386 toolchain in place so I can bo a better check next
time].

	Sam
