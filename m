Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262203AbVD1SLU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262203AbVD1SLU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Apr 2005 14:11:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262207AbVD1SLU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Apr 2005 14:11:20 -0400
Received: from fire.osdl.org ([65.172.181.4]:49087 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262203AbVD1SLG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Apr 2005 14:11:06 -0400
Date: Thu, 28 Apr 2005 11:10:53 -0700
From: Chris Wright <chrisw@osdl.org>
To: blaisorblade@yahoo.it
Cc: akpm@osdl.org, jdike@addtoit.com, bstroesser@fujitsu-siemens.com,
       linux-kernel@vger.kernel.org,
       user-mode-linux-devel@lists.sourceforge.net
Subject: Re: [patch 1/7] uml: fix syscall table by including $(SUBARCH)'s one, for i386
Message-ID: <20050428181053.GQ23013@shell0.pdx.osdl.net>
References: <20050424181909.81B8F33AED@zion>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050424181909.81B8F33AED@zion>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* blaisorblade@yahoo.it (blaisorblade@yahoo.it) wrote:
> 
> Split the i386 entry.S files into entry.S and syscall_table.S which
> is included in the previous one (so actually there is no difference between
> them) and use the syscall_table.S in the UML build, instead of tracking by
> hand the syscall table changes (which is inherently error-prone).

Xen can use this as well (it was on my todo list).

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
