Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269139AbUINDUU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269139AbUINDUU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Sep 2004 23:20:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269125AbUINDTW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Sep 2004 23:19:22 -0400
Received: from holomorphy.com ([207.189.100.168]:33168 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S269139AbUINDRs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Sep 2004 23:17:48 -0400
Date: Mon, 13 Sep 2004 20:17:05 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Hanna Linder <hannal@us.ibm.com>
Cc: rth@twiddle.net, ink@jurassic.park.msu.ru, linux-kernel@vger.kernel.org,
       greg@kroah.com
Subject: Re: [RFT 2.6.9-rc1 alpha sys_alcor.c] [1/2] convert pci_find_device to pci_get_device
Message-ID: <20040914031705.GX9106@holomorphy.com>
References: <806400000.1095118633@w-hlinder.beaverton.ibm.com> <20040914020257.GF9106@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040914020257.GF9106@holomorphy.com>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 13, 2004 at 04:37:13PM -0700, Hanna Linder wrote:
>> Here is a very simple patch to convert pci_find_device call to
>> pci_get_device. As I don't have an alpha box or cross compiler could
>> someone (wli- wink wink) please verify it compiles and doesn't break
>> anything, thanks a lot.

On Mon, Sep 13, 2004 at 07:02:57PM -0700, William Lee Irwin III wrote:
> I can run it through a compiler, but I won't be able to do meaningful
> runtime testing on it as I only have tincup and alphapc systems. They
> look safe at first glance.

More specifically, if these were merely alpha-specific drivers, I could
do meaningful testing as they would attempt to be detected this way.
But this is system-specific initialization executed conditionally on
the system type, so as the systems I have are not the ones affected by
these patches, if I were to attempt a runtime test I would merely
discover that the code was not executed.


-- wli
