Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264577AbTLKJRN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Dec 2003 04:17:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264581AbTLKJRN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Dec 2003 04:17:13 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:12807 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S264577AbTLKJRL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Dec 2003 04:17:11 -0500
Date: Thu, 11 Dec 2003 09:17:07 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Guennadi Liakhovetski <gl@dsa-ac.de>
Cc: linux-kernel@vger.kernel.org,
       Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: Re: [2.6.0-test11: PCMCIA] i82365: No such device...
Message-ID: <20031211091707.A23722@flint.arm.linux.org.uk>
Mail-Followup-To: Guennadi Liakhovetski <gl@dsa-ac.de>,
	linux-kernel@vger.kernel.org,
	Guennadi Liakhovetski <g.liakhovetski@gmx.de>
References: <Pine.LNX.4.33.0312110920090.1130-100000@pcgl.dsa-ac.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.33.0312110920090.1130-100000@pcgl.dsa-ac.de>; from gl@dsa-ac.de on Thu, Dec 11, 2003 at 09:37:38AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 11, 2003 at 09:37:38AM +0100, Guennadi Liakhovetski wrote:
> 00:13.0 CardBus bridge: Toshiba America Info Systems ToPIC95 (rev 07)
          ^^^^^^^^^^^^^^

Cardbus is 32-bit, so you need to use yenta not i82365.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
