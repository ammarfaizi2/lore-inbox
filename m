Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262273AbUDDJMr (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Apr 2004 05:12:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262274AbUDDJMr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Apr 2004 05:12:47 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:54290 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S262273AbUDDJMq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Apr 2004 05:12:46 -0400
Date: Sun, 4 Apr 2004 10:12:41 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Linux Kernel List <linux-kernel@vger.kernel.org>,
       Ralf Baechle <ralf@linux-mips.org>
Subject: drivers/char/dz.[ch]: reason for keeping?
Message-ID: <20040404101241.A10158@flint.arm.linux.org.uk>
Mail-Followup-To: Linux Kernel List <linux-kernel@vger.kernel.org>,
	Ralf Baechle <ralf@linux-mips.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Since we have drivers/serial/dz.[ch] now merged, is there a reason to
keep drivers/char/dz.[ch] around any more?  I notice people keep doing
cleanups, but this is wasted effort if the driver is superseded by the
new drivers/serial/dz.[ch] driver.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
