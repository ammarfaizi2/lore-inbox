Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263166AbTJaKAs (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 31 Oct 2003 05:00:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263154AbTJaKAs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 31 Oct 2003 05:00:48 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:6661 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S263166AbTJaKAq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 31 Oct 2003 05:00:46 -0500
Date: Fri, 31 Oct 2003 10:00:43 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Michael Clark <michael@metaparadigm.com>
Cc: greg@kroah.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.6.0-test9 Fix oops in quirk_via_bridge
Message-ID: <20031031100043.B4556@flint.arm.linux.org.uk>
Mail-Followup-To: Michael Clark <michael@metaparadigm.com>, greg@kroah.com,
	linux-kernel@vger.kernel.org
References: <3FA22E6F.8000404@metaparadigm.com> <20031031094946.A4556@flint.arm.linux.org.uk> <3FA2324F.20801@metaparadigm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3FA2324F.20801@metaparadigm.com>; from michael@metaparadigm.com on Fri, Oct 31, 2003 at 05:58:39PM +0800
X-Message-Flag: Your copy of Microsoft Outlook is vulnerable to viruses. See www.mutt.org for more details.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 31, 2003 at 05:58:39PM +0800, Michael Clark wrote:
> Sure, okay. So just consider my post a bug report then as i'm not
> sure what the correct fix is (i'll stick with my patch so I can
> continue to use firewire on my laptop in the meantime).

Your fix looks 99% correct, except for the "__devinitdata" part - if
you drop this and resubmit the patch, I'm sure gregkh will take it.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
