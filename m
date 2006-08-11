Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030667AbWHKCLc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030667AbWHKCLc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Aug 2006 22:11:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030670AbWHKCLc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Aug 2006 22:11:32 -0400
Received: from mx1.redhat.com ([66.187.233.31]:23185 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1030660AbWHKCLb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Aug 2006 22:11:31 -0400
Message-ID: <44DBE741.2080801@redhat.com>
Date: Thu, 10 Aug 2006 21:11:13 -0500
From: Eric Sandeen <esandeen@redhat.com>
User-Agent: Thunderbird 1.5.0.5 (Macintosh/20060719)
MIME-Version: 1.0
To: cmm@us.ibm.com
CC: Andrew Morton <akpm@osdl.org>, linux-fsdevel@vger.kernel.org,
       ext2-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [Ext2-devel] [PATCH 2/9] sector_t format string
References: <1155172843.3161.81.camel@localhost.localdomain>	<20060809234019.c8a730e3.akpm@osdl.org> <1155257941.4505.32.camel@dyn9047017069.beaverton.ibm.com>
In-Reply-To: <1155257941.4505.32.camel@dyn9047017069.beaverton.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mingming Cao wrote:

> When we cleanup ext3 code to fix some "int" type block numbers to
> "unsigned long" type to able to truely support 2^32 bit ext3 (otherwise
> ext3 is limited to 2^31 blocks (8TB)), we had to go through a lot of
> printk to modify the format string from %d to %lu. It's a pain.

<OT>
FWIW, ext3 still isn't 32-bit clean, in my testing.  The types are ok but the 
code overflows them with arithmetic in some places.  Look for patches from me 
soon ;-)
</OT>

-eric

