Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267377AbUI0Uyl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267377AbUI0Uyl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Sep 2004 16:54:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267376AbUI0Uyb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Sep 2004 16:54:31 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:6920 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S267377AbUI0UxL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Sep 2004 16:53:11 -0400
Date: Mon, 27 Sep 2004 21:53:04 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Dax Kelson <dax@gurulabs.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>, linux-net@vger.kernel.org,
       netdev@oss.sgi.com, dahinds@users.sourceforge.net
Subject: Re: thinkpad issue --No PCMCIA hotplug activity when onboard nic (e1000) down
Message-ID: <20040927215304.E26680@flint.arm.linux.org.uk>
Mail-Followup-To: Dax Kelson <dax@gurulabs.com>,
	Linux Kernel <linux-kernel@vger.kernel.org>,
	linux-net@vger.kernel.org, netdev@oss.sgi.com,
	dahinds@users.sourceforge.net
References: <1096317629.4075.65.camel@mentorng.gurulabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1096317629.4075.65.camel@mentorng.gurulabs.com>; from dax@gurulabs.com on Mon, Sep 27, 2004 at 02:40:29PM -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 27, 2004 at 02:40:29PM -0600, Dax Kelson wrote:
> Myself and a co-worker have two ThinkPads bought a few months apart. The
> two model numbers are:
> 
> 2373-KUU -- T42p 14" LCD
> 2373-CXU -- T42 15" LCD
> 
> Both have the following onboard NIC and cardbus controller
> 02:01.0 Ethernet controller: Intel Corp. 82540EP Gigabit Ethernet Controller (Mobile) (rev 03)
> 02:00.0 CardBus bridge: Texas Instruments PCI4520 PC card Cardbus Controller (rev 01)
> 02:00.1 CardBus bridge: Texas Instruments PCI4520 PC card Cardbus Controller (rev 01)

Can you also provide the output of lspci -n for the above two
cardbus bridges please?

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
