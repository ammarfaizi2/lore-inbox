Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319190AbSHTQjk>; Tue, 20 Aug 2002 12:39:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319191AbSHTQjk>; Tue, 20 Aug 2002 12:39:40 -0400
Received: from wildsau.idv.uni.linz.at ([213.157.128.253]:36358 "EHLO
	wildsau.idv.uni.linz.at") by vger.kernel.org with ESMTP
	id <S319190AbSHTQjg>; Tue, 20 Aug 2002 12:39:36 -0400
From: "H.Rosmanith (Kernel Mailing List)" <kernel@wildsau.idv.uni.linz.at>
Message-Id: <200208201639.g7KGddXl020053@wildsau.idv.uni.linz.at>
Subject: Re: need contact of via-rhine developers
In-Reply-To: <1029854455.10084.136.camel@ransom> from Rob Myers at "Aug 20, 2 10:40:55 am"
To: rob.myers@gtri.gatech.edu (Rob Myers)
Date: Tue, 20 Aug 2002 18:39:38 +0200 (MET DST)
Cc: linux-kernel@vger.kernel.org (l)
X-Mailer: ELM [version 2.4ME+ PL37 (25)]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> here is the driver i'm using that works on my vt6103 (from
> 2.4.20-pre2-ac3).  i have not done throughput benchmarks, but i have put
> many gb's through them with no ill effects so far.
> 
> it looks like the patch adds the ability for the driver to restart the
> confused chip...

thanks! that fixed the transmit-timeouts! they happened quite frequently.
the more traffic you'd submit, the more timeouts. e.g. , when viewing
icture over the net (e.g. xv running on a different host), I'd see about
12 timeouts per minute(raw estimation).

any idea what's confusing the chip in the first place?

regards,
h.rosmanith

