Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261299AbVDVXTC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261299AbVDVXTC (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Apr 2005 19:19:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261301AbVDVXTC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Apr 2005 19:19:02 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:63931 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S261299AbVDVXS7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Apr 2005 19:18:59 -0400
Date: Sat, 23 Apr 2005 01:18:39 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Petr Baudis <pasky@ucw.cz>
Cc: Linus Torvalds <torvalds@osdl.org>,
       kernel list <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.6.12-rc3
Message-ID: <20050422231839.GC1789@elf.ucw.cz>
References: <Pine.LNX.4.58.0504201728110.2344@ppc970.osdl.org> <20050421112022.GB2160@elf.ucw.cz> <20050421120327.GA13834@elf.ucw.cz> <20050421162220.GD30991@pasky.ji.cz> <20050421232201.GD31207@elf.ucw.cz> <20050422002150.GY7443@pasky.ji.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050422002150.GY7443@pasky.ji.cz>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > Nice, so I now have my own -git tree, with two changes in it...
> > 
> > Is there way to say "git diff -r origin:" but dump it patch-by-patch
> > with some usable headers?
> > 
> > [Looking at git export]
> 
> Either Linus' demo git-export (NOT the same as git export!), or git
> patch. In the latest tree, it was extended to accept a range of two
> commits to process too.
> 
> Note that the range semantics is rather peculiar at the least. ;-)

Nice, it seems to work.

Unfortunately first merge will make it practically unusable :-(. 

git diff -r origin:

will only list differences between my tree and Linus'.

git patch origin:

will list my patches, plus any merges I done... Is there any
reasonable way to get only "my" changes? When I do not have to resolve
anything during merge, it should be usable... but that is starting to
look ugly.


								Pavel


-- 
Boycott Kodak -- for their patent abuse against Java.
