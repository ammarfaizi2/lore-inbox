Return-Path: <linux-kernel-owner+w=401wt.eu-S1161085AbWLUAeY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161085AbWLUAeY (ORCPT <rfc822;w@1wt.eu>);
	Wed, 20 Dec 2006 19:34:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161091AbWLUAeY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Dec 2006 19:34:24 -0500
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36]:59525 "EHLO
	fgwmail6.fujitsu.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161085AbWLUAeX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Dec 2006 19:34:23 -0500
Date: Thu, 21 Dec 2006 09:37:01 +0900
From: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
To: "Bob Picco" <bob.picco@hp.com>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, clameter@engr.sgi.com,
       apw@shadowen.org, heiko.carstens@de.ibm.com, bob.picco@hp.com
Subject: Re: [PATCH][2.6.20-rc1-mm1] sparsemem vmem_map optimzed pfn_valid()
 [0/2]
Message-Id: <20061221093701.7358642c.kamezawa.hiroyu@jp.fujitsu.com>
In-Reply-To: <20061220200628.GA10271@localhost>
References: <20061216173136.fbc91fa6.kamezawa.hiroyu@jp.fujitsu.com>
	<20061220200628.GA10271@localhost>
Organization: Fujitsu
X-Mailer: Sylpheed version 2.2.0 (GTK+ 2.6.10; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 Dec 2006 15:06:28 -0500
"Bob Picco" <bob.picco@hp.com> wrote:

> Sorry I was looking for AIM VII and/or reaim which are multiuser loads.
> The results (2.6.20-rc1-mm1) for EXTREME, SPARSEMEM+VMEMMAP and
> SPARSEMEM+VMEMMAP+your+patch are below. Note SPARSEMEM+VMEMMAP AIM VII
> wasn't benchmarked to higher load limit because of my time constraints. 
> The runs should be repeated more times.

Thank you.
> 
> Any difference between the three configurations looks insignificant and
> within benchmark noise.
> 
looks so ;)

Because I'm now exhausted by other works, I can't go ahead until the next year.
My concern is io-benchmark like iozone.

Andrew-san, please drop the patch set if anyone isn't interested in.
I'll retry with new benchmark result if necessary.

-Kame

