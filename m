Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263685AbUDYXA5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263685AbUDYXA5 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Apr 2004 19:00:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263704AbUDYXA5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Apr 2004 19:00:57 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:47632 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S263685AbUDYXAx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Apr 2004 19:00:53 -0400
Date: Mon, 26 Apr 2004 00:00:50 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Kenn Humborg <kenn@linux.ie>
Cc: Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Platform device matching
Message-ID: <20040426000050.F13748@flint.arm.linux.org.uk>
Mail-Followup-To: Kenn Humborg <kenn@linux.ie>,
	Linux-Kernel <linux-kernel@vger.kernel.org>
References: <20040425220511.GA20808@excalibur.research.wombat.ie>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20040425220511.GA20808@excalibur.research.wombat.ie>; from kenn@linux.ie on Sun, Apr 25, 2004 at 11:05:11PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 25, 2004 at 11:05:11PM +0100, Kenn Humborg wrote:
> I'm looking at the code for binding platform devices with drivers.  
> However, platform_match() doesn't seem to agree with its kerneldoc
> comment:

The code is correct as stands.  The documentation is behind times.  All
platform devices are "<name><instance-number>" so it's correct that the
"floppy" driver matches "floppy0" and "floppy1" etc.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
