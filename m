Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262832AbVEGIpF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262832AbVEGIpF (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 May 2005 04:45:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262802AbVEGInh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 May 2005 04:43:37 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:18191 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S262832AbVEGIlE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 May 2005 04:41:04 -0400
Date: Sat, 7 May 2005 09:40:57 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: "Hyok S. Choi" <hyok.choi@samsung.com>
Cc: Linux-Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: drivers/block/rd.c rd_size reference problem of ARM
Message-ID: <20050507094057.B11839@flint.arm.linux.org.uk>
Mail-Followup-To: "Hyok S. Choi" <hyok.choi@samsung.com>,
	Linux-Kernel List <linux-kernel@vger.kernel.org>
References: <0IG400GKZ1K24Y@mmp2.samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <0IG400GKZ1K24Y@mmp2.samsung.com>; from hyok.choi@samsung.com on Sat, May 07, 2005 at 05:12:48PM +0900
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 07, 2005 at 05:12:48PM +0900, Hyok S. Choi wrote:
> the variable "rd_size" of drivers/block/rd.c is changed to be "static" in
> 2.6.12-rc3-mm3.
> it causes compilation error to ARM architecture because of the reference of
> that.
>  
> I blocked the reference as below, for compilation, but need to refine.

The change which caused this has been removed in -rc4, and Andrew is
probably going to drop this as well.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
