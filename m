Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751328AbWA0Oie@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751328AbWA0Oie (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Jan 2006 09:38:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751455AbWA0Oie
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Jan 2006 09:38:34 -0500
Received: from dtp.xs4all.nl ([80.126.206.180]:28363 "HELO abra2.bitwizard.nl")
	by vger.kernel.org with SMTP id S1751328AbWA0Oid (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Jan 2006 09:38:33 -0500
Date: Fri, 27 Jan 2006 15:38:32 +0100
From: Erik Mouw <erik@harddisk-recovery.com>
To: "Lorne J. Leitman" <leitman@cs.pitt.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: patching arm-linux 2.4.18 on sharp zaurus sl-5500
Message-ID: <20060127143832.GG3673@harddisk-recovery.com>
References: <a76b68304d1cadc77190142ba67324a6@cs.pitt.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a76b68304d1cadc77190142ba67324a6@cs.pitt.edu>
Organization: Harddisk-recovery.com
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 27, 2006 at 09:28:07AM -0500, Lorne J. Leitman wrote:
> We are a group of researchers at University of Pittbsurgh trying to
> implement an ad-hoc routing protocol on the Sharp Zaurus 5500 pda.  Our
> network is running the following environment:
>       -arm-linux kernel 2.4.18-pxa3-embedix-021129

ncftp /pub/linux/kernel/v2.4 > dir patch-2.4.18.bz2
-rw-rw-r--    1 536      536       826105   Feb 25  2002    patch-2.4.18.bz2

Any particular reason why you're using a 4 year old kernel?

>       -OpenZaurus 3.5.1
> 
> The protocol has been implemented on laptops already, running normal 
> Linux
> OS.  Now we want to port it to embedix for the PDA's but we are having
> some trouble.
> 
> In order to begin our implementation on the PDA's, we need to make use 
> of
> Linux real-time timers.  These are part of the POSIX.1b standard, and 
> are
> supposedly present already in the 2.4 kernel.  However, they do not seem
> to be present in 2.4.18 embedix kernel.  Does anyone know of a patch or
> module that we can apply to this kernel so we can take advantage of 
> these
> timers?

The normal reply would be "upgrade to the latest 2.4 kernel". However,
the ARM linux community abandoned support for 2.4 almost immediately
after 2.6 was released, so the correct reply is "upgrade to the latest
2.6 kernel".

> We also need to leverage the Netfilter portion of the kernel.  Again,
> netfilter should be part of the 2.4 kernel.  There does appear to be an
> "kernel-module-ip-tables"  installed, but there is no iptables binary in
> the userspace.  Does anyone know how we can get hold of iptables for
> arm-linux?

Compile it yourself, or get a precompiled package from the debian
project.


Erik

-- 
+-- Erik Mouw -- www.harddisk-recovery.com -- +31 70 370 12 90 --
| Lab address: Delftechpark 26, 2628 XH, Delft, The Netherlands
