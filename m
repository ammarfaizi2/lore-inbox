Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263544AbUDBCEr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Apr 2004 21:04:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263570AbUDBCEr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Apr 2004 21:04:47 -0500
Received: from fw.osdl.org ([65.172.181.6]:55197 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263544AbUDBCEp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Apr 2004 21:04:45 -0500
Date: Thu, 1 Apr 2004 18:04:41 -0800
From: Chris Wright <chrisw@osdl.org>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Chris Wright <chrisw@osdl.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, kenneth.w.chen@intel.com
Subject: Re: disable-cap-mlock
Message-ID: <20040401180441.B22989@build.pdx.osdl.net>
References: <20040401135920.GF18585@dualathlon.random> <20040401170705.Y22989@build.pdx.osdl.net> <20040402011804.GL18585@dualathlon.random> <20040401173014.Z22989@build.pdx.osdl.net> <20040402013547.GM18585@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20040402013547.GM18585@dualathlon.random>; from andrea@suse.de on Fri, Apr 02, 2004 at 03:35:47AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Andrea Arcangeli (andrea@suse.de) wrote:
> what you missed is that after you locked_vm -= you don't free anything,
> you only unmap them from the address space which means nothing in terms
> of amount if pinned ram.

doesn't it free the huge page right there?  each page gets
huge_page_released, right?

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
