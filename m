Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271071AbTG1Uz5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Jul 2003 16:55:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271107AbTG1UzU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Jul 2003 16:55:20 -0400
Received: from louise.pinerecords.com ([213.168.176.16]:54146 "EHLO
	louise.pinerecords.com") by vger.kernel.org with ESMTP
	id S271071AbTG1Uy6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Jul 2003 16:54:58 -0400
Date: Mon, 28 Jul 2003 22:54:38 +0200
From: Tomas Szepe <szepe@pinerecords.com>
To: Bruce Harada <bharada@coral.ocn.ne.jp>
Cc: Meelis Roos <mroos@linux.ee>, linux-kernel@vger.kernel.org
Subject: Re: raid5 autoselecting a slower checksum function
Message-ID: <20030728205438.GI32673@louise.pinerecords.com>
References: <Pine.GSO.4.44.0307281811290.13144-100000@math.ut.ee> <20030729003046.15975639.bharada@coral.ocn.ne.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030729003046.15975639.bharada@coral.ocn.ne.jp>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> [bharada@coral.ocn.ne.jp]
> 
> On Mon, 28 Jul 2003 18:17:00 +0300 (EEST)
> Meelis Roos <mroos@linux.ee> wrote:
> 
> <snip>
> 
> > Why doesn't it select p5_mmx if it is 37% faster than pIII_sse?
> 
> This has come up before - see :
> 
> http://hypermail.idiosynkrasia.net/linux-kernel/archived/2003/week01/1894.html

Fair enough, but wouldn't it be more appropriate if the kernel printed
a message like "SSE present, good.  No need to try the other checksumming
methods" in this case?

-- 
Tomas Szepe <szepe@pinerecords.com>
