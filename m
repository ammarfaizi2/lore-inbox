Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261553AbVDJSWn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261553AbVDJSWn (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Apr 2005 14:22:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261565AbVDJSVh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Apr 2005 14:21:37 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:31158 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S261553AbVDJSUf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Apr 2005 14:20:35 -0400
Date: Sun, 10 Apr 2005 20:19:41 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Paul P Komkoff Jr <i@stingr.net>
cc: Linus Torvalds <torvalds@osdl.org>, Andrea Arcangeli <andrea@suse.de>,
       Martin Pool <mbp@sourcefrog.net>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
       David Lang <dlang@digitalinsight.com>
Subject: Re: Code snippet to reconstruct ancestry graph from bk repo
In-Reply-To: <20050410172421.GA7716@stingr.stingr.net>
Message-ID: <Pine.LNX.4.61.0504102010290.15339@scrub.home>
References: <20050407014727.GA17970@havoc.gtf.org> <pan.2005.04.07.02.25.56.501269@sourcefrog.net>
 <Pine.LNX.4.62.0504061931560.10158@qynat.qvtvafvgr.pbz> <1112852302.29544.75.camel@hope>
 <Pine.LNX.4.58.0504071626290.28951@ppc970.osdl.org> <1112939769.29544.161.camel@hope>
 <Pine.LNX.4.58.0504072334310.28951@ppc970.osdl.org> <20050408083839.GC3957@opteron.random>
 <Pine.LNX.4.58.0504081647510.28951@ppc970.osdl.org>
 <Pine.LNX.4.61.0504091547320.15339@scrub.home> <20050410172421.GA7716@stingr.stingr.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sun, 10 Apr 2005, Paul P Komkoff Jr wrote:

> (borrowed from Tommi Virtanen)
> 
> Code snippet to reconstruct ancestry graph from bk repo:
> bk changes -end':I: $if(:PARENT:){:PARENT:$if(:MPARENT:){ :MPARENT:}} $unless(:PARENT:){-}'         |tac
> 
> format is:
> newrev parent1 [parent2]
> parent2 present if merge occurs.

I know that this is possible and Larry's response would have been 
something like this:
http://www.ussg.iu.edu/hypermail/linux/kernel/0502.1/0248.html

bye, Roman
