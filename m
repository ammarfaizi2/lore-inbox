Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261183AbVAMHUc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261183AbVAMHUc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jan 2005 02:20:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261184AbVAMHUc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jan 2005 02:20:32 -0500
Received: from pat.uio.no ([129.240.130.16]:52157 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S261183AbVAMHU2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jan 2005 02:20:28 -0500
Subject: Re: [RFC] Avoiding fragmentation through different allocator
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Matt Mackall <mpm@selenic.com>
Cc: Mel Gorman <mel@csn.ul.ie>,
       Linux Memory Management List <linux-mm@kvack.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20050113070314.GL2995@waste.org>
References: <Pine.LNX.4.58.0501122101420.13738@skynet>
	 <20050113070314.GL2995@waste.org>
Content-Type: text/plain
Date: Thu, 13 Jan 2005 02:20:01 -0500
Message-Id: <1105600801.11555.6.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
X-MailScanner-Information: This message has been scanned for viruses/spam. Contact postmaster@uio.no if you have questions about this scanning
X-UiO-MailScanner: No virus found
X-UiO-Spam-info: not spam, SpamAssassin (score=0, required 12)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

on den 12.01.2005 Klokka 23:03 (-0800) skreiv Matt Mackall:

> You might stress higher order page allocation with a) 8k stacks turned
> on b) UDP NFS with large read/write.

   b) Unless your network uses jumbo frames, UDP NFS should not be doing
higher order page allocation.

Cheers,
  Trond

-- 
Trond Myklebust <trond.myklebust@fys.uio.no>

