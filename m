Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267719AbUBTHv3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Feb 2004 02:51:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267715AbUBTHv3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Feb 2004 02:51:29 -0500
Received: from jaguar.mkp.net ([192.139.46.146]:23268 "EHLO jaguar.mkp.net")
	by vger.kernel.org with ESMTP id S267719AbUBTHv2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Feb 2004 02:51:28 -0500
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Bill Davidsen <davidsen@tmr.com>,
       David Mosberger-Tang <David.Mosberger@acm.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Intel x86-64 support merge
References: <1qK5k-7g2-67@gated-at.bofh.it> <1qK5k-7g2-69@gated-at.bofh.it>
	<1qK5k-7g2-71@gated-at.bofh.it> <1qK5k-7g2-73@gated-at.bofh.it>
	<1qK5k-7g2-65@gated-at.bofh.it> <40353382.8010505@tmr.com>
	<40358AC5.90103@pobox.com>
From: Jes Sorensen <jes@wildopensource.com>
Date: 20 Feb 2004 02:48:06 -0500
In-Reply-To: <40358AC5.90103@pobox.com>
Message-ID: <yq0vfm2ry2x.fsf@wildopensource.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Jeff" == Jeff Garzik <jgarzik@pobox.com> writes:

Jeff> Bill Davidsen wrote:
>> Doesn't need it? Does that mean the Win64 uses bounce buffers for
>> everything? Or am I totally misreading this?

Jeff> Well, for 32-bit PCI hardware on a 64-bit OS, you pretty much
Jeff> have to bounce, without an IOMMU.

Jeff> I doubt Win64 bounces for 64-bit PCI hardware, but who knows...

Just a shame they don't seem to care about performance and allowing
one to issue SAC cycles when possible. Oh well, guess one just has to
buy a real computer.

Cheers,
Jes
