Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262683AbTJ3R1k (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Oct 2003 12:27:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262687AbTJ3R1k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Oct 2003 12:27:40 -0500
Received: from fw.osdl.org ([65.172.181.6]:46487 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262683AbTJ3R1j (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Oct 2003 12:27:39 -0500
Date: Thu, 30 Oct 2003 09:27:29 -0800
From: Chris Wright <chrisw@osdl.org>
To: "Randy.Dunlap" <rddunlap@osdl.org>
Cc: Dave Jones <davej@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: Post-halloween doc updates.
Message-ID: <20031030092729.A22726@osdlab.pdx.osdl.net>
References: <20031030141519.GA10700@redhat.com> <20031030085222.3874483e.rddunlap@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20031030085222.3874483e.rddunlap@osdl.org>; from rddunlap@osdl.org on Thu, Oct 30, 2003 at 08:52:22AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Randy.Dunlap (rddunlap@osdl.org) wrote:
> | SELinux.
> | ~~~~~~~~
> | NSA Security-Enhanced Linux (SELinux) got merged in 2.6.
> | It is disabled by default and can be enabled with a boot time parameter
> | selinux=1.
> | You can obtain SELinux tools and an example policy configuration from
> | http://www.nsa.gov/selinux
> 
> Somebody correct me here if needed...
> selinux can't just be enabled by using 'selinux=1', if the config
> options are set for checking that.
> The way that I read security/selinux/Kconfig and hooks.c,
> if SECURITY_SELINUX_BOOTPARAM is enabled, then the 'selinux'
> boot option is also enabled.  However, it can be disabled by using
> 'selinux=0' as a kernel boot option.

This is correct.  SELinux defaults to not being config'd in.  If you
config it in it defaults to enabled.  If you also config the bootparam
you can use that param to disable it, otherwise selinux=1 is redundant
as that's the default.

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
