Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316342AbSETUMT>; Mon, 20 May 2002 16:12:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316346AbSETUMS>; Mon, 20 May 2002 16:12:18 -0400
Received: from beach.cise.ufl.edu ([128.227.205.211]:20369 "EHLO
	mail.cise.ufl.edu") by vger.kernel.org with ESMTP
	id <S316342AbSETUMS>; Mon, 20 May 2002 16:12:18 -0400
Date: Mon, 20 May 2002 16:12:18 -0400 (EDT)
From: Pradeep Padala <ppadala@cise.ufl.edu>
To: "David S. Miller" <davem@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: No PTRACE_READDATA for archs other than SPARC?
In-Reply-To: <20020519.214053.19164382.davem@redhat.com>
Message-ID: <Pine.GSO.4.05.10205201607350.13502-100000@sun114-01.cise.ufl.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Only Sparc implements this, that is correct.
> 
> If other platforms added PTRACE_READDATA support, they would
> also need to add some way to do a feature test for it's presence
> so that GDB and other debugging code could actually make use
> of it portably.

You mean, it's an undocumented feature for sparc?

If I want to add it to i386, what do I need to add so that
gdb/debuggers know that the feature exists.


> The return values are set directly in the user's pt_regs.

I get it. Thanx for the info

--pradeep

