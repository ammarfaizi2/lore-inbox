Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264920AbUD2Sld@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264920AbUD2Sld (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Apr 2004 14:41:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264921AbUD2Sld
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Apr 2004 14:41:33 -0400
Received: from holomorphy.com ([207.189.100.168]:33408 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S264920AbUD2Slb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Apr 2004 14:41:31 -0400
Date: Thu, 29 Apr 2004 11:41:26 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.6-rc2-mm2
Message-ID: <20040429184126.GB783@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <20040426013944.49a105a8.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040426013944.49a105a8.akpm@osdl.org>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 26, 2004 at 01:39:44AM -0700, Andrew Morton wrote:
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.6-rc2/2.6.6-rc2-mm2/
> - Largeish reiserfs feature update.  The biggest change is probably the new
>   block allocation algorithm.  See the changelog inside
>   reiserfs-group-alloc-9.patch for details.
> - Added the ia64 CPU hotplug support patch
> - More work against the ext3 block allocator.
> - Several more framebuffer driver update, some quite substantial.
> - Lots of fixes, mostly minor.

I missed -mm1; both this and -mm1 appear to be unable to detect Adaptec
39160 HBA's. I'm in the midst of bisecting this. Thus far I have the
last known-working as virgin 2.6.6-rc2, and first known broken is patch
#36 out of 308 i.e. it's probably in one of the external bk trees or
linus.patch, though linus.patch doesn't seem to have anything related.


-- wli
