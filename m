Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269479AbUICBXw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269479AbUICBXw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Sep 2004 21:23:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269487AbUICBRp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Sep 2004 21:17:45 -0400
Received: from ozlabs.org ([203.10.76.45]:21666 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S269494AbUICBOp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Sep 2004 21:14:45 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16695.50554.389435.137893@cargo.ozlabs.ibm.com>
Date: Fri, 3 Sep 2004 11:14:34 +1000
From: Paul Mackerras <paulus@samba.org>
To: Tom Rini <trini@kernel.crashing.org>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH,RFC 2.6.9-rc1 2/2] zlib_inflate: Add __BOOTER__ around zlib_inflate_trees_fixed(...)
In-Reply-To: <20040902174707.GC26144@smtp.west.cox.net>
References: <20040901231659.GA20624@smtp.west.cox.net>
	<20040902173626.GB26144@smtp.west.cox.net>
	<20040902174707.GC26144@smtp.west.cox.net>
X-Mailer: VM 7.18 under Emacs 21.3.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tom Rini writes:

> This is the second part of what I found.  zlib_inflate_trees_fixed(...)
> isn't called in decompressing a kernel.  Dropping this, and the call to

I think it is just luck that gzip hasn't used the fixed table in
compressing the kernel.  I don't think we have any guarantee that gzip
won't use the fixed table.

Just out of interest, how big is a bzip2 decompressor?

Regards,
Paul.
