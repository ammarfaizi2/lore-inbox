Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265863AbUE1Hso@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265863AbUE1Hso (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 May 2004 03:48:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265864AbUE1Hso
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 May 2004 03:48:44 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:61201 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S265863AbUE1Hsn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 May 2004 03:48:43 -0400
Date: Fri, 28 May 2004 08:48:40 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Hirokazu Takata <takata@linux-m32r.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] m32r - Upgrade to v2.6.6 kernel
Message-ID: <20040528084840.A4834@flint.arm.linux.org.uk>
Mail-Followup-To: Hirokazu Takata <takata@linux-m32r.org>,
	linux-kernel@vger.kernel.org
References: <20040528.131611.28785624.takata.hirokazu@renesas.com> <20040528072336.GD7499@pazke>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20040528072336.GD7499@pazke>; from pazke@donpac.ru on Fri, May 28, 2004 at 11:23:36AM +0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 28, 2004 at 11:23:36AM +0400, Andrey Panin wrote:
> 3) arch/m32r/drivers/smc91111.copying contains GPL copy. Do you really
> need it ?  arch/m32r/drivers/smc91111.readme.txt can happily live in
> Documentation/networking.

We're currently working with Jeff Garzik to merge a SMC91x driver which
which can drive SMC91C111 chips from Nicolas Pitre.  It would be good
if m32r could use this driver as well.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
