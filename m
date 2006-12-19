Return-Path: <linux-kernel-owner+w=401wt.eu-S932678AbWLSIv4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932678AbWLSIv4 (ORCPT <rfc822;w@1wt.eu>);
	Tue, 19 Dec 2006 03:51:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932690AbWLSIvz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Dec 2006 03:51:55 -0500
Received: from torres.zugschlus.de ([85.10.211.154]:3199 "EHLO
	torres.zugschlus.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932678AbWLSIvy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Dec 2006 03:51:54 -0500
Date: Tue, 19 Dec 2006 09:51:49 +0100
From: Marc Haber <mh+linux-kernel@zugschlus.de>
To: Andrew Morton <akpm@osdl.org>
Cc: Nick Piggin <nickpiggin@yahoo.com.au>, Linus Torvalds <torvalds@osdl.org>,
       andrei.popa@i-neo.ro,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Peter Zijlstra <a.p.zijlstra@chello.nl>,
       Hugh Dickins <hugh@veritas.com>, Florian Weimer <fw@deneb.enyo.de>,
       Martin Michlmayr <tbm@cyrius.com>
Subject: Re: 2.6.19 file content corruption on ext3
Message-ID: <20061219085149.GA20442@torres.l21.ma.zugschlus.de>
References: <1166314399.7018.6.camel@localhost> <20061217040620.91dac272.akpm@osdl.org> <1166362772.8593.2.camel@localhost> <20061217154026.219b294f.akpm@osdl.org> <Pine.LNX.4.64.0612171716510.3479@woody.osdl.org> <Pine.LNX.4.64.0612171725110.3479@woody.osdl.org> <Pine.LNX.4.64.0612171744360.3479@woody.osdl.org> <45861E68.3060403@yahoo.com.au> <20061217214308.62b9021a.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061217214308.62b9021a.akpm@osdl.org>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 17, 2006 at 09:43:08PM -0800, Andrew Morton wrote:
> Six hours here of fsx-linux plus high memory pressure on SMP on 1k
> blocksize ext3, mainline.  Zero failures.  It's unlikely that this testing
> would pass, yet people running normal workloads are able to easily trigger
> failures.  I suspect we're looking in the wrong place.

I do not have a clue about memory management at all, but is it
possible that you're testing on a box with too much memory? My box has
only 256 MB, and I used to use mutt with a _huge_ inbox with mutt
taking somewhat 150 MB. Add spamassassin and a reasonably busy mail
server, and the box used to be like 150 MB in swap.

I have tidied my inbox in the mean time and mutt's memory requirement
has been reduced to somewhat 30 MB, which might be the cause that I
don't see the issue that often any more.

Greetings
Marc, just trying to give input

-- 
-----------------------------------------------------------------------------
Marc Haber         | "I don't trust Computers. They | Mailadresse im Header
Mannheim, Germany  |  lose things."    Winona Ryder | Fon: *49 621 72739834
Nordisch by Nature |  How to make an American Quilt | Fax: *49 621 72739835
