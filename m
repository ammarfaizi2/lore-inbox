Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030390AbWHIBHl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030390AbWHIBHl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Aug 2006 21:07:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030393AbWHIBHl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Aug 2006 21:07:41 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:6097 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1030390AbWHIBHk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Aug 2006 21:07:40 -0400
Date: Wed, 9 Aug 2006 11:07:18 +1000
From: Nathan Scott <nathans@sgi.com>
To: Masayuki Saito <m-saito@tnes.nec.co.jp>
Cc: David Chinner <dgc@sgi.com>, xfs@oss.sgi.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] Add new spin_lock for i_flags of xfs_inode
Message-ID: <20060809110718.B2508736@wobbly.melbourne.sgi.com>
References: <20060808205855m-saito@mail.aom.tnes.nec.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20060808205855m-saito@mail.aom.tnes.nec.co.jp>; from m-saito@tnes.nec.co.jp on Tue, Aug 08, 2006 at 08:58:55PM +0900
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 08, 2006 at 08:58:55PM +0900, Masayuki Saito wrote:
> It is the problem that i_flags of xfs_inode has no consistent
> locking protection.
> 
> For the reason, I define a new spin_lock(i_flags_lock) for i_flags
> of xfs_inode.  And I add this spin_lock for appropriate places.

Thanks Masayuki.  I've queued these two patches in my test
kernels, and if Dave has no more comments, I will get this
merged soon (probably 2.6.19 material, as its not had much
exposure yet afaik).

cheers.

-- 
Nathan
