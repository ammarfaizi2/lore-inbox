Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266599AbUFYUm5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266599AbUFYUm5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Jun 2004 16:42:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266615AbUFYUm4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Jun 2004 16:42:56 -0400
Received: from fw.osdl.org ([65.172.181.6]:5577 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266599AbUFYUmz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Jun 2004 16:42:55 -0400
Date: Fri, 25 Jun 2004 13:45:37 -0700
From: Andrew Morton <akpm@osdl.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: jbarnes@engr.sgi.com, erikj@subway.americas.sgi.com, pfg@sgi.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6] Altix serial driver
Message-Id: <20040625134537.072d17b9.akpm@osdl.org>
In-Reply-To: <20040625155335.GA30427@infradead.org>
References: <Pine.SGI.3.96.1040623094239.19458C-100000@fsgi900.americas.sgi.com>
	<Pine.SGI.4.53.0406242153360.343801@subway.americas.sgi.com>
	<20040625083130.GA26557@infradead.org>
	<200406251110.07383.jbarnes@engr.sgi.com>
	<20040625155335.GA30427@infradead.org>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig <hch@infradead.org> wrote:
>
> On Fri, Jun 25, 2004 at 11:10:07AM -0400, Jesse Barnes wrote:
> > But LANANA doesn't assign minors, right?  And Linus hasn't banned those, so 
> > the patch to devices.txt should be sufficient, right?  (Please let the answer 
> > be yes!)  Moreover, isn't this Andrew's decision as the 2.6 maintainer?
> 
> For the misc major LANANA also assigns minors.

I don't think we did that for /dev/kmsg.

I haven't followed the politics or the history of this much, but if LANANA
are being unresponsive and/or are ignoring 2.6 kernels, don't we need to
either fix them up or route around them?

Maybe John is on vacation or something - it's that time of year.
