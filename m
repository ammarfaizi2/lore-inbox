Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265306AbTAJRBK>; Fri, 10 Jan 2003 12:01:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265457AbTAJRBK>; Fri, 10 Jan 2003 12:01:10 -0500
Received: from noodles.codemonkey.org.uk ([213.152.47.19]:9858 "EHLO
	noodles.internal") by vger.kernel.org with ESMTP id <S265306AbTAJRBG>;
	Fri, 10 Jan 2003 12:01:06 -0500
Date: Fri, 10 Jan 2003 17:06:25 +0000
From: Dave Jones <davej@codemonkey.org.uk>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: William Lee Irwin III <wli@holomorphy.com>,
       Linus Torvalds <torvalds@transmeta.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: any chance of 2.6.0-test*?
Message-ID: <20030110170625.GE23375@codemonkey.org.uk>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	William Lee Irwin III <wli@holomorphy.com>,
	Linus Torvalds <torvalds@transmeta.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20030110161012.GD2041@holomorphy.com> <1042219147.31848.65.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1042219147.31848.65.camel@irongate.swansea.linux.org.uk>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 10, 2003 at 05:19:08PM +0000, Alan Cox wrote:

 > Most of the drivers still don't build either.

or still lack 2.4 fixes.

 > - The stuff that is destined for the bitbucket is marked in Config and people
 >   agree it should go

What's happening with the OSS drivers ?
I'm still carrying a few hundred KB of changes from 2.4 for those.
I'm not going to spent a day splitting them up, commenting them and pushing
to Linus if we're going to be dropping various drivers.

 > - It passes Cerberus uniprocessor and smp with/without pre-empt

I think this should wait until at least some more of the 2.4 changes
come forward. Most of those are security issues and the likes, but there
are a few driver corner cases too.

 > Otherwise everyone wil rapidly decide that ".0-pre" means ".0 as in Windows"
 > at which point you've just destroyed your testing base.

agreed.

 > Given all the new stuff should be in, I'd like to see a Linus the meanie
 > round of updating for a while which is simply about getting all the 2.4 fixes
 > and the 2.5 driver compile bugs nailed, and if it doesn't fix a compile bug
 > or a logic bug it doesn't go in.

Seconded.

 > No more "ISAPnP TNG" and module rewrites please

Absolutly. Lets try and get 2.6 out the door _this_ year.

		Dave

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
