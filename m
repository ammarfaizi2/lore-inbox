Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264307AbUGFTOx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264307AbUGFTOx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jul 2004 15:14:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264346AbUGFTOx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jul 2004 15:14:53 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:61959 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S264307AbUGFTOv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jul 2004 15:14:51 -0400
Date: Tue, 6 Jul 2004 20:14:47 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Kefalas Apostolos <akef@freemail.gr>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: compiling 2.6.7
Message-ID: <20040706201447.A28227@flint.arm.linux.org.uk>
Mail-Followup-To: Kefalas Apostolos <akef@freemail.gr>,
	Linux Kernel <linux-kernel@vger.kernel.org>
References: <200407062123.09586.akef@freemail.gr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200407062123.09586.akef@freemail.gr>; from akef@freemail.gr on Tue, Jul 06, 2004 at 09:23:09PM +0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 06, 2004 at 09:23:09PM +0300, Kefalas Apostolos wrote:
> I am compiling kernel 2.6.5 and i get the following errors:
> 
> drivers/pcmcia/i82365.c: In function `is_alive':
> drivers/pcmcia/i82365.c:672: warning: `check_region' is deprecated (declared 
> at include/linux/ioport.h:121)
> drivers/pcmcia/i82365.c: In function `isa_probe':
> drivers/pcmcia/i82365.c:806: warning: `check_region' is deprecated (declared 
> at include/linux/ioport.h:121)
> drivers/pcmcia/i82365.c: In function `i365_set_io_map':
> drivers/pcmcia/i82365.c:1134: warning: comparison is always false due to 
> limited range of data type
> drivers/pcmcia/i82365.c:1134: warning: comparison is always false due to 
> limited range of data type

They're actually warnings and are harmless to the average user (but
serve as reminders that stuff needs some work to the developer.)

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
