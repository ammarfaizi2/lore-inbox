Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268726AbUHUAMk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268726AbUHUAMk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Aug 2004 20:12:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268731AbUHUAMj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Aug 2004 20:12:39 -0400
Received: from mx1.redhat.com ([66.187.233.31]:31386 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S268726AbUHUAMi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Aug 2004 20:12:38 -0400
Date: Fri, 20 Aug 2004 20:12:32 -0400 (EDT)
From: Rik van Riel <riel@redhat.com>
X-X-Sender: riel@chimarrao.boston.redhat.com
To: Andrew Morton <akpm@osdl.org>
cc: Anton Blanchard <anton@samba.org>, <linux-kernel@vger.kernel.org>,
       <reiserfs-dev@namesys.com>
Subject: Re: 2.6.8.1-mm2 - reiser4
In-Reply-To: <20040820163426.2c6d4cb8.akpm@osdl.org>
Message-ID: <Pine.LNX.4.44.0408202012070.5028-100000@chimarrao.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 20 Aug 2004, Andrew Morton wrote:

> It's my understanding that sys_reiser4() is basically defunct at this point.

Yay!

> For review purposes it would be better if the syscall code and all the
> namesys debug support code simply weren't present in the patch.  But one
> can sympathise with the need to keep it there for the time being.  Please
> just read around it.

Agreed, the rest of the code has enough issues and we should
focus on those first.

-- 
"Debugging is twice as hard as writing the code in the first place.
Therefore, if you write the code as cleverly as possible, you are,
by definition, not smart enough to debug it." - Brian W. Kernighan

