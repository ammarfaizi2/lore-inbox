Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1031440AbWKUVqZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031440AbWKUVqZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Nov 2006 16:46:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031441AbWKUVqZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Nov 2006 16:46:25 -0500
Received: from caramon.arm.linux.org.uk ([217.147.92.249]:47889 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S1031440AbWKUVqY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Nov 2006 16:46:24 -0500
Date: Tue, 21 Nov 2006 21:46:17 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Adrian Bunk <bunk@stusta.de>
Cc: Dominik Brodowski <linux@brodo.de>, linux-pcmcia@lists.infradead.org,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC: 2.6 patch] the overdue removal of drivers/pcmcia/pcmcia_ioctl.c
Message-ID: <20061121214616.GA3983@flint.arm.linux.org.uk>
Mail-Followup-To: Adrian Bunk <bunk@stusta.de>,
	Dominik Brodowski <linux@brodo.de>,
	linux-pcmcia@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20061121213419.GS5200@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061121213419.GS5200@stusta.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 21, 2006 at 10:34:19PM +0100, Adrian Bunk wrote:
> This patch contains the overdue removal of drivers/pcmcia/pcmcia_ioctl.c 
> plus additional cleanups possible after this removal.

There are still systems around which (a) use cardmgr rather than the new
pcmcia utils, and (b) applications make direct ioctl calls to the kernel
PCMCIA layer external to the pcmcia-cs packages.

Like it or not, the PCMCIA ioctls are a well-established API.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
