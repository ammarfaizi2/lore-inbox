Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265928AbUAVHir (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jan 2004 02:38:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265951AbUAVHiq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jan 2004 02:38:46 -0500
Received: from imf24aec.mail.bellsouth.net ([205.152.59.72]:40361 "EHLO
	imf24aec.mail.bellsouth.net") by vger.kernel.org with ESMTP
	id S265928AbUAVHik (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jan 2004 02:38:40 -0500
Date: Thu, 22 Jan 2004 02:37:16 -0500
From: David Meybohm <dmeybohm@bellsouth.net>
To: David Schwartz <davids@webmaster.com>
Cc: Misshielle Wong <mwl@bajoo.net>, linux-kernel@vger.kernel.org
Subject: Re: License question
Mail-Followup-To: David Schwartz <davids@webmaster.com>,
	Misshielle Wong <mwl@bajoo.net>, linux-kernel@vger.kernel.org
References: <opr1z8vu11q5eh14@localhost> <MDEHLPKNGKAHNMBLJOLKAEIJJKAA.davids@webmaster.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MDEHLPKNGKAHNMBLJOLKAEIJJKAA.davids@webmaster.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20030927
Message-Id: <20040122073840.PWPU1911.imf24aec.mail.bellsouth.net@[68.156.236.85]>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

On Mon, Jan 19, 2004 at 02:05:30AM -0800, David Schwartz wrote:
>
> > 1. Redistributions of source code must retain the above copyright notice, 
> > this list of conditions and the following disclaimer.
> 
> 	The problem is the "this list of conditions". Please show me where the GPL permits you to have a list of restrictions (other than the GPL itself) that people are prohibited from removing when they distribute the work.

(IANAL && IMHO)

You're right that no additional restrictions are allowed, and at first
glance I agreed with you that they are incompatible.  Now I will argue
the opposite, that code disbtributed under the BSD license without the
advertising clause does not impose any additional restrictions when also
distributed under the GPL.

My argument hinges on the definition of "appropriate copyright notice"
from the GPL:

	  1. You may copy and distribute verbatim copies of the Program's
	source code as you receive it, in any medium, provided that you
	conspicuously and appropriately publish on each copy an appropriate
	copyright notice and disclaimer of warranty; keep intact all the
	notices that refer to this License and to the absence of any warranty;
	and give any other recipients of the Program a copy of this License
	along with the Program.

I would define an "appropriate copyright notice" to be what is included
at the tops of files for many GPL'd programs ("(C) Copyright 2004 Me
This program is free software.  You may distribute it under the GPL.").
The notice required by the #1 clause in the BSD no-advert license seems
to be a copyright symbol with attribution and then a summary of the
rights available for the code in question.

Your interpretation on combining the two licenses hinges on being able
to modify the copyright terms (which may grant additional rights -- in
the no-advert case, it does so through omission), distribute under the
GPL, and still remain "appropriate".  If it is invalid to do so under
the GPL, then it is not an additional restriction that when combining
the two you must keep the some specific conditions due to the no-advert
BSD license.  The question is, does the GPL definition of an appropriate
notice _become_ what the no-advert license conditions are (and hence
disallowing their removal), because that's the license the code is
distributed under (assuming this was originally distributed under the
BSD license, code licensed from the start as GPL/BSD left as an
exercise), and so those are the terms that should be displayed in an
appropriate copyright notice?

I think it would, as it would be inappropriate to modify the terms under
which the code may be manipulated, which is located directly after the
copyright notice, and still claim legitimacy (also, it is probably not
kosher to put false copyright notices there).  So this becomes
compatible with the GPL, because the notice itself and the terms under
which the code may be used in their entirety is the only thing that
constitutes an "appropriate" copyright notice.  That the terms in the
notice are unmodifable is in agreement with both licenses, but only in
their combination: because if you don't own the copyright you can't
modify those terms in a significant way and produce a copyright notice
that is still appropriate enough to satisfy the GPL.

So while a GPL program may allow you to change the text of the
conditions at the top of each GPL'd file, a GPL/BSD dual-licensed
program would not when the BSD conditions blanket the code in question,
because the GPL's definition of "appropriate" changes within the scope
of the dual-license, to whatever additional conditions apply to the code
distributed to produce an appropriate notice.

This doesn't mean you can't add names to the copyright list, which
happens under both licenses.  It probably does mean a no-advert BSD
license program would not be able to remove any notices from files that
still contained any code copyright that person.  The GPL is probably the
same, but is more flexible and ambiguous, so you may include someone's
name somewhere else and say that is "appropriate" enough of a notice.

> > 2. Redistributions in binary form must reproduce the above copyright 
> > notice, this list of conditions and the following disclaimer in the 
> > documentation and/or other materials provided with the distribution.
> 
> 	Again, please show me the GPL section that permits this restriction. I see no GPL section that permits you to prevent people from removing a "list of conditions" when they distribute a work.

Doesn't this seem equivalent to the #1 requirement in the GPL?  The GPL
mostly treats "the program" uniformly regardless if it's binary or
source mostly, so I think this clause may be compatible too, for the
same reasons as the #1 clause in the BSD licenses.

The third clause seems outside the scope of modification and
redistribution, referring to endorsement.


Cheers,

Dave
