Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932192AbVIMEFV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932192AbVIMEFV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Sep 2005 00:05:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932145AbVIMEFV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Sep 2005 00:05:21 -0400
Received: from cantor2.suse.de ([195.135.220.15]:23718 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932132AbVIMEFT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Sep 2005 00:05:19 -0400
From: Andi Kleen <ak@suse.de>
To: discuss@x86-64.org
Subject: Re: [discuss] [patch 2.6.13 (take #2)] swiotlb: BUG() for DMA_NONE in sync_single
Date: Tue, 13 Sep 2005 06:05:30 +0200
User-Agent: KMail/1.8
Cc: "John W. Linville" <linville@tuxdriver.com>,
       Grant Grundler <iod00d@hp.com>, linux-kernel@vger.kernel.org,
       linux-ia64@vger.kernel.org, tony.luck@intel.com,
       Asit.K.Mallick@intel.com
References: <09122005104851.31056@bilbo.tuxdriver.com> <20050912202333.GF21820@esmail.cup.hp.com> <20050912234532.GH19644@tuxdriver.com>
In-Reply-To: <20050912234532.GH19644@tuxdriver.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200509130605.31104.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 13 September 2005 01:45, John W. Linville wrote:
> Call BUG() if DMA_NONE is passed-in as direction for sync_single.
> Also remove unnecessary checks for DMA_NONE in callers of sync_single.
>
> Signed-off-by: John W. Linville <linville@tuxdriver.com>

Hi - your changes look good, but you missed the 2.6.14 merge window now
so it'll be all 2.6.15 material. If you think there are any critical bug fixes
in there (I didn't there were any) please extract them only.

-Andi
