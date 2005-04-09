Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261353AbVDIQdz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261353AbVDIQdz (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Apr 2005 12:33:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261356AbVDIQdz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Apr 2005 12:33:55 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:14000 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S261353AbVDIQdx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Apr 2005 12:33:53 -0400
Date: Sat, 9 Apr 2005 18:33:23 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Linus Torvalds <torvalds@osdl.org>
cc: Andrea Arcangeli <andrea@suse.de>, Martin Pool <mbp@sourcefrog.net>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
       David Lang <dlang@digitalinsight.com>
Subject: Re: Kernel SCM saga..
In-Reply-To: <Pine.LNX.4.58.0504081647510.28951@ppc970.osdl.org>
Message-ID: <Pine.LNX.4.61.0504091547320.15339@scrub.home>
References: <Pine.LNX.4.58.0504060800280.2215@ppc970.osdl.org>
 <20050406193911.GA11659@stingr.stingr.net> <pan.2005.04.07.01.40.20.998237@sourcefrog.net>
 <20050407014727.GA17970@havoc.gtf.org> <pan.2005.04.07.02.25.56.501269@sourcefrog.net>
 <Pine.LNX.4.62.0504061931560.10158@qynat.qvtvafvgr.pbz> <1112852302.29544.75.camel@hope>
 <Pine.LNX.4.58.0504071626290.28951@ppc970.osdl.org> <1112939769.29544.161.camel@hope>
 <Pine.LNX.4.58.0504072334310.28951@ppc970.osdl.org> <20050408083839.GC3957@opteron.random>
 <Pine.LNX.4.58.0504081647510.28951@ppc970.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, 8 Apr 2005, Linus Torvalds wrote:

> Also, I suspect that BKCVS actually bothers to get more details out of a
> BK tree than I cared about. People have pestered Larry about it, so BKCVS
> exports a lot of the nitty-gritty (per-file comments etc) that just
> doesn't actually _matter_, but people whine about. Me, I don't care. My
> sparse-conversion just took the important parts.

As soon as you want to synchronize and merge two trees, you will know why 
this information does matter.
(/me looks closer at the sparse-conversion...)
It seems you exported the complete parent information and this is exactly 
the "nitty-gritty" I was "whining" about and which is not available via 
bkcvs or bkweb and it's the most crucial information to make the bk data 
useful outside of bk. Larry was previously very clear about this that he 
considers this proprietary bk meta data and anyone attempting to export 
this information is in violation with the free bk licence, so you indeed 
just took the important parts and this is/was explicitly verboten for 
normal bk users.

bye, Roman
