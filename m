Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261892AbTILU6j (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Sep 2003 16:58:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261894AbTILU6j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Sep 2003 16:58:39 -0400
Received: from kinesis.swishmail.com ([209.10.110.86]:50696 "HELO
	kinesis.swishmail.com") by vger.kernel.org with SMTP
	id S261892AbTILU6h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Sep 2003 16:58:37 -0400
Message-ID: <3F62335B.9050202@techsource.com>
Date: Fri, 12 Sep 2003 16:58:03 -0400
From: Timothy Miller <miller@techsource.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20020823 Netscape/7.0
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: David Schwartz <davids@webmaster.com>
CC: Pascal Schmidt <der.eremit@email.de>, linux-kernel@vger.kernel.org
Subject: Re: People, not GPL  [was: Re: Driver Model]
References: <MDEHLPKNGKAHNMBLJOLKAEIKGHAA.davids@webmaster.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



David Schwartz wrote:

> 	However, some people seem to be arguing that the GPL_ONLY symbols are in
> fact a license enforcement technique. If that's true, then when they
> distribute their code, they are putting additional restrictions not in the
> GPL on it. That is a GPL violation.

Agreed.  GPL_ONLY is not a license restriction.  It is a technical issue.

Binary-only modules are inherently untrustworthy (no open code review) 
and undebuggable.  It is therefore of technical merit to restrict both 
what they can access in the kernel (GPL_ONLY) and limit how much kernel 
developers should have to tolerate when they're involved.

But beyond this, there are some social issues.  If someone finds a way 
to work around this mechanism, they are breaking things to everyone 
else's detriment.  For a commercial entity to violate the GPL_ONLY 
barrier is an insult to kernel developers AND to their customers who 
will have trouble getting problems solved.

So, if a company works around GPL_ONLY, are they violating the GPL 
license?  Probably not.  Does that make it OKAY?  Probably not.

This is like finding a way to give a user space program access to kernel 
resources.  There are barriers put in place for a REASON because people 
make mistakes when they write software.  If no one did, we wouldn't have 
any need for memory protection, would we.


