Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261340AbVEFXbU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261340AbVEFXbU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 May 2005 19:31:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261335AbVEFXaS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 May 2005 19:30:18 -0400
Received: from ozlabs.org ([203.10.76.45]:32430 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S261340AbVEFXXB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 May 2005 19:23:01 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17019.64610.454584.566932@cargo.ozlabs.ibm.com>
Date: Sat, 7 May 2005 09:23:14 +1000
From: Paul Mackerras <paulus@samba.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Kumar Gala <galak@freescale.com>, linuxppc-dev@ozlabs.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ppc32: Fix POWER3/POWER4 compiler error
In-Reply-To: <Pine.LNX.4.61.0505061336250.28348@nylon.am.freescale.net>
References: <Pine.LNX.4.61.0505061336250.28348@nylon.am.freescale.net>
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kumar Gala writes:

> In separating out support for hardware floating point we missed the fact that
> both POWER3 and POWER4 have HW FP.  Enable CONFIG_PPC_FPU for POWER3 
> and POWER4 fixes the issue.
> 
> Signed-off-by: Kumar Gala <kumar.gala@freescale.com>
Acked-by: Paul Mackerras <paulus@samba.org>
