Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129415AbQLNQTl>; Thu, 14 Dec 2000 11:19:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129421AbQLNQTb>; Thu, 14 Dec 2000 11:19:31 -0500
Received: from ns.caldera.de ([212.34.180.1]:20491 "EHLO ns.caldera.de")
	by vger.kernel.org with ESMTP id <S129415AbQLNQTW>;
	Thu, 14 Dec 2000 11:19:22 -0500
Date: Thu, 14 Dec 2000 16:48:41 +0100
Message-Id: <200012141548.QAA22537@ns.caldera.de>
From: Christoph Hellwig <hch@ns.caldera.de>
To: gibbs@scsiguy.com ("Justin T. Gibbs")
Cc: linux-kernel@vger.kernel.org
Subject: Re: Adaptec AIC7XXX v 6.0.6 BETA Released
X-Newsgroups: caldera.lists.linux.kernel
In-Reply-To: <200012132215.eBDMFas35908@aslan.scsiguy.com>
User-Agent: tin/1.4.1-19991201 ("Polish") (UNIX) (Linux/2.2.14 (i686))
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <200012132215.eBDMFas35908@aslan.scsiguy.com> you wrote:
> For those
> of you building the driver as a module, take note that the module
> name is now "aic7xxx_mod" rather than "aic7xxx".

Could you please undo that change?
Postfixing a module name with _mod does not make sense.
Yes, some modules use it - but that's just because they have older source
files that are called like the multi-object module.

	Christoph

-- 
Whip me.  Beat me.  Make me maintain AIX.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
