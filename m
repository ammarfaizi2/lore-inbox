Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261807AbUB0KQL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Feb 2004 05:16:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261811AbUB0KQL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Feb 2004 05:16:11 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:59401 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S261807AbUB0KQG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Feb 2004 05:16:06 -0500
Date: Fri, 27 Feb 2004 10:16:02 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Adrian Bunk <bunk@fs.tum.de>
Cc: spyro@f2s.com, Scott Bambrough <scottb@rebel.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] remove kernel 2.0 #ifdef's from arm{,26} code
Message-ID: <20040227101602.B17462@flint.arm.linux.org.uk>
Mail-Followup-To: Adrian Bunk <bunk@fs.tum.de>, spyro@f2s.com,
	Scott Bambrough <scottb@rebel.com>, linux-kernel@vger.kernel.org
References: <20040226224333.GW5499@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20040226224333.GW5499@fs.tum.de>; from bunk@fs.tum.de on Thu, Feb 26, 2004 at 11:43:34PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 26, 2004 at 11:43:34PM +0100, Adrian Bunk wrote:
> The patch below removes #ifdef's for kernel 2.0 from 
> arch/arm{,26}/nwfpe/fpmodule.c .
> 
> Please apply

I've applied the ARM bit (not the ARM26).  I've also moved these
two the end of the file, and added an appropriate MODULE_LICENSE.

Thanks.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
