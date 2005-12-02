Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964781AbVLBCWQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964781AbVLBCWQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Dec 2005 21:22:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964796AbVLBCWQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Dec 2005 21:22:16 -0500
Received: from rtr.ca ([64.26.128.89]:61628 "EHLO mail.rtr.ca")
	by vger.kernel.org with ESMTP id S964781AbVLBCWQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Dec 2005 21:22:16 -0500
Message-ID: <438FAFD5.9070008@rtr.ca>
Date: Thu, 01 Dec 2005 21:22:13 -0500
From: Mark Lord <lkml@rtr.ca>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051013 Debian/1.7.12-1ubuntu1
X-Accept-Language: en, en-us
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
Cc: Dave Jones <davej@redhat.com>, linux-kernel@vger.kernel.org,
       torvalds@osdl.org
Subject: Re: [PATCH] Fix bytecount result from printk()
References: <438F1D05.5020004@rtr.ca>	<20051201175732.GD19433@redhat.com> <20051201180459.2afa2b1d.akpm@osdl.org>
In-Reply-To: <20051201180459.2afa2b1d.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
>
> Please review these patches, queued since 2.6.15-rc1-mm1:
> 
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.15-rc3/2.6.15-rc3-mm1/broken-out/printk-return-value-fix-it.patch
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.15-rc3/2.6.15-rc3-mm1/broken-out/kmsg_write-dont-return-printk-return-value.patch

Yes, those patches actually appear to fix the counting.

The patch I submitted merely makes it internally consistent
within printk/vprintk(), but does not change it to actually
be correct.

Cheers
