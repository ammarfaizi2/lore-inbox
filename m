Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932594AbVKAFEc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932594AbVKAFEc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Nov 2005 00:04:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932592AbVKAFEc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Nov 2005 00:04:32 -0500
Received: from verein.lst.de ([213.95.11.210]:14765 "EHLO mail.lst.de")
	by vger.kernel.org with ESMTP id S932590AbVKAFEb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Nov 2005 00:04:31 -0500
Date: Tue, 1 Nov 2005 06:04:23 +0100
From: Christoph Hellwig <hch@lst.de>
To: Roland Dreier <rolandd@cisco.com>
Cc: FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>, openib-general@openib.org,
       linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: Re: [openib-general] Re: [PATCH/RFC] IB: Add SCSI RDMA Protocol (SRP) initiator
Message-ID: <20051101050423.GA25691@lst.de>
References: <52wtjtk3d1.fsf@cisco.com> <20051101110409V.fujita.tomonori@lab.ntt.co.jp> <52irvdge6c.fsf@cisco.com> <20051101045800.GA25519@lst.de> <52acgpgdso.fsf@cisco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <52acgpgdso.fsf@cisco.com>
User-Agent: Mutt/1.3.28i
X-Spam-Score: -4.901 () BAYES_00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 31, 2005 at 09:03:35PM -0800, Roland Dreier wrote:
>     Christoph> No. Bitfields for accessing hardware/wire
>     Christoph> datastructures are wrong and will always break in some
>     Christoph> circumstances.  Your header is much better.
> 
> OK, that's my feeling as well.
> 
> Would it make sense for me to split the pure SRP spec structures and
> so on into a separate file and put it in include/scsi/srp.h?  Then we
> can move ibmvscsi towards using that file.

Sounds like a good idea, yes.

