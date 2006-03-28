Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750896AbWC1B7c@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750896AbWC1B7c (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Mar 2006 20:59:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750903AbWC1B7c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Mar 2006 20:59:32 -0500
Received: from CyborgDefenseSystems.Corporatebeast.com ([64.62.148.172]:18696
	"EHLO arnor.apana.org.au") by vger.kernel.org with ESMTP
	id S1750889AbWC1B7c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Mar 2006 20:59:32 -0500
From: Herbert Xu <herbert@gondor.apana.org.au>
To: edwardspec@yahoo.com (Edward Chernenko)
Subject: Re: [PATCH 2.6.15] Adding kernel-level identd dispatcher
Cc: jengelh@linux01.gwdg.de, linux-kernel@vger.kernel.org
Organization: Core
In-Reply-To: <20060326194904.24112.qmail@web37702.mail.mud.yahoo.com>
X-Newsgroups: apana.lists.os.linux.kernel
User-Agent: tin/1.7.4-20040225 ("Benbecula") (UNIX) (Linux/2.4.27-hx-1-686-smp (i686))
Message-Id: <E1FO3UQ-0005nf-00@gondolin.me.apana.org.au>
Date: Tue, 28 Mar 2006 12:59:22 +1100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Edward Chernenko <edwardspec@yahoo.com> wrote:
> 
> Comparing with khttpd, we have no need to make
> transfers between
> userspace and kernelspace;  additionally, ident daemon
> depends on
> kernel connections table. This is very efficient to
> avoid using proc
> interface by userspace program here.

Check out the pidentd in Debian.  It uses netlink instead of procfs which
is much more scalable.

Cheers,
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
