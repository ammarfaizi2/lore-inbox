Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267508AbUIAUnQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267508AbUIAUnQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Sep 2004 16:43:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267494AbUIAUnC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Sep 2004 16:43:02 -0400
Received: from mail.shareable.org ([81.29.64.88]:9162 "EHLO mail.shareable.org")
	by vger.kernel.org with ESMTP id S267508AbUIAUlj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Sep 2004 16:41:39 -0400
Date: Wed, 1 Sep 2004 21:41:30 +0100
From: Jamie Lokier <jamie@shareable.org>
To: Hans Reiser <reiser@namesys.com>
Cc: "Alexander G. M. Smith" <agmsmith@rogers.com>,
       Will Dyson <will_dyson@pobox.com>, akpm@osdl.org, hch@lst.de,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       flx@namesys.com, torvalds@osdl.org, reiserfs-list@namesys.com
Subject: Re: Separating Indexing and Searching (was silent semantic changes with reiser4)
Message-ID: <20040901204130.GH31934@mail.shareable.org>
References: <584702172685-BeMail@cr593174-a> <41310364.8070302@namesys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41310364.8070302@namesys.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hans Reiser wrote:
> Symlinks also.  Symlinks with powerful queries in them would require a 
> parser in the kernel.

No they wouldn't.  You can do symlinks with powerful queries in
userspace _today_ (as well as directories which list queries).

Making queries be up to date in real-time is still a problem, but that
has nothing to do with symlinks or directories, or where the parsers live.

> Thanks for helping me to distill my incoherent reasons for the
> parser being in the kernel.

This is one occasion where you're mistaken :)

There may be other reasons for parsing query strings in the kernel
(though I'm not convinced there are any), but this isn't one.

-- Jamie
