Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264059AbUCZJge (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Mar 2004 04:36:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264060AbUCZJge
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Mar 2004 04:36:34 -0500
Received: from server2.netdiscount.de ([217.13.198.2]:14489 "EHLO
	server2.netdiscount.de") by vger.kernel.org with ESMTP
	id S264059AbUCZJgd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Mar 2004 04:36:33 -0500
Date: Fri, 26 Mar 2004 10:36:19 +0100
From: Christian Leber <christian@leber.de>
To: Christoph Hellwig <hch@infradead.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Problem with remap_page_range/mmap
Message-ID: <20040326093619.GA15965@core.home>
References: <20040325234804.GA29507@core.home> <20040326071739.B2637@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20040326071739.B2637@infradead.org>
X-Accept-Language: de en
X-Location: Europe, Germany, Mannheim
X-Operating-System: Debian GNU/Linux (sid)
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 26, 2004 at 07:17:39AM +0000, Christoph Hellwig wrote:

> You can't call remap_page_range on normal kernel pages.  It works only
> if you mark them PG_reserved, but even that use is usually not a good idea.

It also didn´t work with PG_reserved.
What would be the good idea? I need at least 8 at least 4MB (2MB are enough for 2.4)
big physical memory pieces for DMA, mapped to userspace.

What is the reason why it doesn´t work? There seems to be no special
remap_page_range for ia64.



Christian Leber

-- 
  "Omnis enim res, quae dando non deficit, dum habetur et non datur,
   nondum habetur, quomodo habenda est."       (Aurelius Augustinus)
  Translation: <http://gnuhh.org/work/fsf-europe/augustinus.html>
