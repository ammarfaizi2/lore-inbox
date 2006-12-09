Return-Path: <linux-kernel-owner+w=401wt.eu-S1761164AbWLINWO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761164AbWLINWO (ORCPT <rfc822;w@1wt.eu>);
	Sat, 9 Dec 2006 08:22:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761175AbWLINWO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Dec 2006 08:22:14 -0500
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35]:47714 "EHLO
	fgwmail5.fujitsu.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761162AbWLINWN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Dec 2006 08:22:13 -0500
Date: Sat, 9 Dec 2006 22:21:17 +0900
From: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
To: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: linux-kernel@vger.kernel.org, clameter@engr.sgi.com, apw@shadowen.org,
       akpm@osdl.org
Subject: Re: [RFC] [PATCH] virtual memmap on sparsemem v3 [0/4] introduction
Message-Id: <20061209222117.a2bb64a1.kamezawa.hiroyu@jp.fujitsu.com>
In-Reply-To: <20061209115137.GA10380@osiris.ibm.com>
References: <20061208155608.14dcd2e5.kamezawa.hiroyu@jp.fujitsu.com>
	<20061209115137.GA10380@osiris.ibm.com>
X-Mailer: Sylpheed version 2.2.0 (GTK+ 2.6.10; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 9 Dec 2006 12:51:37 +0100
Heiko Carstens <heiko.carstens@de.ibm.com> wrote:

> > Virtual mem_map is not useful for 32bit archs. This uses huge virtual
> > address range.
> 
> Why? The s390 vmem_map implementation which I sent last week to linux-mm
> is merged in the meantime. It supports both 32 and 64 bit.
> The main reason is to keep things simple and avoid #ifdef hell.
> 
> Since the maximum size of the virtual array is  about 16MB it's not much
> waste of address space. Actually I just changed the size of the vmalloc
> area, so that the maximum supported physical amount of memory is still 1920MB.

I'm sorry. I don't stop anyone who want to use vmem_map.
(My brain is polluted by ugly x86 36bit-space/32bit arch.)

-Kame

