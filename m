Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268474AbUI2N6e@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268474AbUI2N6e (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Sep 2004 09:58:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268372AbUI2NxC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Sep 2004 09:53:02 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:42511 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S268463AbUI2No1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Sep 2004 09:44:27 -0400
Date: Wed, 29 Sep 2004 14:44:11 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: janitor@sternwelten.at
Cc: akpm@digeo.com, linux-kernel@vger.kernel.org, nacc@us.ibm.com
Subject: Re: [patch 4/4]  mmc: replace schedule_timeout() 	with msleep_interruptible()
Message-ID: <20040929144411.C16537@flint.arm.linux.org.uk>
Mail-Followup-To: janitor@sternwelten.at, akpm@digeo.com,
	linux-kernel@vger.kernel.org, nacc@us.ibm.com
References: <E1CAaWc-0002s3-Fd@sputnik>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <E1CAaWc-0002s3-Fd@sputnik>; from janitor@sternwelten.at on Thu, Sep 23, 2004 at 10:49:10PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 23, 2004 at 10:49:10PM +0200, janitor@sternwelten.at wrote:
> Description: Use msleep_interruptible() instead of schedule_timeout()
> to guarantee the task delays as expected.

Applied, thanks.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
