Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267818AbUJOB1f@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267818AbUJOB1f (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Oct 2004 21:27:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267986AbUJOB1f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Oct 2004 21:27:35 -0400
Received: from ozlabs.org ([203.10.76.45]:11997 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S267818AbUJOB1e (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Oct 2004 21:27:34 -0400
Subject: Re: [PATCH 2.6.9-rc3-mm2] [m32r] SIO driver for m32r
From: Rusty Russell <rusty@rustcorp.com.au>
To: Hirokazu Takata <takata@linux-m32r.org>
Cc: Andrew Morton <akpm@osdl.org>,
       lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Russell King <rmk+lkml@arm.linux.org.uk>
In-Reply-To: <20041006.151912.840807084.takata.hirokazu@renesas.com>
References: <20041006.151912.840807084.takata.hirokazu@renesas.com>
Content-Type: text/plain
Message-Id: <1097803665.22673.37.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Fri, 15 Oct 2004 11:27:45 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-10-06 at 16:19, Hirokazu Takata wrote:
> Hello,
> 
> Here is a patch to support the M32R SIO (serial IO) driver.
> Please apply.

> +MODULE_PARM(share_irqs_sio, "i");

Hi Hirokazu!

	Please use the modern "module_param(share_irqs_sio, bool, 0400)" here
(I assume you don't want this parameter to be writable, hence the 0400
permissions).  MODULE_PARM is deprecated.

Thankyou!
Rusty.
-- 
Anyone who quotes me in their signature is an idiot -- Rusty Russell

