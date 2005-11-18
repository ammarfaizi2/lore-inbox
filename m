Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030593AbVKRJCR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030593AbVKRJCR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Nov 2005 04:02:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030592AbVKRJCR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Nov 2005 04:02:17 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:28428 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S1030590AbVKRJCP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Nov 2005 04:02:15 -0500
Date: Fri, 18 Nov 2005 09:01:59 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Adrian Bunk <bunk@stusta.de>
Cc: saw@saw.sw.com.sg, jgarzik@pobox.com, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org
Subject: Re: [RFC: 2.6 patch] remove drivers/net/eepro100.c
Message-ID: <20051118090158.GA11621@flint.arm.linux.org.uk>
Mail-Followup-To: Adrian Bunk <bunk@stusta.de>, saw@saw.sw.com.sg,
	jgarzik@pobox.com, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
References: <20051118033302.GO11494@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051118033302.GO11494@stusta.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 18, 2005 at 04:33:02AM +0100, Adrian Bunk wrote:
> This patch removes the obsolete drivers/net/eepro100.c driver.
> 
> Is there any reason why it should be kept?

Tt's the only driver which works correctly on ARM CPUs.  e100 is
basically buggy.  This has been discussed here on lkml and more
recently on linux-netdev.  If anyone has any further questions
please read the archives of those two lists.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
