Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262790AbTLDBDk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Dec 2003 20:03:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262795AbTLDBDk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Dec 2003 20:03:40 -0500
Received: from warden-p.diginsite.com ([208.29.163.248]:63169 "HELO
	warden.diginsite.com") by vger.kernel.org with SMTP id S262790AbTLDBDe
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Dec 2003 20:03:34 -0500
From: David Lang <david.lang@digitalinsight.com>
To: Aaron Smith <aws4y@virginia.edu>
Cc: linux-kernel@vger.kernel.org
Date: Wed, 3 Dec 2003 17:47:45 -0800 (PST)
Subject: Re: Linux GPL and binary module exception clause?
In-Reply-To: <3FCE854A.70404@virginia.edu>
Message-ID: <Pine.LNX.4.58.0312031742150.8229@dlang.diginsite.com>
References: <3FCDE5CA.2543.3E4EE6AA@localhost> <Pine.LNX.4.58.0312031533530.2055@home.osdl.org>
 <3FCE854A.70404@virginia.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

there is no way to taint something so much that it's no longer covered by
the GPL (if it was that would mean that you have no legal way to have a
copy of it).

Remember that the GPL doesn't put any restrictions on what you do with the
code as long as you are not distributing it.

becouse of this you could take the kernel and include any propriatary code
in it that you want and run it. You don't even need to use modules, just
paste in th code and compile (make sure you have a legal right to the code
you are pasting in though :-)

the GPL comes in when you distribute it (and even here there are grey
areas, does it count as distributing code to put it on a companies
desktops for example?, but if you sell it or incude it in a product that
you sell you definantly do have to release the source)

if you are talking about the 'tainted' flag in the kernel, that is just a
flag that you should not expect to get support for this configuration
from the opensource developers.

does this answer your question?

David Lang

On Wed, 3 Dec 2003, Aaron Smith wrote:

> Date: Wed, 03 Dec 2003 19:52:26 -0500
> From: Aaron Smith <aws4y@virginia.edu>
> To: linux-kernel@vger.kernel.org
> Subject: Re: Linux GPL and binary module exception clause?
>
>
> >So being a module is not a sign of not being a derived work. It's just
> >one sign that _maybe_ it might have other arguments for why it isn't
> >derived.
> >
> >		Linus
> >
> >
> My question is a natural extension of this point and subsequent posts,
> When is a kernel so tainted it can no longer be considered GPL, or can
> no longer be considered free software? I write software for astronomical
> applications where some vendors give binary only drivers, or give you
> restricted access to the source code so I will some times load 5 or 6
> devices that are binary only or at least non GPL. So what taint is
> allowable?
>
> Thanks,
> Aaron Smith
> Virginia Astronomical Instrumentation Laboratory
> Programmer
>
> PS sorry if this is a stupid question.
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

-- 
"Debugging is twice as hard as writing the code in the first place.
Therefore, if you write the code as cleverly as possible, you are,
by definition, not smart enough to debug it." - Brian W. Kernighan
