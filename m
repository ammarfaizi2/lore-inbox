Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262366AbTFFXns (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jun 2003 19:43:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262368AbTFFXns
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jun 2003 19:43:48 -0400
Received: from law14-f14.law14.hotmail.com ([64.4.21.14]:40709 "EHLO
	hotmail.com") by vger.kernel.org with ESMTP id S262366AbTFFXnp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jun 2003 19:43:45 -0400
X-Originating-IP: [212.56.89.216]
X-Originating-Email: [jclp12@hotmail.com]
From: "J C" <jclp12@hotmail.com>
To: linux-kernel@vger.kernel.org
Subject: help: use of third party kernel modules: license issue?
Date: Fri, 06 Jun 2003 23:57:19 +0000
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Message-ID: <Law14-F14xxnSYe4nhr00045290@hotmail.com>
X-OriginalArrivalTime: 06 Jun 2003 23:57:19.0596 (UTC) FILETIME=[5D6A4AC0:01C32C87]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

How does the Linux GPL license apply to third party, binary modules in
a case where our custom core kernel code uses proprietary, third
party, "binary only" module interfaces?

My company is developing a telecoms product using Embedded Linux. We
are modifying core kernel components to implement some of our
product's features. We aren't using kernel modules for our own code --
we know and accept that our source code changes must be made available
under the terms of the Linux license.

Our problem is that we'd like to use a particular network processor
that comes with a closed-source kernel module from the chip
vendor. The kernel module provides a sophisticated set of API
functions for configuring and using the chip. The vendor intends the
kernel module to be used as a "chip driver API", exporting a bunch of
API functions for use by customer code. However, we (the customer)
would like to call those API functions directly from our own core
kernel modifications. The chip vendor, however, expected its customers
to implement their drivers in their own binary only, custom kernel
modules. Are we putting the "binary only" license of the third party
module at risk if we call its functions from our core kernel
modifications?

We can argue that the chip vendor's binary only module is not a
"derived work" of our modifications -- we just use the published API
of the binary module.

I've seen several statements saying that it is specifically not
allowed to make open-source core kernel changes in order to use a
proprietary, closed-source kernel module. In this particular case, it
might look like this is what we're doing since we call functions of
the binary kernel module from our open-source core kernel
modifications. But we are not making our core kernel code changes in
order to use the proprietary kernel module; we simply want to use the
chip.

Any comments on where we stand on this?

Thanks

JC

_________________________________________________________________
Find a cheaper internet access deal - choose one to suit you. 
http://www.msn.co.uk/internetaccess

