Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261585AbTKGWMl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Nov 2003 17:12:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261298AbTKGWMa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Nov 2003 17:12:30 -0500
Received: from mtvcafw.SGI.COM ([192.48.171.6]:55148 "EHLO rj.sgi.com")
	by vger.kernel.org with ESMTP id S264534AbTKGSON (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Nov 2003 13:14:13 -0500
Date: Fri, 7 Nov 2003 10:13:15 -0800
To: Matthew Wilcox <willy@debian.org>
Cc: Sylvain Jeaugey <sylvain.jeaugey@bull.net>, linux-kernel@vger.kernel.org,
       linux-ia64@vger.kernel.org, acpi-devel@lists.sourceforge.net
Subject: Re: [ACPI] Re: [DMESG] cpumask_t in action
Message-ID: <20031107181315.GA1162@sgi.com>
Mail-Followup-To: Matthew Wilcox <willy@debian.org>,
	Sylvain Jeaugey <sylvain.jeaugey@bull.net>,
	linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org,
	acpi-devel@lists.sourceforge.net
References: <20031106165159.GE26869@parcelfarce.linux.theplanet.co.uk> <Pine.LNX.4.44.0311070907020.29453-100000@localhost.localdomain> <20031107172456.GC23754@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031107172456.GC23754@parcelfarce.linux.theplanet.co.uk>
User-Agent: Mutt/1.5.4i
From: jbarnes@sgi.com (Jesse Barnes)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 07, 2003 at 05:24:56PM +0000, Matthew Wilcox wrote:
> On Fri, Nov 07, 2003 at 09:13:11AM +0100, Sylvain Jeaugey wrote:
> > On Thu, 6 Nov 2003, Matthew Wilcox wrote:
> > These lines show you the numa topology of your machine (in our case, we 
> > have 2 CPUS per domain, and a memory area).
> > This is quite a big piece of information about hardware. Even if it is 
> > quite long, I think it should be part of the ACPI information.
> 
> Yes, but do we need to know it at boot time, or should it be available
> in some other way (eg /proc/acpi/srat or something).  I would argue
> that is more useful than seeing it in dmesg.

There's also /sys which contains information about which cpus are on
which nodes.

Jesse
