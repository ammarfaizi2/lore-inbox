Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261204AbUBVJHR (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Feb 2004 04:07:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261205AbUBVJHR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Feb 2004 04:07:17 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:47113 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S261204AbUBVJHQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Feb 2004 04:07:16 -0500
Date: Sun, 22 Feb 2004 09:07:11 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: linux-kernel@vger.kernel.org, Jim Wilson <wilson@specifixinc.com>,
       Judith Lebzelter <judith@osdl.org>, Dan Kegel <dank@kegel.com>,
       cliff white <cliffw@osdl.org>, "Timothy D. Witham" <wookie@osdl.org>
Subject: Re: Kernel Cross Compiling [update]
Message-ID: <20040222090711.A11210@flint.arm.linux.org.uk>
Mail-Followup-To: linux-kernel@vger.kernel.org,
	Jim Wilson <wilson@specifixinc.com>,
	Judith Lebzelter <judith@osdl.org>, Dan Kegel <dank@kegel.com>,
	cliff white <cliffw@osdl.org>,
	"Timothy D. Witham" <wookie@osdl.org>
References: <20040222035350.GB31813@MAIL.13thfloor.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20040222035350.GB31813@MAIL.13thfloor.at>; from herbert@13thfloor.at on Sun, Feb 22, 2004 at 04:53:50AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 22, 2004 at 04:53:50AM +0100, Herbert Poetzl wrote:
>    interesting is that some architectures (arm, chris, v850)
>    do not even have an appropriate default config

For some (eg ARM) one single default config makes zero sense.  I've
been debating about removing arch/arm/defconfig for this reason; we
have a whole host of machine default configurations in arch/arm/config
to serve this purpose.

>    				   linux-2.4.25
>    			   config  dep     kernel  modules
> 
>    alpha/alpha: 	   OK	   OK	   OK	   OK
>    arm/arm:		   OK	   OK	   FAILED  FAILED

ARM is not expected to build in 2.4 kernels, and probably never will.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
