Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261732AbUK2PjY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261732AbUK2PjY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Nov 2004 10:39:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261730AbUK2PjY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Nov 2004 10:39:24 -0500
Received: from bgm-24-94-59-124.stny.rr.com ([24.94.59.124]:49830 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S261732AbUK2PgH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Nov 2004 10:36:07 -0500
Subject: Re: [PATCH][RFC] dynamic syscalls revisited
From: Steven Rostedt <rostedt@goodmis.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20041129151741.GA5514@infradead.org>
References: <1101741118.25841.40.camel@localhost.localdomain>
	 <20041129151741.GA5514@infradead.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: Kihon Technologies
Date: Mon, 29 Nov 2004 10:36:02 -0500
Message-Id: <1101742562.25841.47.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-11-29 at 15:17 +0000, Christoph Hellwig wrote:
> 
> Actually they were dumped because dynamically syscalls are a really bad
> idea, not because of implementation issues.
> 

Yes, for most cases they are.  But the implementation for them seemed to
be too intrusive for the special case. This solution is not so
intrusive, and can easily be compiled out. As I said, they are nice to
have for a quick debugging, and may have other uses as well. The times I
wished for them, was usually debugging a module and I didn't want to
recompile the kernel and reboot. So instead I made awful hacks into the
proc system or some make believe device to interface with.

I'm just putting this out for others to use. If it doesn't get into the
kernel, then so be it, but since this is not so intrusive, and can
easily be used on all architectures, then the patch can surely help
others.

-- Steve

