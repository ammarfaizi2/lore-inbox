Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261231AbUBZXRb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Feb 2004 18:17:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261238AbUBZWyr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Feb 2004 17:54:47 -0500
Received: from dp.samba.org ([66.70.73.150]:43215 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S261231AbUBZWyJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Feb 2004 17:54:09 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: Christoph Hellwig <hch@infradead.org>
Cc: "Steven J. Hill" <sjhill@realitydiluted.com>
Cc: Jeremy Higdon <jeremy@sgi.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: Re: [PATCH] 2.6.2, Partition support for SCSI CDROM... 
In-reply-to: Your message of "Tue, 24 Feb 2004 17:06:26 -0000."
             <20040224170626.A25066@infradead.org> 
Date: Fri, 27 Feb 2004 09:51:54 +1100
Message-Id: <20040226225419.27FFA2C363@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <20040224170626.A25066@infradead.org> you write:
> +MODULE_PARM(partitions, "i");
> 
> please make this module_param so it works at boot-time aswell.

But beware: there's another MODULE_PARM in the same module.  You can't
mix them, you'll need to find and fix that too.

Thanks,
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
