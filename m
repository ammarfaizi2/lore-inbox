Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261422AbUKTJh2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261422AbUKTJh2 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Nov 2004 04:37:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261456AbUKTJh1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Nov 2004 04:37:27 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:9990 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S261422AbUKTJf3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Nov 2004 04:35:29 -0500
Date: Sat, 20 Nov 2004 09:35:22 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Adrian Bunk <bunk@stusta.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] pcmcia/yenta_socket.c: remove an unused function
Message-ID: <20041120093522.C7482@flint.arm.linux.org.uk>
Mail-Followup-To: Adrian Bunk <bunk@stusta.de>,
	linux-kernel@vger.kernel.org
References: <20041028231326.GD3207@stusta.de> <20041029002509.GW29142@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20041029002509.GW29142@stusta.de>; from bunk@stusta.de on Fri, Oct 29, 2004 at 02:25:09AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 29, 2004 at 02:25:09AM +0200, Adrian Bunk wrote:
> The patch below removes an unused function from 
> drivers/pcmcia/yenta_socket.c

I'd rather not remove this function - it's part of a logical set of IO
primitives for this device.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
