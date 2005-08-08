Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932196AbVHHSyW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932196AbVHHSyW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Aug 2005 14:54:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932198AbVHHSyW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Aug 2005 14:54:22 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:45067 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S932196AbVHHSyV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Aug 2005 14:54:21 -0400
Date: Mon, 8 Aug 2005 19:54:11 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: "Mukund JB." <mukundjb@esntechnologies.co.in>
Cc: linux-kernel@vger.kernel.org
Subject: Re: HOW to handle partitions on SD Card in the driver?
Message-ID: <20050808195411.E12788@flint.arm.linux.org.uk>
Mail-Followup-To: "Mukund JB." <mukundjb@esntechnologies.co.in>,
	linux-kernel@vger.kernel.org
References: <C349E772C72290419567CFD84C26E0170424F4@mail.esn.co.in>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <C349E772C72290419567CFD84C26E0170424F4@mail.esn.co.in>; from mukundjb@esntechnologies.co.in on Fri, Aug 05, 2005 at 11:30:43AM +0530
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 05, 2005 at 11:30:43AM +0530, Mukund JB. wrote:
> I have problem with my new driver that tired to support the partitions
> support on SD cards.

Have you thought about using the generic mmc layer in drivers/mmc with
the SD patches which are available in the -mm kernels?

We don't want two MMC/SD subsystems in the kernel.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
