Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263075AbUB0R5K (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Feb 2004 12:57:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263084AbUB0R5K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Feb 2004 12:57:10 -0500
Received: from 64-186-161-006.cyclades.com ([64.186.161.6]:34443 "EHLO
	intra.cyclades.com") by vger.kernel.org with ESMTP id S263075AbUB0R5E
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Feb 2004 12:57:04 -0500
Date: Fri, 27 Feb 2004 15:52:16 -0300 (BRT)
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
X-X-Sender: marcelo@logos.cnet
To: "Tvrtko A. =?iso-8859-2?q?Ur=B9ulin?=" <tvrtko@croadria.com>
Cc: linux-kernel@vger.kernel.org, Atul Mukker <atulm@lsil.com>
Subject: Re: Known problems with megaraid under 2.4.25 highmem?
In-Reply-To: <200402271107.42050.tvrtko@croadria.com>
Message-ID: <Pine.LNX.4.58L.0402271548290.18958@logos.cnet>
References: <200402271107.42050.tvrtko@croadria.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Cyclades-MailScanner-Information: Please contact the ISP for more information
X-Cyclades-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 27 Feb 2004, Tvrtko A. [iso-8859-2] Ur?ulin wrote:

>
> Hello,
>
> I have experienced an I/O lockup on my dual Xeon server with megaraid adapter
> when kernel was compiled with highmem and highmem i/o. It happened during
> compilation of mysql with no other load.
>
> Then I recompiled the kernel wo/highmem and everything is stable.
>
> As, this server is now in production on different location I cannot do much
> testing except giving detailed hw info.

Hi,

Not known to me...

Can you get any traces from the lockup? NMI watchdog or sysrq+p and +t?

Did any previous 2.4.x work reliably?
