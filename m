Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268253AbUHXTmj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268253AbUHXTmj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Aug 2004 15:42:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268248AbUHXTmi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Aug 2004 15:42:38 -0400
Received: from prime.hereintown.net ([141.157.132.3]:42920 "EHLO
	prime.hereintown.net") by vger.kernel.org with ESMTP
	id S268253AbUHXTkn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Aug 2004 15:40:43 -0400
Subject: Re: Linux 2.6.9-rc1
From: Chris Meadors <clubneon@hereintown.net>
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Matt Mackall <mpm@selenic.com>, Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0408241221390.17766@ppc970.osdl.org>
References: <Pine.LNX.4.58.0408240031560.17766@ppc970.osdl.org>
	 <20040824184245.GE5414@waste.org>
	 <Pine.LNX.4.58.0408241221390.17766@ppc970.osdl.org>
Content-Type: text/plain
Message-Id: <1093376321.1151.15.camel@clubneon.priv.hereintown.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.5.6.2 
Date: Tue, 24 Aug 2004 15:38:41 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-08-24 at 12:23 -0700, Linus Torvalds wrote:
> 
> Hmm.. I have no strong preferences. There _is_ obviously a well-defined 
> ordering from x.y.z.1 -> x.y.z.2 (unlike the -rcX releases that don't have 
> any ordering wrt the bugfixes), so either interdiffs or whole new full 
> diffs are totally "logical". We just have to chose one way or the other, 
> and I don't actually much care.
> 
> Any reason for your preference? 

I'm not the original poster, but after a little thought I agreed with
his preference.  If the -rcs are going to be based on the non-bugfixed
releases, it follows that the next full patch will also have to be off
of the previous full release.

If each bugfix built on the last, instead of the full release, that
would be a number of patch files that I'd have to keep around, and then
undo when patching up to the next release.  If each bugfix included all
the previous bugfixes, it would just be one patch I'd have to undo.

-- 
Chris

