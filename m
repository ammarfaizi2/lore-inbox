Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262260AbUCEI6u (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Mar 2004 03:58:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262263AbUCEI6u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Mar 2004 03:58:50 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:17159 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S262260AbUCEI6s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Mar 2004 03:58:48 -0500
Date: Fri, 5 Mar 2004 08:58:38 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: "debian-powerpc@lists.debian.org" <debian-powerpc@lists.debian.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       Matthias Urlichs <smurf@smurf.noris.de>,
       =?iso-8859-1?Q?Martin-=C9ric_Racine?= <q-funk@pp.fishpool.fi>
Subject: Re: [PATCH] For test only: pmac_zilog fixes (cups lockup at boot):
Message-ID: <20040305085838.B22156@flint.arm.linux.org.uk>
Mail-Followup-To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	"debian-powerpc@lists.debian.org" <debian-powerpc@lists.debian.org>,
	Linux Kernel list <linux-kernel@vger.kernel.org>,
	Matthias Urlichs <smurf@smurf.noris.de>,
	=?iso-8859-1?Q?Martin-=C9ric_Racine?= <q-funk@pp.fishpool.fi>
References: <1078473270.5703.57.camel@gaston>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1078473270.5703.57.camel@gaston>; from benh@kernel.crashing.org on Fri, Mar 05, 2004 at 06:54:31PM +1100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 05, 2004 at 06:54:31PM +1100, Benjamin Herrenschmidt wrote:
> Ok, so I finally got a hand on the problems. A mix of bugs in
> the driver, bugs in the HW, and bugs in the TTY layer ! pfiew.

I'm not even going to bother reviewing these changes - the gratuitous
change of "up" to "uap" makes this task virtually impossible.

Please separate out the changes.

Thanks.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
