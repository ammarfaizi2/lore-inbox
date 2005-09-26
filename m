Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751353AbVIZT3E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751353AbVIZT3E (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Sep 2005 15:29:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751328AbVIZT3E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Sep 2005 15:29:04 -0400
Received: from anf141.internetdsl.tpnet.pl ([83.17.87.141]:46795 "EHLO
	anf141.internetdsl.tpnet.pl") by vger.kernel.org with ESMTP
	id S1751353AbVIZT3D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Sep 2005 15:29:03 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH 3/3][Fix] swsusp: prevent swsusp from failing if there's too many pagedir pages
Date: Mon, 26 Sep 2005 21:19:26 +0200
User-Agent: KMail/1.8.2
Cc: LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
References: <200509252018.36867.rjw@sisk.pl> <200509261454.09702.rjw@sisk.pl> <20050926142608.GA32249@elf.ucw.cz>
In-Reply-To: <20050926142608.GA32249@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200509262119.27240.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Monday, 26 of September 2005 16:26, Pavel Machek wrote:
> Hi!
> 
]-- snip --[
> 
> > Unfortunately it's not enough for what I'm cooking (think of resuming in 35 sec.
> > to a fully responsive system - well, that's on my box).  A preliminary patch
> > is at http://www.sisk.pl/kernel/patches/2.6.14-rc2-git3/swsusp-improve-freeing-memory.patch
> 
> Okay, I see, nice... We want to support that in future. (Actually it
> is last piece of puzzle for swsusp3).

Well, it can be implemented within the current swsusp, IMO.  It actually
works for me now. :-)

]-- snip --[
> 
> I plan to push "rework image freeing patch" for other reasons,
> too. I'd like to run longer tests on it, but so far it looks okay.

I think it's fine.  Could you please point me to the current version?

Greetings,
Rafael

