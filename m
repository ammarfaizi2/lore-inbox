Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261358AbUKJIg7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261358AbUKJIg7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Nov 2004 03:36:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261293AbUKJIg7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Nov 2004 03:36:59 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:51728 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S261358AbUKJIgk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Nov 2004 03:36:40 -0500
Date: Wed, 10 Nov 2004 08:36:30 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Paul Mackerras <paulus@samba.org>
Cc: Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Driver Core patches for 2.6.10-rc1
Message-ID: <20041110083629.A17555@flint.arm.linux.org.uk>
Mail-Followup-To: Paul Mackerras <paulus@samba.org>,
	Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org
References: <1099346276148@kroah.com> <10993462773570@kroah.com> <20041102223229.A10969@flint.arm.linux.org.uk> <20041107152805.B4009@flint.arm.linux.org.uk> <20041110013700.GF9496@kroah.com> <16785.33677.704803.889900@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <16785.33677.704803.889900@cargo.ozlabs.ibm.com>; from paulus@samba.org on Wed, Nov 10, 2004 at 01:57:17PM +1100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 10, 2004 at 01:57:17PM +1100, Paul Mackerras wrote:
> So we can get a driver's probe method called concurrently with its
> bus's suspend or resume method.

If correct, we probably have rather a lot of buggy drivers, because
I certainly was not aware that this could happen.  I suspect the
average driver writer also would not be aware of that.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
