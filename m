Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261427AbTHSUtd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Aug 2003 16:49:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261428AbTHSUtW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Aug 2003 16:49:22 -0400
Received: from web14913.mail.yahoo.com ([216.136.225.240]:58386 "HELO
	web14913.mail.yahoo.com") by vger.kernel.org with SMTP
	id S261427AbTHSUqp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Aug 2003 16:46:45 -0400
Message-ID: <20030819204643.75442.qmail@web14913.mail.yahoo.com>
Date: Tue, 19 Aug 2003 13:46:43 -0700 (PDT)
From: Jon Smirl <jonsmirl@yahoo.com>
Subject: Re: Standard driver call to enable/disable PCI ROM
To: Russell King <rmk@arm.linux.org.uk>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20030819210618.D23670@flint.arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--- Russell King <rmk@arm.linux.org.uk> wrote:
> You should use pcibios_resource_to_bus() to convert a resource to a
> representation suitable for a BAR.

I've never used pcibios_resource_to_bus(), what's the right way to do this?
This is a good reason for making this into a common PCI driver function, 
it will stop people like me from messing up PCI calls.




=====
Jon Smirl
jonsmirl@yahoo.com

__________________________________
Do you Yahoo!?
Yahoo! SiteBuilder - Free, easy-to-use web site design software
http://sitebuilder.yahoo.com
