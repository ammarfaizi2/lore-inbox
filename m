Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262356AbUKKUxR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262356AbUKKUxR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Nov 2004 15:53:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262361AbUKKUxQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Nov 2004 15:53:16 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:13829 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S262356AbUKKUwH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Nov 2004 15:52:07 -0500
Date: Thu, 11 Nov 2004 20:52:02 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Paul Mackerras <paulus@samba.org>
Cc: Greg KH <greg@kroah.com>, Patrick Mochel <mochel@digitalimplant.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Driver Core patches for 2.6.10-rc1
Message-ID: <20041111205202.A28525@flint.arm.linux.org.uk>
Mail-Followup-To: Paul Mackerras <paulus@samba.org>,
	Greg KH <greg@kroah.com>,
	Patrick Mochel <mochel@digitalimplant.org>,
	linux-kernel@vger.kernel.org
References: <1099346276148@kroah.com> <10993462773570@kroah.com> <20041102223229.A10969@flint.arm.linux.org.uk> <20041107152805.B4009@flint.arm.linux.org.uk> <20041110013700.GF9496@kroah.com> <16785.33677.704803.889900@cargo.ozlabs.ibm.com> <20041110083629.A17555@flint.arm.linux.org.uk> <16786.35271.622222.193502@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <16786.35271.622222.193502@cargo.ozlabs.ibm.com>; from paulus@samba.org on Thu, Nov 11, 2004 at 08:36:07AM +1100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 11, 2004 at 08:36:07AM +1100, Paul Mackerras wrote:
> I think that what has saved us to some extent is that we only do
> suspend/resume on UP machines so far.

and probably without kernel preemption enabled.  Kernel preemption
should in theory at least open the same can of worms in this area
as SMP does.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
