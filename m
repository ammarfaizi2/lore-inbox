Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274214AbRISWKu>; Wed, 19 Sep 2001 18:10:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274218AbRISWKk>; Wed, 19 Sep 2001 18:10:40 -0400
Received: from ns.caldera.de ([212.34.180.1]:40646 "EHLO ns.caldera.de")
	by vger.kernel.org with ESMTP id <S274214AbRISWKc>;
	Wed, 19 Sep 2001 18:10:32 -0400
Date: Thu, 20 Sep 2001 00:10:48 +0200
From: Christoph Hellwig <hch@ns.caldera.de>
To: Peter Wong <wpeter@us.ibm.com>
Cc: linux-kernel@vger.kernel.org, lse-tech@lists.sourceforge.net
Subject: Re: [Lse-tech] Regarding Jens' Zero-Bounce Highmem I/O Patch
Message-ID: <20010920001048.A11073@caldera.de>
Mail-Followup-To: Christoph Hellwig <hch>, Peter Wong <wpeter@us.ibm.com>,
	linux-kernel@vger.kernel.org, lse-tech@lists.sourceforge.net
In-Reply-To: <OF2D7B8881.082D3FA6-ON85256ACC.0075C7C8@raleigh.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <OF2D7B8881.082D3FA6-ON85256ACC.0075C7C8@raleigh.ibm.com>; from wpeter@us.ibm.com on Wed, Sep 19, 2001 at 05:04:59PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 19, 2001 at 05:04:59PM -0500, Peter Wong wrote:
> In order to use Jens' zero-bounce highmem I/O patch against 2.4.6,
> a small modification for the patch is needed. Simply replace
> GFP_BUFFER by GFP_NOIO in block-highmem-all-5.gz, which can be obtained
> at http://www.kernel.org/pub/linux/kernel/people/axboe/patches/2.4.6-pre1/.
> 
> However, there is another problem. For both 2.4.5 and 2.4.6 with
> Jens' patches, if the kernels are built with 4GB highmem, they
> boot without problems. But if the kernels are built with 64GB
> highmem, the kernels hang right after uncompressing Linux. Has
> anyone seen this problem?

block-highmem-all-5 is _very_ _very_ old.
Please upgrade to a recent kernel and patch and report again.

I had a system with PAE enabled and 2.4.9ac + some hacked block-highmem
patch running very well here.  (Probably it still runns :))

	Christoph

-- 
Of course it doesn't work. We've performed a software upgrade.
