Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264182AbUDGSRh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Apr 2004 14:17:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264173AbUDGSOw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Apr 2004 14:14:52 -0400
Received: from fork1.mail.Virginia.EDU ([128.143.2.191]:16100 "EHLO
	cms.mail.virginia.edu") by vger.kernel.org with ESMTP
	id S264142AbUDGSMr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Apr 2004 14:12:47 -0400
Message-ID: <40744481.7050002@virginia.edu>
Date: Wed, 07 Apr 2004 14:12:17 -0400
From: Aaron Smith <aws4y@virginia.edu>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040113
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: Rewrite Kernel
References: <20040407125406.209FC39834A@ws5-1.us4.outblaze.com> <1081348038.5049.6.camel@redeeman.linux.dk> <200404071455.i37EtOn8000182@81-2-122-30.bradfords.org.uk> <20040407150516.GC23517@marowsky-bree.de>
In-Reply-To: <20040407150516.GC23517@marowsky-bree.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lars Marowsky-Bree wrote:

>Guys, gals,
>
>you are all missing the point.
>
>It is obvious that what we really need is a hand-optimized in-kernel
>core LISP machine written in >i386 assembly, then we need to port the
>rest of the kernel to run as LISP bytecode on top of that in ring1 (in
>particular the security policies).
>
>Of course, important privileged user-space such as glibc should be
>ported to this highly efficient non-recursive LISP machine too for
>efficiency and run on ring 2 for speed and security.
>  
>
What you are talking about is a LISP machine micro-kernel in Ring0 which 
sort of defeats the whole point of Linux being monolithic kernel. Also 
couldn't we just run HURD, or for that matter EMACS ;-), as a kernel. I, 
personally have come around to Linus point of view on the whole 
micro-kernel thing so I don't see much of a advantage to this, as there 
are other micro kernel projects ( HURD, Darwin/*BSD?).

-Aaron
