Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275110AbTHLI7X (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Aug 2003 04:59:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275124AbTHLI7X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Aug 2003 04:59:23 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:19473 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S275110AbTHLI7W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Aug 2003 04:59:22 -0400
Date: Tue, 12 Aug 2003 09:59:18 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: David Hinds <dhinds@sonic.net>
Cc: Jochen Friedrich <jochen@scram.de>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       dahinds@users.sourceforge.net
Subject: Re: PCI1410 Interrupt Problems
Message-ID: <20030812095918.A10895@flint.arm.linux.org.uk>
Mail-Followup-To: David Hinds <dhinds@sonic.net>,
	Jochen Friedrich <jochen@scram.de>,
	Linux Kernel <linux-kernel@vger.kernel.org>,
	dahinds@users.sourceforge.net
References: <20030807000914.J16116@flint.arm.linux.org.uk> <Pine.LNX.4.44.0308112028300.10344-100000@gfrw1044.bocc.de> <20030811120048.A13992@sonic.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030811120048.A13992@sonic.net>; from dhinds@sonic.net on Mon, Aug 11, 2003 at 12:00:48PM -0700
X-Message-Flag: Your copy of Microsoft Outlook is vulnerable to viruses. See www.mutt.org for more details.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 11, 2003 at 12:00:48PM -0700, David Hinds wrote:
> I do think there is room for having some sane default settings to be
> used when an unconfigured bridge is detected.  For most of the TI
> bridges, there is only one reasonable default for how to enable PCI
> interrupt delivery.  The important part here is "unconfigured bridge":
> never fool with interrupt delivery on a bridge that has been set up
> by the BIOS, which covers essentially all laptops.

Note that I will be looking into this shortly - I've been putting off
a lot of kernel work over the last week due to the rediculously high
temperatures we've been experiencing in the UK, not wanting to add
any extra heat from either people or machines to an already baking
house.

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

