Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261268AbVABPrh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261268AbVABPrh (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Jan 2005 10:47:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261272AbVABPqK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Jan 2005 10:46:10 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:51885 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S261269AbVABPnL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Jan 2005 10:43:11 -0500
Subject: Re: AMD64-AGP pb with AGP APERTURE on IWILL DK8N
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Andi Kleen <ak@muc.de>
Cc: Vincent ETIENNE <ve@vetienne.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       discuss@x86-64.org
In-Reply-To: <m13bxnli1x.fsf@muc.de>
References: <200412282049.48616.ve@vetienne.net>  <m13bxnli1x.fsf@muc.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1104674059.14712.42.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Sun, 02 Jan 2005 14:36:40 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Iau, 2004-12-30 at 19:09, Andi Kleen wrote:
> Vincent ETIENNE <ve@vetienne.net> writes:
> There is already code to do this at the end of the function. A better
> patch would be the attached one.
> 
> This would also handle the case of a wrong aper_base.
> 
> Untested, uncompiled right now.

Please make the final version complain in printk as well. That helps
motivate vendors to fix BIOS problems.

