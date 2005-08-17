Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751198AbVHQSyI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751198AbVHQSyI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Aug 2005 14:54:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751200AbVHQSyI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Aug 2005 14:54:08 -0400
Received: from liaag1ae.mx.compuserve.com ([149.174.40.31]:62115 "EHLO
	liaag1ae.mx.compuserve.com") by vger.kernel.org with ESMTP
	id S1751198AbVHQSyH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Aug 2005 14:54:07 -0400
Date: Wed, 17 Aug 2005 14:49:48 -0400
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: FPU-intensive programs crashing with floating point
  exception on Cyrix MII
To: Ondrej Zary <linux@rainbow-software.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <200508171453_MC3-1-A76E-CAE6@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 17 Aug 2005 at 18:13:55 +0200, Ondrej Zary wrote:

> When I run a program that uses FPU, it sometimes crashes with "flaoting 
> point exception"


> +     printk("MATH ERROR %d\n",((~cwd) & swd & 0x3f) | (swd & 0x240));

  Could you modify this to print the full values of cwd and swd like this?

        printk("MATH ERROR: cwd = 0x%hx, swd = 0x%hx\n", cwd, swd);

Then post the result.


__
Chuck
