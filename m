Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264589AbTLHA3t (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Dec 2003 19:29:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264593AbTLHA3t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Dec 2003 19:29:49 -0500
Received: from mail.webmaster.com ([216.152.64.131]:59558 "EHLO
	shell.webmaster.com") by vger.kernel.org with ESMTP id S264589AbTLHA3r
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Dec 2003 19:29:47 -0500
From: "David Schwartz" <davids@webmaster.com>
To: "John Bradford" <john@grabjohn.com>, <linux-kernel@vger.kernel.org>
Subject: RE: Additional clauses to GPL in network drivers
Date: Sun, 7 Dec 2003 16:29:42 -0800
Message-ID: <MDEHLPKNGKAHNMBLJOLKCEJMIIAA.davids@webmaster.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.6604 (9.0.2911.0)
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
In-Reply-To: <200312071515.hB7FFkQH000866@81-2-122-30.bradfords.org.uk>
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Many network drivers in the current 2.6 tree include the following
> licensing condition/clarification, in addition to being placed under
> the GPL:
>
> "This file is not a complete program and may only be used when the
> entire operating system is licensed under the GPL".
>
> as
> grep -C 1 "only be used when"
>
> in drivers/net will confirm.

	If this adds any restriction on use that is not part of the GPL, then this
'license' is not compatible with the GPL. If this reflects the author's
understanding of the GPL, then it's grossly incorrect.

> 2. Is code licensed under this extra term actually compatible with
> code placed under the GPL alone?

	Only if the term is meaningless. I suspect that it's legally meaningless
and simply erroneous, but it does create the risk that someone might argue
that it's an additional restriction.

> 3. I haven't tried to trace the history of this code, but if these
> drivers were based on, and include, other developer's purely GPL'ed
> code, applying this extra condition is presumably not valid, (unless
> specific permission was sought to do so).

	Correct. Most likely this is the case, so it reflects license hijacking on
the part of the person who did it. To take someone else's GPL'd code, modify
it, and release the modified code under a license that is more restrictive
than the GPL is despicable conduct.

> 4. The obvious issue concerning binary modules - does loading a binary
> module which is not licensed under the GPL invalidate your license to
> use these network drivers?  Note that I personally have no interest
> whatsoever in using such binary modules, but whatever ends up being
> decided for the GPL'ed parts of the kernel, this extra clause suggests
> to me that it specifically isn't OK whilst using these network
> drivers.

	I think this is just one way of showing that the clause is erroneous.

	DS


