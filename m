Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262566AbVAJVKf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262566AbVAJVKf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jan 2005 16:10:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262555AbVAJVKA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jan 2005 16:10:00 -0500
Received: from waste.org ([216.27.176.166]:60092 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S262542AbVAJVHI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jan 2005 16:07:08 -0500
Date: Mon, 10 Jan 2005 13:05:31 -0800
From: Matt Mackall <mpm@selenic.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Valdis.Kletnieks@vt.edu, chrisw@osdl.org, rlrevell@joe-job.com,
       paul@linuxaudiosystems.com, arjanv@redhat.com, hch@infradead.org,
       mingo@elte.hu, alan@lxorguk.ukuu.org.uk, joq@io.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [request for inclusion] Realtime LSM
Message-ID: <20050110210531.GF2995@waste.org>
References: <200501071620.j07GKrIa018718@localhost.localdomain> <1105132348.20278.88.camel@krustophenia.net> <20050107134941.11cecbfc.akpm@osdl.org> <200501072207.j07M7Lda004987@turing-police.cc.vt.edu> <20050107143638.L2357@build.pdx.osdl.net> <200501072301.j07N1TW2027950@turing-police.cc.vt.edu> <20050107152004.0f8c488e.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050107152004.0f8c488e.akpm@osdl.org>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 07, 2005 at 03:20:04PM -0800, Andrew Morton wrote:
> Valdis.Kletnieks@vt.edu wrote:
> >
> > fix the inheritance problems
> 
> Does anyone actually have a handle on what's involved in fixing the
> inheritance problem?

Probably not, in the sense that it's a complex enough problem that
something will likely to be found to be fatally flawed a year down the
road. Just like the situation we're in now.
 
> It's risky, but it is something which we should do.
> 
> <grumpytroll> We really shouldn't have merged all that new fancy security
> stuff when the existing security framework was known-badly-broken. 
> Especially as the new stuff seems incapable of doing simple things which
> unbroken inherited caps would do perfectly.</grumpytroll>

It's taken some decades to ferret out all the gotchas of the standard
UNIX permission model. None of this fancy new stuff is "simpler" by
any stretch, so expect it to be quite some time before all the
implications of any of them are completely understood.

-- 
Mathematics is the supreme nostalgia of our time.
