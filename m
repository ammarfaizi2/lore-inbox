Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266565AbUHTLq1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266565AbUHTLq1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Aug 2004 07:46:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266569AbUHTLq1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Aug 2004 07:46:27 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:11783 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S266565AbUHTLqX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Aug 2004 07:46:23 -0400
Date: Fri, 20 Aug 2004 12:46:19 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.8.1-mm3
Message-ID: <20040820124619.B27849@flint.arm.linux.org.uk>
Mail-Followup-To: Andrew Morton <akpm@osdl.org>,
	linux-kernel@vger.kernel.org
References: <20040820031919.413d0a95.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20040820031919.413d0a95.akpm@osdl.org>; from akpm@osdl.org on Fri, Aug 20, 2004 at 03:19:19AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 20, 2004 at 03:19:19AM -0700, Andrew Morton wrote:
> - Added three more bk trees:
> 
> 	bk-fb:		Some ARM framebuffer driver (rmk)
> 	bk-mmc:		ARM-specific media drivers(?)

Not really ARM-specific; it's the Multimedia card subsystem core with
a multimedia block device driver, and a couple of drivers for ARM
multimedia card interfaces.

There has been some interest on this list surrounding the core and
whether it can be used to drive some of these MMC interfaces found on
x86.  I guess it's now watch and see what happens in this space.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
