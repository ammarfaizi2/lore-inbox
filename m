Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268954AbRG0UdQ>; Fri, 27 Jul 2001 16:33:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268960AbRG0UdG>; Fri, 27 Jul 2001 16:33:06 -0400
Received: from itvu-63-210-168-13.intervu.net ([63.210.168.13]:49539 "EHLO
	pga.intervu.net") by vger.kernel.org with ESMTP id <S268954AbRG0Uct>;
	Fri, 27 Jul 2001 16:32:49 -0400
Message-ID: <3B61D1DA.49AFC88D@randomlogic.com>
Date: Fri, 27 Jul 2001 13:40:58 -0700
From: "Paul G. Allen" <pgallen@randomlogic.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.2-2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "kplug-list@kernel-panic.org" <kplug-list@kernel-panic.org>
CC: "Linux kernel developer's mailing list" 
	<linux-kernel@vger.kernel.org>,
        "kplug-lpsg@kernel-panic.org" <kplug-lpsg@kernel-panic.org>
Subject: Re: Linx Kernel Source tree and metrics
In-Reply-To: <3B612D26.BA131CEC@randomlogic.com>
		<01072714523106.00285@starship> <200107271308.f6RD8EA02743@mobilix.ras.ucalgary.ca>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing


> 
> Daniel Phillips writes:

Nit 1: I'd prefer the following format for the data dictionary:

-m   (Local Object)[xref]
-   [wavelan_cs.c, 564]
-
+m  [xref] [wavelan_cs.c, 564] (Local Object)

I.e., three times as many entries on the screen and with the
constant-width part aligned.

Nit 2: You can drop the "Report" from the name of every section, we
know it's a report.

I'm continuing to explore this wonderful resource.  Do you intend to
GPL the source?



Richard Gooch wrote:

> 
> Hm. Interesting. But I note it has the devfsd source code in there as
> well. That's definately not part of the kernel!
> 
>                                 Regards,
> 
>                                         Richard....
> Permanent: rgooch@atnf.csiro.au
> Current:   rgooch@ras.ucalgary.ca
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/


Answer to Daniel:

The program I used is a purchased product. So, no, it won't be GPL. I have no control over the contents of the reports other than addin/removing source
files/trees that are parsed and hand editing the generated HTML. Since there's over 1GB of HTML, the editing part is definetely out. :D


Answer to Richard:

I simply parsed the entire /usr/src/linux-2.4.2 tree (including the modules) and applicable gcc header files. I may have missed a few, I may have gotten a few
too many. Those that are more "in the know" than I can feed me info so I can correct the files/trees that are parsed.

PGA

-- 
Paul G. Allen
UNIX Admin II/Programmer
Akamai Technologies, Inc.
www.akamai.com
Work: (858)909-3630
Cell: (858)395-5043
