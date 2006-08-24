Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422775AbWHXW3r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422775AbWHXW3r (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Aug 2006 18:29:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422776AbWHXW3r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Aug 2006 18:29:47 -0400
Received: from e32.co.us.ibm.com ([32.97.110.150]:37790 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S1422775AbWHXW3q
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Aug 2006 18:29:46 -0400
Subject: Re: [ckrm-tech] [PATCH 1/6] BC: kconfig
From: Matt Helsley <matthltc@us.ibm.com>
To: Kirill Korotaev <dev@sw.ru>
Cc: "Chandra S. Seetharaman" <sekharan@us.ibm.com>,
       Rik van Riel <riel@redhat.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       CKRM-Tech <ckrm-tech@lists.sourceforge.net>, Greg KH <greg@kroah.com>,
       Andi Kleen <ak@suse.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Christoph Hellwig <hch@infradead.org>, Andrey Savochkin <saw@sw.ru>,
       Rohit Seth <rohitseth@google.com>, Oleg Nesterov <oleg@tv-sign.ru>,
       devel@openvz.org, Pavel Emelianov <xemul@openvz.org>
In-Reply-To: <44ED91EB.9020306@sw.ru>
References: <44EC31FB.2050002@sw.ru> <44EC35A3.7070308@sw.ru>
	 <1156379028.7154.25.camel@linuxchandra>  <44ED91EB.9020306@sw.ru>
Content-Type: text/plain
Date: Thu, 24 Aug 2006 15:23:31 -0700
Message-Id: <1156458211.2510.900.camel@stark>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-08-24 at 15:47 +0400, Kirill Korotaev wrote:
> > Is there a reason why these can be moved to a arch-neutral place ?
> I think a good place for BC would be kernel/Kconfig.bc

I think kernel/bc/Kconfig is fine.

> but still this should be added into archs.
> ok?

Sourcing the bc Kconfig from arch Kconfigs would seem to suggest that
resource management is only possible on a proper subset of archs. Since
this is not the case wouldn't it be better to source the bc Kconfig from
an arch-independent Kconfig (init/Kconfig for example)?

> > PS: Please keep ckrm-tech on Cc: please.

Also, thank you for CC'ing CKRM-Tech with your earlier posting of these
patches.

> Sorry, it is very hard to track emails coming from authors and 3 mailing lists.

Yes, it can be difficult to keep track of all the email authors.

> Better tell me the interested people emails.

	CC'ing only the known-interested people wouldn't be better. If anything
I think it's harder for everyone than simply CC'ing a relevant mailing
list like LKML and CKRM-Tech in this case.

Cheers,
	-Matt Helsley

