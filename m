Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264627AbUGHP64@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264627AbUGHP64 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jul 2004 11:58:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264697AbUGHP64
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jul 2004 11:58:56 -0400
Received: from fw.osdl.org ([65.172.181.6]:50322 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264627AbUGHP6v (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jul 2004 11:58:51 -0400
Date: Thu, 8 Jul 2004 08:58:18 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Miles Bader <miles@gnu.org>
cc: "David S. Miller" <davem@redhat.com>,
       Herbert Xu <herbert@gondor.apana.org.au>, chrisw@osdl.org,
       akpm@osdl.org, linux-kernel@vger.kernel.org, sds@epoch.ncsc.mil,
       jmorris@redhat.com, mika@osdl.org
Subject: Re: [PATCH] Use NULL instead of integer 0 in security/selinux/
In-Reply-To: <buosmc3gix6.fsf@mctpc71.ucom.lsi.nec.co.jp>
Message-ID: <Pine.LNX.4.58.0407080855120.1764@ppc970.osdl.org>
References: <20040707122525.X1924@build.pdx.osdl.net>
 <E1BiPKz-0008Q7-00@gondolin.me.apana.org.au> <20040707202746.1da0568b.davem@redhat.com>
 <buo7jtfi2p9.fsf@mctpc71.ucom.lsi.nec.co.jp> <Pine.LNX.4.58.0407072220060.1764@ppc970.osdl.org>
 <buosmc3gix6.fsf@mctpc71.ucom.lsi.nec.co.jp>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 8 Jul 2004, Miles Bader wrote:
> >
> > No it's not.
> 
> I don't have a copy of the standard handy

I have one. It's in my head. It's called the Linux Kernel C standard. Some 
of it is documented in CodinggStyle, others is just codified in existing 
practice.

> but google shows this snippet on the info-minux mailing list:
> 
>    From ANSI X3.159-1989 3.2.2.3:

That's some totally irrelevant standard that only acts as a rough 
guideline. It dosn't know about inline assembly, and it doesn't know about 
coding standards, and it allows the most atrocious code. There's even a 
contest in making such code - it's called the Obfuscated C Contest, and it 
actually encourages using strict ANSI rules.

Me, I don't accept the kind of entries the OCC accepts. 

		Linus
