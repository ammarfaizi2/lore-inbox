Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261297AbVCYBoS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261297AbVCYBoS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Mar 2005 20:44:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261365AbVCYBJL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Mar 2005 20:09:11 -0500
Received: from fire.osdl.org ([65.172.181.4]:42429 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261297AbVCYBGK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Mar 2005 20:06:10 -0500
Date: Thu, 24 Mar 2005 17:06:07 -0800
From: Chris Wright <chrisw@osdl.org>
To: Ravinandan Arakali <ravinandan.arakali@neterion.com>
Cc: linux-kernel@vger.kernel.org,
       "Leonid. Grossman (E-mail)" <leonid.grossman@neterion.com>
Subject: Re: Problem applying latest 2.6 kernel prepatch(2.6.12-rc1)
Message-ID: <20050325010607.GK28536@shell0.pdx.osdl.net>
References: <004001c530d4$034e99d0$3a10100a@pc.s2io.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <004001c530d4$034e99d0$3a10100a@pc.s2io.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Ravinandan Arakali (ravinandan.arakali@neterion.com) wrote:
> I am trying to submit patches to our driver in the kernel. Since I need a
> copy of latest kernel
> for this, I installed the latest stable version(2.6.5.11). When I apply the
> latest prepatch (2.6.12-rc1)
> on top of this, I have the following problems:
> 1. On application of the prepatch, it reports errors. It looks like some of
> the changes that the
>     prepatch is trying to apply are already present in 2.6.5.11.
> 2. If I ignore these errors and complete the patching, the kernel
> compilation fails.
> 
> Has anybody else seen this problem or am I missing something ?

2.6.12-rc1 is against 2.6.11, so revert 2.6.11.5 patch and patch
forward to 2.6.12-rc1

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
