Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265668AbUFDHkJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265668AbUFDHkJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Jun 2004 03:40:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261951AbUFDHkJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Jun 2004 03:40:09 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:60940 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S265672AbUFDHkG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Jun 2004 03:40:06 -0400
Date: Fri, 4 Jun 2004 08:40:01 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Aaron Mulder <ammulder@alumni.princeton.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Dell TrueMobile 1150 PCMCIA/Orinoco/Yenta problem w/ 2.6.4/5
Message-ID: <20040604084001.A22925@flint.arm.linux.org.uk>
Mail-Followup-To: Aaron Mulder <ammulder@alumni.princeton.edu>,
	linux-kernel@vger.kernel.org
References: <Pine.LNX.4.58.0406022305580.6314@saturn.opentools.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.58.0406022305580.6314@saturn.opentools.org>; from ammulder@alumni.princeton.edu on Wed, Jun 02, 2004 at 11:31:37PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 02, 2004 at 11:31:37PM -0400, Aaron Mulder wrote:
> dmesg (when working; otherwise no eth1 lines come out but the Yenta 
> output still includes the lines related to the 3rd socket):

It'd be useful to see a diff between the dmesg of the two cases, just
in case there's something the above description missed.

Also have a look in sysfs in /sys/class/pcmcia_socket in both cases.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
