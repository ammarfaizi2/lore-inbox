Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263751AbTKKTzh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Nov 2003 14:55:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263747AbTKKTzg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Nov 2003 14:55:36 -0500
Received: from fmr04.intel.com ([143.183.121.6]:45725 "EHLO
	caduceus.sc.intel.com") by vger.kernel.org with ESMTP
	id S263751AbTKKTzb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Nov 2003 14:55:31 -0500
Subject: Re: 2.6 /proc/interrupts fails on systems with many CPUs
From: Len Brown <len.brown@intel.com>
To: linux-kernel@vger.kernel.org
In-Reply-To: <BF1FE1855350A0479097B3A0D2A80EE0013B1188@hdsmsx402.hd.intel.com>
References: <BF1FE1855350A0479097B3A0D2A80EE0013B1188@hdsmsx402.hd.intel.com>
Content-Type: text/plain
Organization: 
Message-Id: <1068580528.26160.12.camel@dhcppc4>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 
Date: 11 Nov 2003 14:55:28 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Speaking of /proc/interrupts...

Does anybody else find hw_interrupt_type.typename lacking?

"XT-PIC" doesn't tell us if it is level or edge triggered, high or low
polarity.

"IO-APIC-edge" and "IO-APIC-level" don't tell us if it is high or low
polarity.

Having this info easily available in /proc/interrupts would make
recognizing and diagnosing interrupt configuration issues much easier.

thanks,
-Len


