Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751077AbVJXPNi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751077AbVJXPNi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Oct 2005 11:13:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751081AbVJXPNi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Oct 2005 11:13:38 -0400
Received: from clock-tower.bc.nu ([81.2.110.250]:7816 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1751077AbVJXPNh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Oct 2005 11:13:37 -0400
Subject: Re: ioctls, etc. (was Re: [PATCH 1/4] sas: add flag for locally
	attached PHYs)
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Luben Tuikov <luben_tuikov@adaptec.com>
Cc: Christoph Hellwig <hch@infradead.org>, Sergey Panov <sipan@sipan.org>,
       Stefan Richter <stefanr@s5r6.in-berlin.de>, linux-scsi@vger.kernel.org,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Jeff Garzik <jgarzik@pobox.com>, andrew.patterson@hp.com,
       Christoph Hellwig <hch@lst.de>,
       "Moore, Eric Dean" <Eric.Moore@lsil.com>, jejb@steeleye.com,
       Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <435CE6CA.4070704@adaptec.com>
References: <4359440E.2050702@pobox.com> <43595275.1000308@adaptec.com>
	 <435959BE.5040101@pobox.com> <43595CA6.9010802@adaptec.com>
	 <43596070.3090902@pobox.com> <43596859.3020801@adaptec.com>
	 <43596F16.7000606@pobox.com> <435A1793.1050805@s5r6.in-berlin.de>
	 <20051022105815.GB3027@infradead.org>
	 <1129994910.6286.21.camel@sipan.sipan.org>
	 <20051022171943.GA7546@infradead.org>  <435CE6CA.4070704@adaptec.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Mon, 24 Oct 2005 16:41:35 +0100
Message-Id: <1130168495.12873.27.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Llu, 2005-10-24 at 09:51 -0400, Luben Tuikov wrote:
> controls and how.  Understanding how the factory workers use it and what
> they expect.  Understanding the code (which may not be as easy).  Then it
> is rewritten so that it can be easily supported and maintained.

Very very rarely, because it means down time and supporting two systems
at once. Take a look at the australian customs fiasco or the british
passport office disaster to see why (actually almost any large
government IT project where politics dictated 'write new stuff so I can
announce it in parliament').

The smart factory update would occur piece by piece. Starting with the
most pressing problems (ie fastest ROI) and working to a plan that ends
up with the system modular and clean.

You don't turn a steel plant off for a software upgrade.

