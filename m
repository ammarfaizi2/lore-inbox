Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261860AbTDUSaT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Apr 2003 14:30:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261863AbTDUSaT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Apr 2003 14:30:19 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:18703 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id S261860AbTDUSaS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Apr 2003 14:30:18 -0400
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH] new system call mknod64
Date: 21 Apr 2003 11:42:18 -0700
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <b81e2a$tev$1@cesium.transmeta.com>
References: <20030421191013.A9655@infradead.org> <Pine.LNX.4.44.0304211117260.3101-100000@home.transmeta.com> <20030421193546.A10287@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2003 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <20030421193546.A10287@infradead.org>
By author:    Christoph Hellwig <hch@infradead.org>
In newsgroup: linux.dev.kernel
> 
> Umm, no.  You're far to major/minor biased to realized live get a lot
> sipler for use if we don't do any complicated mapping of old dev_t
> to the larger dev_t.  With the proper ranges we can just map it
> numerically 1:1 to the new dev_t.  Yes, that means it's all in one
> new "major".  But who cares?
> 

Everyone who has to fix up the resulting mess.  There is such a thing
as backwards compatibility, you know, and it's usually a good thing.

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
Architectures needed: ia64 m68k mips64 ppc ppc64 s390 s390x sh v850 x86-64
