Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269761AbUH0Axf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269761AbUH0Axf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Aug 2004 20:53:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269794AbUH0AuV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Aug 2004 20:50:21 -0400
Received: from fw.osdl.org ([65.172.181.6]:9951 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S269871AbUH0AnE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Aug 2004 20:43:04 -0400
Date: Thu, 26 Aug 2004 17:42:53 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: David Howells <dhowells@redhat.com>
cc: Andrew Morton <akpm@osdl.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>, steved@redhat.com,
       dwmw2@redhat.com
Subject: Re: [PATCH] CacheFS - general filesystem cache
In-Reply-To: <17777.1093566183@redhat.com>
Message-ID: <Pine.LNX.4.58.0408261730070.2304@ppc970.osdl.org>
References: <17777.1093566183@redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 27 Aug 2004, David Howells wrote:
> 
>     (4) cachefs-doc-2681mm4.diff
> 
> 	Documentation about using cachefs.

Heh:

      Three levels of indirection are currently supported:

       - single indirection
       - double indirection

somebody has trouble counting.

More seriously, I'd _really_ love to see something like a "swapfs", ie 
tmpfs with cachefs as a backing store. It would be a lot more useful for 
testing that AFS+cachefs, and would hopefully also act as a example of how 
to use it _without_ having to worry about AFS.

Is that possible?

		Linus
