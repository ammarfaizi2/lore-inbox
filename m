Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261736AbVDKIvF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261736AbVDKIvF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Apr 2005 04:51:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261738AbVDKIvF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Apr 2005 04:51:05 -0400
Received: from mx1.elte.hu ([157.181.1.137]:51689 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S261736AbVDKIu7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Apr 2005 04:50:59 -0400
Date: Mon, 11 Apr 2005 10:50:51 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Petr Baudis <pasky@ucw.cz>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>, "Randy.Dunlap" <rddunlap@osdl.org>,
       Ross Vandegrift <ross@jose.lug.udel.edu>
Subject: Re: [ANNOUNCE] git-pasky-0.2
Message-ID: <20050411085051.GA8893@elte.hu>
References: <Pine.LNX.4.58.0504091208470.6947@ppc970.osdl.org> <20050409200709.GC3451@pasky.ji.cz> <Pine.LNX.4.58.0504091320490.1267@ppc970.osdl.org> <Pine.LNX.4.58.0504091404350.1267@ppc970.osdl.org> <Pine.LNX.4.58.0504091617000.1267@ppc970.osdl.org> <20050410024157.GE3451@pasky.ji.cz> <20050410162723.GC26537@pasky.ji.cz> <20050411015852.GI5902@pasky.ji.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050411015852.GI5902@pasky.ji.cz>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Petr Baudis <pasky@ucw.cz> wrote:

>   Hello,
> 
>   here goes git-pasky-0.2, my set of patches and scripts upon Linus' 
> git, aimed at human usability and to an extent a SCM-like usage.

works fine on FC4, i only minor issues: 'git' in the tarball didnt have 
the x permission. Also, your scripts assume they are in $PATH. When 
trying out a tarball one doesnt usually do a 'make install' but tries 
stuff locally. Also, 'make install' doesnt seem to install the git 
script itself, is that intentional?

	Ingo
