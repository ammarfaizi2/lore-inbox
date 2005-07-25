Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261750AbVGYH5S@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261750AbVGYH5S (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Jul 2005 03:57:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261754AbVGYH5S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Jul 2005 03:57:18 -0400
Received: from 66-23-228-155.clients.speedfactory.net ([66.23.228.155]:8641
	"EHLO kevlar.burdell.org") by vger.kernel.org with ESMTP
	id S261750AbVGYH5Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Jul 2005 03:57:16 -0400
Date: Mon, 25 Jul 2005 03:56:48 -0400
From: Sonny Rao <sonny@burdell.org>
To: bert hubert <bert.hubert@netherlabs.nl>, Paul Jackson <pj@sgi.com>,
       rostedt@goodmis.org, relayfs-devel@lists.sourceforge.net,
       richardj_moore@uk.ibm.com, varap@us.ibm.com, karim@opersys.com,
       linux-kernel@vger.kernel.org, zanussi@us.ibm.com
Subject: Re: diskstat 0.1: simple tool to study io patterns via relayfs
Message-ID: <20050725075648.GA32238@kevlar.burdell.org>
References: <20050724010730.GA22104@outpost.ds9a.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050724010730.GA22104@outpost.ds9a.nl>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 24, 2005 at 03:07:30AM +0200, bert hubert wrote:
> It is with distinct lack of pride that I release version 0.1 of diskstat
> 'Geeks in Black Thorn', a tool that allows you to generate the kinds of
> graphs as presented in my OLS talk 'On faster application startup times:
> Cache stuffing, seek profiling, adaptive preloading'. The lack of pride is
> because this release is more a promise of what is to come than how things
> should be.
> 
> The presentation, paper, and software can be found on
> http://ds9a.nl/diskstat and
> http://ds9a.nl/diskstat/diskstat-0.1.tar.gz
> 
> >From the README:
> The quality of this code is abysmal, for which I squarely blame the fun
> people at OLS who've been keeping me from my code!
> (...)
> The next version will be based on k/jprobes, and will make better use of
> relayfs features. This also means you won't have to patch your kernel
> anymore, as long as you compiled with kprobes support.

Hi, I had some trouble compiling it, I figured out that one needs
libboost, but then I've also discovered that g++-3.4.4 and g++-4.0.1
don't want to compile it while g++-3.3.5 works.  (FYI, all of these were
Ubuntu versions)

You might want to document some of this in the README :)

Thanks,
Sonny
