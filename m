Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261920AbUDELE5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Apr 2004 07:04:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261969AbUDELE5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Apr 2004 07:04:57 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:14606 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S261920AbUDELEz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Apr 2004 07:04:55 -0400
Date: Mon, 5 Apr 2004 12:04:52 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Ruud Linders <rkmp@xs4all.nl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.x kernels and ttyS45 for 6 serial ports ?
Message-ID: <20040405120452.B31038@flint.arm.linux.org.uk>
Mail-Followup-To: Ruud Linders <rkmp@xs4all.nl>,
	linux-kernel@vger.kernel.org
References: <4071367B.2060103@xs4all.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <4071367B.2060103@xs4all.nl>; from rkmp@xs4all.nl on Mon, Apr 05, 2004 at 12:35:39PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 05, 2004 at 12:35:39PM +0200, Ruud Linders wrote:
> Now checking this on 2.6.5 it got more confusing, I now have with
> total of 6 serial ports a device number ttyS45 !?

And what happens if you detect a PCI modem at IO address 0x2e8 after
you've detected your PCI card and assigned it ttyS4?

Don't you think that would complain that their modem should be assigned
ttyS4 rather than their PCI multiport card getting it?

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
