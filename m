Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262220AbUCLPtD (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Mar 2004 10:49:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262225AbUCLPtC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Mar 2004 10:49:02 -0500
Received: from fmr05.intel.com ([134.134.136.6]:7406 "EHLO hermes.jf.intel.com")
	by vger.kernel.org with ESMTP id S262220AbUCLPsu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Mar 2004 10:48:50 -0500
Subject: Re: 2.6.4-mm1
From: Len Brown <len.brown@intel.com>
To: Neil Brown <neilb@cse.unsw.edu.au>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
In-Reply-To: <A6974D8E5F98D511BB910002A50A6647615F4D9F@hdsmsx402.hd.intel.com>
References: <A6974D8E5F98D511BB910002A50A6647615F4D9F@hdsmsx402.hd.intel.com>
Content-Type: text/plain
Organization: 
Message-Id: <1079106515.2168.18.camel@dhcppc4>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 
Date: 12 Mar 2004 10:48:35 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-03-11 at 20:03, Neil Brown wrote:

> I've seen this before when trying to boot a P4 kernel on a P-classic
> etc, so I tried compiling with CONFIG_M386, and got lots of compile
> errors:
> 
> include/asm/acpi.h: In function `__acpi_acquire_global_lock':
> include/asm/acpi.h:74: warning: implicit declaration of function
> `cmpxchg'
> 
fixed in latest ACPI patch.

> So I tried the default (CONFIG_M686) and it still doesn't work.
> 
> So: where do I look next?

did you try "acpi=off"
if the system crashed during acpi table parsing, that would happen
before console output; and acpi=off would skip table parsing.

thanks,
-Len


