Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262152AbVDLVFx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262152AbVDLVFx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Apr 2005 17:05:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262109AbVDLVDt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Apr 2005 17:03:49 -0400
Received: from fire.osdl.org ([65.172.181.4]:47051 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S263019AbVDLUzA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Apr 2005 16:55:00 -0400
Date: Tue, 12 Apr 2005 13:54:33 -0700
From: Chris Wright <chrisw@osdl.org>
To: blaisorblade@yahoo.it
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org,
       user-mode-linux-devel@lists.sourceforge.net, stable@kernel.org
Subject: Re: [stable] [patch 1/1] uml: add nfsd syscall when nfsd is modular
Message-ID: <20050412205433.GS11199@shell0.pdx.osdl.net>
References: <20050412175209.10A11126095@zion>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050412175209.10A11126095@zion>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* blaisorblade@yahoo.it (blaisorblade@yahoo.it) wrote:
> 
> CC: <stable@kernel.org>
> 
> This trick is useless, because sys_ni.c will handle this problem by itself,
> like it does even on UML for other syscalls.
> Also, it does not provide the NFSD syscall when NFSD is compiled as a module,
> which is a big problem.

Thanks, queued to -stable.
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
