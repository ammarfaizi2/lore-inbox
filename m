Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263062AbUFFI14@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263062AbUFFI14 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Jun 2004 04:27:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263079AbUFFI14
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Jun 2004 04:27:56 -0400
Received: from mail.codeweavers.com ([216.251.189.131]:20643 "EHLO
	mail.codeweavers.com") by vger.kernel.org with ESMTP
	id S263062AbUFFI1y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Jun 2004 04:27:54 -0400
Message-ID: <40C2E5DC.8000109@codeweavers.com>
Date: Sun, 06 Jun 2004 18:37:32 +0900
From: Mike McCormack <mike@codeweavers.com>
Organization: Codeweavers
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7) Gecko/20040514
X-Accept-Language: en, en-us
MIME-Version: 1.0
To: Christoph Hellwig <hch@infradead.org>
CC: mingo@elte.hu, linux-kernel@vger.kernel.org
Subject: Re: WINE + NX (No eXecute) support for x86, 2.6.7-rc2-bk2
References: <40C2B51C.9030203@codeweavers.com> <20040606073241.GA6214@infradead.org> <40C2E045.8090708@codeweavers.com> <20040606081021.GA6463@infradead.org>
In-Reply-To: <20040606081021.GA6463@infradead.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Christoph Hellwig wrote:

> Huh?  binfmts do work on all linux architectures unchanged.  What you do
> on other operating systems is up to you.  And btw, netbsd already has
> binfmt_pecoff, you could certainly make use of that, too.

Working on only two platforms is not really what I'd call portable.

> _You_ are relying on undocumented assumptions here.   Windows has different
> address space layouts than ELF ABI systems and I think you're much better
> off having your own pecoff loader for that.

True, we are relying on undocumented assumptions.  On the other hand, 
there's plenty of programs that rely on undocumented assumptions. 
Binary compatability to me means that the same binary will work even 
when the underlying system changes... is there a caveat that I missed?

>>It seems Linus's kernel does that quite well, but some vendors seem not 
>>to care too much about breaking Wine.
> 
> 
> Why should they?  You need to fix up the broken assumptions in wine.

If you don't care about binary compatability, you can change whatever 
you like.  At least some people out there seem to care about it.

Mike
