Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265755AbUADQ1b (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Jan 2004 11:27:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265756AbUADQ1b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Jan 2004 11:27:31 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:52752 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S265755AbUADQ13 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Jan 2004 11:27:29 -0500
Date: Sun, 4 Jan 2004 16:27:23 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Amit Gurdasani <amitg@alumni.cmu.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: EISA ID for PnP modem and resource allocation
Message-ID: <20040104162723.B27227@flint.arm.linux.org.uk>
Mail-Followup-To: Amit Gurdasani <amitg@alumni.cmu.edu>,
	linux-kernel@vger.kernel.org
References: <Pine.LNX.4.56.0312261610200.1798@athena>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.56.0312261610200.1798@athena>; from amitg@alumni.cmu.edu on Fri, Dec 26, 2003 at 04:51:53PM +0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 26, 2003 at 04:51:53PM +0400, Amit Gurdasani wrote:
> I have a PROLiNK 1456VH internal Rockwell-based ISA PnP K56flex fax modem
> whose EISA ID seems not to be known to 8250_pnp.c. The ID is AEI0250 as
> reported in /sys/devices/pnp1/01:01/01:01.00/id and adding this into the
> pnp_dev_table[] allows the device to be found and enabled properly by the
> 8250 serial driver.

Thanks, patch applied.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
