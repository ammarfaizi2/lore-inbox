Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319122AbSH2HHF>; Thu, 29 Aug 2002 03:07:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319123AbSH2HHE>; Thu, 29 Aug 2002 03:07:04 -0400
Received: from natwar.webmailer.de ([192.67.198.70]:58832 "EHLO
	post.webmailer.de") by vger.kernel.org with ESMTP
	id <S319122AbSH2HHD>; Thu, 29 Aug 2002 03:07:03 -0400
Date: Thu, 29 Aug 2002 09:07:01 +0200
From: Dominik Brodowski <devel@brodo.de>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, cpufreq@www.linux.org.uk,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH][2.5.32] CPU frequency and voltage scaling (0/4)
Message-ID: <20020829090701.C1117@brodo.de>
References: <1030577406.7190.89.camel@irongate.swansea.linux.org.uk> <Pine.LNX.4.44.0208281649540.27728-100000@home.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.16i
In-Reply-To: <Pine.LNX.4.44.0208281649540.27728-100000@home.transmeta.com>; from torvalds@transmeta.com on Wed, Aug 28, 2002 at 05:08:14PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 28, 2002 at 05:08:14PM -0700, Linus Torvalds wrote:
> I don't know how many policies would be needed (too many just adds 
> complexity for no gain), but I _suspect_ that something like a 
<snip>
> (maybe the "policy" thing actually makes a difference even for the
> fixed-frequency case: it can give hints about whether to allow C1-C3
> states when idle etc).

OK, I see the problems you mention wrt current cpufreq. But let's keep the
next version simple: and whether to allow C1-C3 is really nothing cpufreq
should take care of, as this is pure ACPI policy.

	Dominik
