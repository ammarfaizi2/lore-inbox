Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265987AbUGILYi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265987AbUGILYi (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jul 2004 07:24:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265993AbUGILYi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jul 2004 07:24:38 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:18636 "EHLO scrub.home")
	by vger.kernel.org with ESMTP id S265987AbUGILYh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jul 2004 07:24:37 -0400
Date: Fri, 9 Jul 2004 13:23:16 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Linus Torvalds <torvalds@osdl.org>
cc: Miles Bader <miles@gnu.org>, "David S. Miller" <davem@redhat.com>,
       Herbert Xu <herbert@gondor.apana.org.au>, chrisw@osdl.org,
       akpm@osdl.org, linux-kernel@vger.kernel.org, sds@epoch.ncsc.mil,
       jmorris@redhat.com, mika@osdl.org
Subject: Re: [PATCH] Use NULL instead of integer 0 in security/selinux/
In-Reply-To: <Pine.LNX.4.58.0407080855120.1764@ppc970.osdl.org>
Message-ID: <Pine.LNX.4.58.0407091313570.20635@scrub.home>
References: <20040707122525.X1924@build.pdx.osdl.net>
 <E1BiPKz-0008Q7-00@gondolin.me.apana.org.au> <20040707202746.1da0568b.davem@redhat.com>
 <buo7jtfi2p9.fsf@mctpc71.ucom.lsi.nec.co.jp> <Pine.LNX.4.58.0407072220060.1764@ppc970.osdl.org>
 <buosmc3gix6.fsf@mctpc71.ucom.lsi.nec.co.jp> <Pine.LNX.4.58.0407080855120.1764@ppc970.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, 8 Jul 2004, Linus Torvalds wrote:

> I have one. It's in my head. It's called the Linux Kernel C standard. Some 
> of it is documented in CodinggStyle, others is just codified in existing 
> practice.

So far we have been quite liberal in style questions, what annoys me here 
is that people send warning patches directly to you without even notifying 
the maintainers. If you want people to conform people to a certain 
CodingStyle please document officially in the kernel, sparse isn't 
distributed with the kernel and the sparse police is silently changing the 
kernel all over the place with sometimes questionable benefit. Only the 
__user warnings had really found the bugs, but the rest I've seen changes 
perfectly legal code.

bye, Roman
