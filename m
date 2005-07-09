Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261186AbVGILJy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261186AbVGILJy (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Jul 2005 07:09:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261190AbVGILJy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Jul 2005 07:09:54 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:64778 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S261186AbVGILJw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Jul 2005 07:09:52 -0400
Date: Sat, 9 Jul 2005 12:09:47 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Dave Airlie <airlied@linux.ie>
Cc: Andrew Morton <akpm@osdl.org>, torvalds@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [git tree] DRM fixes/cleanups tree
Message-ID: <20050709120947.D2175@flint.arm.linux.org.uk>
Mail-Followup-To: Dave Airlie <airlied@linux.ie>,
	Andrew Morton <akpm@osdl.org>, torvalds@osdl.org,
	linux-kernel@vger.kernel.org
References: <Pine.LNX.4.58.0507091202460.6297@skynet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.58.0507091202460.6297@skynet>; from airlied@linux.ie on Sat, Jul 09, 2005 at 12:04:07PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 09, 2005 at 12:04:07PM +0100, Dave Airlie wrote:
>  ati_pcigart.c |    2 -
>  drm.h         |    2 +
>  drmP.h        |   30 ++++--------------
>  drm_auth.c    |    4 +-
>...
>  i915_irq.c    |    4 +-
>  r128_state.c  |    2 -
>  25 files changed, 146 insertions(+), 194 deletions(-)

Can folk consider using the -p argument to diffstat to obtain the full
path to the file from the kernels top directory please?

Consider the case where you modify just a Kconfig or Makefile.  What
use does a diffstat showing that just one Makefile or Kconfig somewhere
in the kernel tree was modified, but not where it was?

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
