Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130383AbRAXPOk>; Wed, 24 Jan 2001 10:14:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132670AbRAXPOQ>; Wed, 24 Jan 2001 10:14:16 -0500
Received: from jump-isi.interactivesi.com ([207.8.4.2]:43769 "HELO
	dinero.interactivesi.com") by vger.kernel.org with SMTP
	id <S130290AbRAXPOD>; Wed, 24 Jan 2001 10:14:03 -0500
Date: Wed, 24 Jan 2001 09:14:02 -0600
From: Timur Tabi <ttabi@interactivesi.com>
To: David Wragg <dpw@doc.ic.ac.uk>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org
In-Reply-To: <y7rk87leptf.fsf@sytry.doc.ic.ac.uk>
In-Reply-To: <Pine.GSO.4.10.10101231903380.14027-100000@zeus.fh-brandenburg.de>
Subject: Re: ioremap_nocache problem?
X-Mailer: The Polarbar Mailer; version=1.19a; build=73
Message-Id: <20010124151413Z130290-18595+585@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

** Reply to message from David Wragg <dpw@doc.ic.ac.uk> on 24 Jan 2001 00:50:20
+0000


> (x86 processors with PAT and IA64 can set write-combining through page
> flags.  x86 processors with MTRRs but not PAT would need a more
> elaborate implementation for write-combining.)

What is PAT?  I desperately need to figure out how to turn on write combining
on a per-page level.  I thought I had to use MTRRs, but now you're saying I can
use this "PAT" thing instead.  Please explain!


-- 
Timur Tabi - ttabi@interactivesi.com
Interactive Silicon - http://www.interactivesi.com

When replying to a mailing-list message, please direct the reply to the mailing list only.  Don't send another copy to me.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
