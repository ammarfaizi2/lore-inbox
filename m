Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261605AbUE0GCO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261605AbUE0GCO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 May 2004 02:02:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261606AbUE0GCN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 May 2004 02:02:13 -0400
Received: from fmr06.intel.com ([134.134.136.7]:9646 "EHLO
	caduceus.jf.intel.com") by vger.kernel.org with ESMTP
	id S261605AbUE0GCL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 May 2004 02:02:11 -0400
Subject: Re: Dell GX1 500 MHZ locked up with Kernel 2.4.26 due to ACPI --
	Also: IPTables question.
From: Len Brown <len.brown@intel.com>
To: Justin Piszcz <jpiszcz@lucidpixels.com>
Cc: linux-kernel@vger.kernel.org, ap@solarrain.com
In-Reply-To: <A6974D8E5F98D511BB910002A50A6647615FC7D4@hdsmsx403.hd.intel.com>
References: <A6974D8E5F98D511BB910002A50A6647615FC7D4@hdsmsx403.hd.intel.com>
Content-Type: text/plain
Organization: 
Message-Id: <1085637598.17692.53.camel@dhcppc4>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 
Date: 27 May 2004 01:59:59 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-05-26 at 06:54, Justin Piszcz wrote:

> I previously have had a > 190 day uptime (without ACPI in the kernel,
> an older kernel of course, but I believe it is ACPI that caused the
> problem).

Can you send the dmesg for when you have ACPI enabled?
Does /proc/interrutps show that you are getting some kind
of acpi events?

Note that ACPI has a number of drivers, eg. processor, thermal etc.
that you can unload or unconfig to see if the problem lies there.

Note also that you should be able to boot the ACPI enabled kernel with
"acpi=off" to completely disable anyting ACPI in that kernel.

cheers,
-Len


