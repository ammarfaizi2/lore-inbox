Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261988AbVF0Ja5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261988AbVF0Ja5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Jun 2005 05:30:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261993AbVF0Ja5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Jun 2005 05:30:57 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:18446 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S261988AbVF0Jau (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Jun 2005 05:30:50 -0400
Date: Mon, 27 Jun 2005 10:30:42 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: David McCullough <davidm@snapgear.com>
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Paul Mackerass <paulus@au.ibm.com>,
       Mikael Starvik <starvik@axis.com>
Subject: Re: [PATCH] Add removal schedule of register_serial/unregister_serial to appropriate file
Message-ID: <20050627103042.C10822@flint.arm.linux.org.uk>
Mail-Followup-To: David McCullough <davidm@snapgear.com>,
	Linux Kernel List <linux-kernel@vger.kernel.org>,
	Andrew Morton <akpm@osdl.org>, Paul Mackerass <paulus@au.ibm.com>,
	Mikael Starvik <starvik@axis.com>
References: <20050623142335.A5564@flint.arm.linux.org.uk> <20050625104725.A16381@flint.arm.linux.org.uk> <20050627003655.GD27196@beast>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20050627003655.GD27196@beast>; from davidm@snapgear.com on Mon, Jun 27, 2005 at 10:36:55AM +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 27, 2005 at 10:36:55AM +1000, David McCullough wrote:
> Jivin Russell King lays it down ...
> > drivers/serial/68328serial.c:int register_serial(struct serial_struct *req)
> > drivers/serial/68328serial.c:void unregister_serial(int line)
> 
> These can go.  AFAICT they were never used and I have no idea why they
> are there.

Thanks David.  I've just committed a patch to remove these.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
