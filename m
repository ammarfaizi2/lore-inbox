Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316582AbSGVIEJ>; Mon, 22 Jul 2002 04:04:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316585AbSGVIEI>; Mon, 22 Jul 2002 04:04:08 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:23311 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S316582AbSGVIEI>; Mon, 22 Jul 2002 04:04:08 -0400
Date: Mon, 22 Jul 2002 09:07:04 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Keith Owens <kaos@ocs.com.au>
Cc: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>,
       linux-kernel@vger.kernel.org
Subject: Re: [patch] 2.5.25 net/core/Makefile
Message-ID: <20020722090704.A2052@flint.arm.linux.org.uk>
References: <Pine.LNX.4.44.0207211853130.16927-100000@chaos.physics.uiowa.edu> <25972.1027300121@kao2.melbourne.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <25972.1027300121@kao2.melbourne.sgi.com>; from kaos@ocs.com.au on Mon, Jul 22, 2002 at 11:08:41AM +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 22, 2002 at 11:08:41AM +1000, Keith Owens wrote:
> It is required if you ever want autoconfigure to work, that
> distinguishes between "" (undefined) and "n" (explicitly turned off).
> Forward planning.

Wouldn't it be better to fix the existing config tools to output "=n"
instead of "# CONFIG_foo is not set" ?  IIRC they do the translation
back and forth internally anyway, so it should be just a matter of
removing some code from the tools.

After all, the earlier we update the config tools, the earlier we can
do something with the makefiles (after a reasonable period for things
like mconfig to catch up...)

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

