Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268372AbUHYDIW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268372AbUHYDIW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Aug 2004 23:08:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268406AbUHYDIW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Aug 2004 23:08:22 -0400
Received: from dsl081-100-231.den1.dsl.speakeasy.net ([64.81.100.231]:15744
	"EHLO hal9000.jaa.iki.fi") by vger.kernel.org with ESMTP
	id S268372AbUHYDIT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Aug 2004 23:08:19 -0400
Date: Tue, 24 Aug 2004 21:08:17 -0600
From: Jani Averbach <jaa@jaa.iki.fi>
To: Matt Mackall <mpm@selenic.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.x: Kernel Oops with netconsole + serial console
Message-ID: <20040825030817.GA4571@jaa.iki.fi>
References: <20040819171918.GC5050@jaa.iki.fi> <20040824191853.GF5414@waste.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040824191853.GF5414@waste.org>
X-PGP-Key: http://www.cc.jyu.fi/~jaa/averbach_jani_pub_asc.txt
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2004-08-24 14:18-0500, Matt Mackall wrote:
> On Thu, Aug 19, 2004 at 11:19:18AM -0600, Jani Averbach wrote:
> > [please Cc: me]
> > 
> > I have tried to setup both netconsole and serial console for
> > unattended server (I need a serial console for booting and a netconsole for
> > logging).
> > 
> > However, 2.6.6 and 2.6.8.1 both will oops if both consoles are
> > configured and in use. Disabling one of them will help, and system
> > boots up normally.
> 
> Does it work with netconsole and no serial then? Hmm.

Yes, kernel with compiled in netconsole and serial console will work
iff the netconsole or the serial console alone is configured at
boot time by boot-parameters. If you try to use both of them,
kernel will oops.

> > This is dual amd64, with two BCM5704 NIC.
> 
> Can you send your boot dmesg?

I will send to you my system information (it is 18K tar.bz2)
out-of-list, if someone else likes to take look of it, please ask, and
I will send it also to you.

Thanks for looking this,
Jani

-- 
Jani Averbach
