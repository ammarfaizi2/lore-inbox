Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261966AbTJDJcU (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Oct 2003 05:32:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261967AbTJDJcU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Oct 2003 05:32:20 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:1041 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S261966AbTJDJcS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Oct 2003 05:32:18 -0400
Date: Sat, 4 Oct 2003 10:32:10 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: "Robert P. J. Day" <rpjday@mindspring.com>
Cc: Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: error configuring for ARCH=arm
Message-ID: <20031004103209.B18928@flint.arm.linux.org.uk>
Mail-Followup-To: "Robert P. J. Day" <rpjday@mindspring.com>,
	Linux kernel mailing list <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.44.0310040522400.687-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.44.0310040522400.687-100000@localhost.localdomain>; from rpjday@mindspring.com on Sat, Oct 04, 2003 at 05:24:56AM -0400
X-Message-Flag: Your copy of Microsoft Outlook is vulnerable to viruses. See www.mutt.org for more details.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 04, 2003 at 05:24:56AM -0400, Robert P. J. Day wrote:
>   as a first attempt in building a cross-compile toolchain
> for my ARM-based sharp zaurus, i started with a clean 2.6.0-bk5
> source tree and ran:
> 
> $ make ARCH=arm xconfig
> make[1]: `scripts/fixdep' is up to date.
> scripts/kconfig/qconf arch/arm/Kconfig
> file net/bluetooth/Kconfig already scanned?
> make[1]: *** [xconfig] Error 1
> make: *** [xconfig] Error 2

To get this working, delete the line in arch/arm/Kconfig.  However,
please note that the Zaurus people /appear/ to have no interest in
merging their changes upstream, so you won't be able to use
anything other than the stuff provided by the Zaurus specific site(s).

-- 
Russell King (rmk@arm.linux.org.uk)	http://www.arm.linux.org.uk/personal/
      Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
      maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                      2.6 Serial core
