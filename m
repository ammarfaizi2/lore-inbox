Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268751AbTHBPUE (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Aug 2003 11:20:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269400AbTHBPUE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Aug 2003 11:20:04 -0400
Received: from genius.impure.org.uk ([195.82.120.210]:42661 "EHLO
	genius.impure.org.uk") by vger.kernel.org with ESMTP
	id S268751AbTHBPUB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Aug 2003 11:20:01 -0400
Date: Sat, 2 Aug 2003 16:19:05 +0100
From: Dave Jones <davej@codemonkey.org.uk>
To: Andrew Morton <akpm@osdl.org>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.0-test2-mm2
Message-ID: <20030802151905.GA5344@suse.de>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	Andrew Morton <akpm@osdl.org>,
	Linux Kernel <linux-kernel@vger.kernel.org>
References: <20030730223810.613755b4.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030730223810.613755b4.akpm@osdl.org>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 30, 2003 at 10:38:10PM -0700, Andrew Morton wrote:

 > +intel-agp-oops-fix.patch
 >  another oops fix

patch is correct, but I'm wondering what managed to iterate that
far, do you have any hw info on the box that oopsed ?

 > +export-agp_memory_reserved.patch
 >  add an EXPORT_SYMBOL

already in agpgart tree I've asked Linus to pull from.

 > +pci_device_id-devinitdata.patch
 >  Move lots of PCI device_id tables out of __initdata

How embarressing. Russell King noticed a similar problem
in agpgart a while back, and I overlooked the adjacent struct.
Likewise, I goofed in cpufreq. Oops.  Thanks for fixing them up.

		Dave

