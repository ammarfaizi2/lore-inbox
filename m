Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263962AbUJAQNj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263962AbUJAQNj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Oct 2004 12:13:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264500AbUJAQNj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Oct 2004 12:13:39 -0400
Received: from fw.osdl.org ([65.172.181.6]:25760 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263962AbUJAQMX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Oct 2004 12:12:23 -0400
Date: Fri, 1 Oct 2004 09:12:19 -0700
From: Chris Wright <chrisw@osdl.org>
To: Arvind Kalyan <arvy@cse.kongu.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: OS Virtualization
Message-ID: <20041001091219.C1973@build.pdx.osdl.net>
References: <49219.172.16.42.200.1096629426.kourier@172.16.42.200>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <49219.172.16.42.200.1096629426.kourier@172.16.42.200>; from arvy@cse.kongu.edu on Fri, Oct 01, 2004 at 04:47:06PM +0530
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Arvind Kalyan (arvy@cse.kongu.edu) wrote:
> Hi all,
> 
> I'm trying to load and run two linux kernels simultaneously; trying to
> demonstrate virtualization as a first step.

A first step towards what?

> Anyone have pointers to where I can start? I looked into plex, bochs,
> vmware, usermode linux.. they only simulate an architecture upon which
> another kernel runs.

These are hosted (well, vmware has non-hosted products too).  But as a
first step, this could be sufficient.

> My intentions are to give control to both the kernels to directly control
> the hardware and do "context switch" between those two based on
> time-slice.

Even with a non-hosted virtual machine, you'll need a hypervisor.  Take
a look at Xen (if you're using x86).  Or get some time on an S/390 ;-))

http://www.cl.cam.ac.uk/Research/SRG/netos/xen/

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
