Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264565AbTKNQ7T (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Nov 2003 11:59:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264566AbTKNQ7T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Nov 2003 11:59:19 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:23812 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S264565AbTKNQ7S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Nov 2003 11:59:18 -0500
Date: Fri, 14 Nov 2003 16:59:13 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Guennadi Liakhovetski <gl@dsa-ac.de>
Cc: ARM Linux kernel <linux-arm-kernel@lists.arm.linux.org.uk>,
       linux-kernel@vger.kernel.org,
       Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: Re: Oops in flash
Message-ID: <20031114165913.B17247@flint.arm.linux.org.uk>
Mail-Followup-To: Guennadi Liakhovetski <gl@dsa-ac.de>,
	ARM Linux kernel <linux-arm-kernel@lists.arm.linux.org.uk>,
	linux-kernel@vger.kernel.org,
	Guennadi Liakhovetski <g.liakhovetski@gmx.de>
References: <Pine.LNX.4.33.0311141737560.2153-100000@pcgl.dsa-ac.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.33.0311141737560.2153-100000@pcgl.dsa-ac.de>; from gl@dsa-ac.de on Fri, Nov 14, 2003 at 05:53:00PM +0100
X-Message-Flag: Your copy of Microsoft Outlook is vulnerable to viruses. See www.mutt.org for more details.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 14, 2003 at 05:53:00PM +0100, Guennadi Liakhovetski wrote:
> The patch is small and simple, one just has to find a suitable place for
> it. Also, we don't set the oops_in_progress variable on ARM - it can be
> quite nicely used for this purpose. Should we do it regardless?

2.6 ARM kernels do set this variable on oops.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
