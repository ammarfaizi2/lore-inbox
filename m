Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264682AbTFLMbS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jun 2003 08:31:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264711AbTFLMbS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jun 2003 08:31:18 -0400
Received: from arnor.apana.org.au ([203.14.152.115]:7428 "EHLO
	arnor.me.apana.org.au") by vger.kernel.org with ESMTP
	id S264682AbTFLMbR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jun 2003 08:31:17 -0400
From: Herbert Xu <herbert@gondor.apana.org.au>
To: akpm@digeo.com (Andrew Morton), linux-kernel@vger.kernel.org
Subject: Re: ext[23]/lilo/2.5.{68,69,70} -- blkdev_put() problem?
In-Reply-To: <20030612035442.29345778.akpm@digeo.com>
X-Newsgroups: apana.lists.os.linux.kernel
User-Agent: tin/1.5.17-20030301 ("Bubbles") (UNIX) (Linux/2.4.20-1-686-smp (i686))
Message-Id: <E19QRRY-0002W4-00@gondolin.me.apana.org.au>
Date: Thu, 12 Jun 2003 22:44:40 +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@digeo.com> wrote:
> 
> I use `lilo ; reboot -f' about 1000 times a day, no probs.  There's
> something different.
> 
> Adam was doing strange things with an initrd and pivot_root.  Are you doing
> anything unconventional?

I see exactly the same problem with lilo and I too use initrd + pivot_root.
I think Adam's post referred to elsewhere in this thread already identified
the problem as initrd-only.
-- 
Debian GNU/Linux 3.0 is out! ( http://www.debian.org/ )
Email:  Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
