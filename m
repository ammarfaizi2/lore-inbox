Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268196AbUHXSmz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268196AbUHXSmz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Aug 2004 14:42:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268206AbUHXSmz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Aug 2004 14:42:55 -0400
Received: from waste.org ([209.173.204.2]:53462 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S268196AbUHXSmx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Aug 2004 14:42:53 -0400
Date: Tue, 24 Aug 2004 13:42:45 -0500
From: Matt Mackall <mpm@selenic.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.6.9-rc1
Message-ID: <20040824184245.GE5414@waste.org>
References: <Pine.LNX.4.58.0408240031560.17766@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0408240031560.17766@ppc970.osdl.org>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 24, 2004 at 12:49:24AM -0700, Linus Torvalds wrote:
> Administrative trivia, and one thing I agonized over: should I make the
> patches relative to 2.6.8 or 2.6.8.1? I decided that since there is
> nothing that says that a "basic bug-fix" releases for a previous release
> might not happen _after_ we've done a -rc release for the next version, I
> can't sanely do patches against a bugfix release.
> 
> Thus the 2.6.9-rc1 patch is against plain 2.6.8. If you have 2.6.8.1, you
> need to undo the .1 patch, and apply the big one. BK users and tar-balls 
> don't see that particular confusion, of course ;)

Phew, I was worried about that. Can I get a ruling on how you intend
to handle a x.y.z.1 to x.y.z.2 transition? I've got a tool that I'm
looking to unbreak. My preference would be for all x.y.z.n patches to
be relative to x.y.z.

-- 
Mathematics is the supreme nostalgia of our time.
