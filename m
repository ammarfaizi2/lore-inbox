Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267374AbUI0VHw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267374AbUI0VHw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Sep 2004 17:07:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267385AbUI0VGh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Sep 2004 17:06:37 -0400
Received: from mail.gurulabs.com ([67.137.148.7]:58497 "EHLO mail.gurulabs.com")
	by vger.kernel.org with ESMTP id S267388AbUI0VGA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Sep 2004 17:06:00 -0400
Subject: Re: thinkpad issue --No PCMCIA hotplug activity when onboard nic
	(e1000) down
From: Dax Kelson <dax@gurulabs.com>
To: Russell King <rmk+lkml@arm.linux.org.uk>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>, linux-net@vger.kernel.org,
       netdev@oss.sgi.com, dahinds@users.sourceforge.net
In-Reply-To: <20040927215304.E26680@flint.arm.linux.org.uk>
References: <1096317629.4075.65.camel@mentorng.gurulabs.com>
	 <20040927215304.E26680@flint.arm.linux.org.uk>
Content-Type: text/plain
Message-Id: <1096319165.4075.78.camel@mentorng.gurulabs.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Mon, 27 Sep 2004 15:06:05 -0600
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-09-27 at 14:53, Russell King wrote:
> On Mon, Sep 27, 2004 at 02:40:29PM -0600, Dax Kelson wrote:
> > Myself and a co-worker have two ThinkPads bought a few months apart. The
> > two model numbers are:
> > 
> > 2373-KUU -- T42p 14" LCD
> > 2373-CXU -- T42 15" LCD
> > 
> > Both have the following onboard NIC and cardbus controller
> > 02:01.0 Ethernet controller: Intel Corp. 82540EP Gigabit Ethernet Controller (Mobile) (rev 03)
> > 02:00.0 CardBus bridge: Texas Instruments PCI4520 PC card Cardbus Controller (rev 01)
> > 02:00.1 CardBus bridge: Texas Instruments PCI4520 PC card Cardbus Controller (rev 01)
> 
> Can you also provide the output of lspci -n for the above two
> cardbus bridges please?

Sure..

# lspci -n | grep 02:00
02:00.0 Class 0607: 104c:ac46 (rev 01)
02:00.1 Class 0607: 104c:ac46 (rev 01)


