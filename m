Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964887AbVKOQdG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964887AbVKOQdG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Nov 2005 11:33:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964856AbVKOQdG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Nov 2005 11:33:06 -0500
Received: from mail.shareable.org ([81.29.64.88]:20645 "EHLO
	mail.shareable.org") by vger.kernel.org with ESMTP id S964852AbVKOQdE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Nov 2005 11:33:04 -0500
Date: Tue, 15 Nov 2005 16:32:46 +0000
From: Jamie Lokier <jamie@shareable.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: David Howells <dhowells@redhat.com>, akpm@osdl.org,
       linux-kernel@vger.kernel.org, linux-cachefs@redhat.com,
       linux-fsdevel@vger.kernel.org, nfsv4@linux-nfs.org
Subject: Re: [PATCH 0/12] FS-Cache: Generic filesystem caching facility
Message-ID: <20051115163246.GA4959@mail.shareable.org>
References: <dhowells1132005277@warthog.cambridge.redhat.com> <Pine.LNX.4.64.0511141428390.3263@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0511141428390.3263@g5.osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> And if it _is_ properly named (ie it really does mean "this entry
> positively does not exist") then it shouldn't have the same
> representation as NULL, because NULL really is traditionally used
> for "unknown" rather than "known to not exist".

You mean like:

> a negative dentry (dentry->d_inode = NULL) is another.

? :)

-- Jamie
