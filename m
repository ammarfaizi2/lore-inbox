Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261759AbUJYLUn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261759AbUJYLUn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Oct 2004 07:20:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261760AbUJYLUn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Oct 2004 07:20:43 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:33197 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S261759AbUJYLUi
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Oct 2004 07:20:38 -0400
Subject: Re: [RFC/PATCH 0/4] cpus, nodes, and the device model: dynamic cpu
	registration
From: Nathan Lynch <nathanl@austin.ibm.com>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Greg KH <greg@kroah.com>, mochel@digitalimplant.org,
       Anton Blanchard <anton@samba.org>
In-Reply-To: <1098684724.8098.57.camel@localhost.localdomain>
References: <20041024094551.28808.28284.87316@biclops>
	 <1098684724.8098.57.camel@localhost.localdomain>
Content-Type: text/plain
Date: Mon, 25 Oct 2004 06:20:32 -0500
Message-Id: <1098703232.8582.10.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-10-25 at 16:12 +1000, Rusty Russell wrote:
> On Sun, 2004-10-24 at 03:42 -0600, Nathan Lynch wrote:
> > For starters, the current situation is that cpu sysdevs are registered
> > from architecture code at boot.  Already we have inconsistencies
> > betweeen the arches -- ia64 registers only online cpus, ppc64
> > registers all "possible" cpus.
> 
> Um, how does ia64 bring up a new CPU without
> a /sys/devices/system/cpu/cpuX/online?

I don't think they have that capability merged yet, but I have seen a
few patches for ACPI-based physical hotplug support go by, e.g.
http://lkml.org/lkml/2004/9/20/126


Nathan

