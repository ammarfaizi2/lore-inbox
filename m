Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264464AbTIIVXb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Sep 2003 17:23:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264488AbTIIVXa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Sep 2003 17:23:30 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:65297 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S264464AbTIIVUY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Sep 2003 17:20:24 -0400
Date: Tue, 9 Sep 2003 22:20:19 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Patrick Mochel <mochel@osdl.org>,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Power: call save_state on PCI devices along with suspend
Message-ID: <20030909222019.T4216@flint.arm.linux.org.uk>
Mail-Followup-To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Patrick Mochel <mochel@osdl.org>,
	linux-kernel mailing list <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.44.0309091354471.695-100000@cherise> <1063141771.639.53.camel@gaston>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1063141771.639.53.camel@gaston>; from benh@kernel.crashing.org on Tue, Sep 09, 2003 at 11:09:32PM +0200
X-Message-Flag: Your copy of Microsoft Outlook is vulnerable to viruses. See www.mutt.org for more details.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 09, 2003 at 11:09:32PM +0200, Benjamin Herrenschmidt wrote:
> On Tue, 2003-09-09 at 23:04, Patrick Mochel wrote:
> > ->save_state()? From a quick look, it looks like: 
> > 4. drivers/serial/8250_pci.c

This doesn't use save_state anymore.

-- 
Russell King (rmk@arm.linux.org.uk)	http://www.arm.linux.org.uk/personal/
Linux kernel maintainer of:
  2.6 ARM Linux   - http://www.arm.linux.org.uk/
  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
  2.6 Serial core
