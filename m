Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262214AbVDLWeE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262214AbVDLWeE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Apr 2005 18:34:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262354AbVDLWa3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Apr 2005 18:30:29 -0400
Received: from khc.piap.pl ([195.187.100.11]:4100 "EHLO khc.piap.pl")
	by vger.kernel.org with ESMTP id S263015AbVDLW3O (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Apr 2005 18:29:14 -0400
To: Linus Torvalds <torvalds@osdl.org>
Cc: David Eger <eger@havoc.gtf.org>, Petr Baudis <pasky@ucw.cz>,
       "Randy.Dunlap" <rddunlap@osdl.org>,
       Ross Vandegrift <ross@jose.lug.udel.edu>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: more git updates..
References: <Pine.LNX.4.58.0504091208470.6947@ppc970.osdl.org>
	<20050409200709.GC3451@pasky.ji.cz>
	<Pine.LNX.4.58.0504091320490.1267@ppc970.osdl.org>
	<Pine.LNX.4.58.0504091404350.1267@ppc970.osdl.org>
	<Pine.LNX.4.58.0504091617000.1267@ppc970.osdl.org>
	<20050412040519.GA17917@havoc.gtf.org>
	<20050412081613.GA18545@pasky.ji.cz>
	<20050412204429.GA24910@havoc.gtf.org>
	<Pine.LNX.4.58.0504121411030.4501@ppc970.osdl.org>
From: Krzysztof Halasa <khc@pm.waw.pl>
Date: Wed, 13 Apr 2005 00:29:12 +0200
In-Reply-To: <Pine.LNX.4.58.0504121411030.4501@ppc970.osdl.org> (Linus
 Torvalds's message of "Tue, 12 Apr 2005 14:21:58 -0700 (PDT)")
Message-ID: <m33btvhbnr.fsf@defiant.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds <torvalds@osdl.org> writes:

> The full .git archive for 199 versions of the kernel (the 2.6.12-rc2 one
> and a test-run of 198 patches from Andrew) is 111MB. In other words,
> adding 198 "full" new kernels only grew the archive by 9MB (that's all
> "actual disk usage" btw - the files themselves are smaller, but since they
> all end up taking up a full disk block..)

Does that mean that the 64 K changes imported from bk would take ~ 3 GB?
Is that real?

Have to tried to import it?
I'm going to import the CVS data (with cvsps) - as the CVS "misses" half
the changes, the resulting archive should be half in size too?

I don't know how much space did bk use, but 3 GB for the full history
is reasonable for most people, isn't it? Especially that one can purge
older data.
-- 
Krzysztof Halasa
