Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261303AbVCGTQw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261303AbVCGTQw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Mar 2005 14:16:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261290AbVCGTQR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Mar 2005 14:16:17 -0500
Received: from one.firstfloor.org ([213.235.205.2]:1957 "EHLO
	one.firstfloor.org") by vger.kernel.org with ESMTP id S261296AbVCGTNT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Mar 2005 14:13:19 -0500
To: Roland McGrath <roland@redhat.com>
Cc: Daniel Jacobowitz <dan@debian.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Cagney <cagney@redhat.com>
Subject: Re: More trouble with i386 EFLAGS and ptrace
References: <Pine.LNX.4.58.0503061155280.2304@ppc970.osdl.org>
	<200503062122.j26LMP5F021846@magilla.sf.frob.com>
From: Andi Kleen <ak@muc.de>
Date: Mon, 07 Mar 2005 20:13:17 +0100
In-Reply-To: <200503062122.j26LMP5F021846@magilla.sf.frob.com> (Roland
 McGrath's message of "Sun, 6 Mar 2005 13:22:25 -0800")
Message-ID: <m1hdjnmfqq.fsf@muc.de>
User-Agent: Gnus/5.110002 (No Gnus v0.2) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Roland McGrath <roland@redhat.com> writes:
>
> I note, btw, that the x86_64 code is still at that prior stage.  So I think
> it doesn't have this new wrinkle, but it also doesn't have the advantages
> of the more recent i386 changes.  Once we're sure about the i386 state, we
> should update the x86_64 code to match.

I have it fixed in my tree, but not pushed out yet because of lack of
testing.

In general I track all i386 changes that make sense for modern systems
and 64bit, but sometimes merging takes some time.

However given the flood of bugs in the i386 code I'm starting to have
doubts again if all these changes were really a good idea.
However x86-64 has to be bug-to-bug compatible to i386, so there
is not much choice.

-Andi
