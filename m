Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261371AbUJ3WZ6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261371AbUJ3WZ6 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Oct 2004 18:25:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261367AbUJ3WZ5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Oct 2004 18:25:57 -0400
Received: from mustang.oldcity.dca.net ([216.158.38.3]:43717 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S261363AbUJ3WZl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Oct 2004 18:25:41 -0400
Subject: Re: code bloat [was Re: Semaphore assembly-code bug]
From: Lee Revell <rlrevell@joe-job.com>
To: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Cc: Linus Torvalds <torvalds@osdl.org>, Andi Kleen <ak@suse.de>,
       linux-kernel@vger.kernel.org
In-Reply-To: <200410310111.07086.vda@port.imtp.ilyichevsk.odessa.ua>
References: <417550FB.8020404@drdos.com.suse.lists.linux.kernel>
	 <200410310000.38019.vda@port.imtp.ilyichevsk.odessa.ua>
	 <1099170891.1424.1.camel@krustophenia.net>
	 <200410310111.07086.vda@port.imtp.ilyichevsk.odessa.ua>
Content-Type: text/plain
Date: Sat, 30 Oct 2004 18:25:38 -0400
Message-Id: <1099175138.1424.18.camel@krustophenia.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2004-10-31 at 01:11 +0300, Denis Vlasenko wrote:
> Well, I can try to compile packages with different options
> for size, I can link against small libc, but I feel this
> does not solve the problem: the code itself is bloated...
> 
> I am not a code genius, but want to help.
> 
> Hmm probably some bloat-detection tools would be helpful,
> like "show me source_lines/object_size ratios of fonctions in
> this ELF object file". Those with low ratio are suspects of
> excessive inlining etc.
> 
> More ideas, anyone?

I ageww it's a hard problem.  Right now there is massive pressure on
Linux application developers to add features to catch up with MS and
Apple.  This inevitably leads to bloat, we all know that efficiency is
the first thing to go out the window in that situation, the problem is
exacerbated by the wide availability of fast machines.  It's an old,
depressing story...

That being said it would indeed be nice if we had more tools to quantify
bloat. 

Lee

