Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262700AbTJDTOR (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Oct 2003 15:14:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262703AbTJDTOQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Oct 2003 15:14:16 -0400
Received: from nat-pool-bos.redhat.com ([66.187.230.200]:34150 "EHLO
	chimarrao.boston.redhat.com") by vger.kernel.org with ESMTP
	id S262700AbTJDTOP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Oct 2003 15:14:15 -0400
Date: Sat, 4 Oct 2003 15:14:14 -0400 (EDT)
From: Rik van Riel <riel@redhat.com>
X-X-Sender: riel@chimarrao.boston.redhat.com
To: David Ashley <dash@xdr.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Idea for improving linux buffer cache behaviour
In-Reply-To: <200310041534.h94FYv0X007015@xdr.com>
Message-ID: <Pine.LNX.4.44.0310041513150.14750-100000@chimarrao.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 4 Oct 2003, David Ashley wrote:

> Forgive me if this has already been thought of, or is obsolete, or is
> just plain a bad idea, but here it is:

Do you also want an answer if the kernel already does
exactly what you are suggesting ? ;)

> 1) Lowest access count looked at first to toss
> 2) If access counts equal, throw out oldest first

> The net result is commonly used items you very much want to remain in
> cache always quickly get rated very highly as the system is used.

Which results in exactly the behaviour you're complaining
about ;))

-- 
"Debugging is twice as hard as writing the code in the first place.
Therefore, if you write the code as cleverly as possible, you are,
by definition, not smart enough to debug it." - Brian W. Kernighan

