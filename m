Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268532AbUH3QJK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268532AbUH3QJK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Aug 2004 12:09:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268533AbUH3QJK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Aug 2004 12:09:10 -0400
Received: from fw.osdl.org ([65.172.181.6]:2458 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S268532AbUH3QI5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Aug 2004 12:08:57 -0400
Date: Mon, 30 Aug 2004 09:08:54 -0700
From: Chris Wright <chrisw@osdl.org>
To: Michael Halcrow <mahalcro@us.ibm.com>
Cc: chrisw@osdl.org, linux-kernel@vger.kernel.org, mike@halcrow.us
Subject: Re: [PATCH] BSD Secure Levels LSM (1/3)
Message-ID: <20040830090853.A1924@build.pdx.osdl.net>
References: <20040830143547.GA9980@halcrow.us>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20040830143547.GA9980@halcrow.us>; from mike@halcrow.us on Mon, Aug 30, 2004 at 09:35:47AM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Michael Halcrow (mike@halcrow.us) wrote:

> +config SECURITY_STACKER
> +	tristate "Stacker"
> +	depends on SECURITY
> +	help
> +	  Implements LSM stacker.
> +
>  source security/selinux/Kconfig
>  
>  endmenu
> --- linux-2.6.8-rc3/security/Makefile	2004-06-16 00:19:43.000000000 -0500
> +++ linux-2.6.8-rc3_seclvl/security/Makefile	2004-08-30 08:35:02.000000000 -0500
> @@ -15,3 +15,5 @@
>  obj-$(CONFIG_SECURITY_SELINUX)		+= selinux/built-in.o
>  obj-$(CONFIG_SECURITY_CAPABILITIES)	+= commoncap.o capability.o
>  obj-$(CONFIG_SECURITY_ROOTPLUG)		+= commoncap.o root_plug.o
> +obj-$(CONFIG_SECURITY_SECLVL)		+= seclvl.o
> +obj-$(CONFIG_SECURITY_STACKER)		+= stacker.o

Looks like some extra stacker bits snuck in.  Unused, correct?

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
