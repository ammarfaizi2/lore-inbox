Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262604AbVAUXvn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262604AbVAUXvn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Jan 2005 18:51:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262619AbVAUXsz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Jan 2005 18:48:55 -0500
Received: from news.suse.de ([195.135.220.2]:9965 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S262610AbVAUXqS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Jan 2005 18:46:18 -0500
Subject: Re: [ea-in-inode 0/5] Further fixes
From: Andreas Gruenbacher <agruen@suse.de>
To: "Stephen C. Tweedie" <sct@redhat.com>
Cc: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       "Theodore Ts'o" <tytso@mit.edu>, Andrew Tridgell <tridge@osdl.org>,
       Andreas Dilger <adilger@clusterfs.com>, Alex Tomas <alex@clusterfs.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <1106348336.1989.484.camel@sisko.sctweedie.blueyonder.co.uk>
References: <20050120020124.110155000@suse.de>
	 <1106348336.1989.484.camel@sisko.sctweedie.blueyonder.co.uk>
Content-Type: text/plain
Organization: SUSE Labs
Message-Id: <1106351172.19651.102.camel@winden.suse.de>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Sat, 22 Jan 2005 00:46:12 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-01-21 at 23:58, Stephen C. Tweedie wrote:
> Hi Andreas,
> 
> On Thu, 2005-01-20 at 02:01, Andreas Gruenbacher wrote:
> 
> > here is a set of fixes for ext3 in-inode attributes:
> 
> Obvious first question --- have these diffs survived the same
> torture-by-tridgell that the previous batch suffered?

No. The fixes are a lot less intrusive than the full xattr rework
though. I obviously ran tests; this included dbench.

Tridge, can you beat the code some more?

Andrew has the five fixes in 2.6.11-rc1-mm2.

-- Andreas.

