Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262337AbTINIRP (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Sep 2003 04:17:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262340AbTINIRP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Sep 2003 04:17:15 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:65036 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S262337AbTINIRK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Sep 2003 04:17:10 -0400
Date: Sun, 14 Sep 2003 09:17:02 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Norman Diamond <ndiamond@wta.att.ne.jp>, Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test5 vs. Ethernet cards
Message-ID: <20030914091702.B20889@flint.arm.linux.org.uk>
Mail-Followup-To: Norman Diamond <ndiamond@wta.att.ne.jp>,
	Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org
References: <1b7201c37a73$844b7030$2dee4ca5@DIAMONDLX60>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1b7201c37a73$844b7030$2dee4ca5@DIAMONDLX60>; from ndiamond@wta.att.ne.jp on Sun, Sep 14, 2003 at 12:51:29PM +0900
X-Message-Flag: Your copy of Microsoft Outlook is vulnerable to viruses. See www.mutt.org for more details.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 14, 2003 at 12:51:29PM +0900, Norman Diamond wrote:
> Shutdown messages appear on the text console as follows:
> [...]
> Shutting down PCMCIA unregister_netdevice: waiting for eth0 to become free.
> Usage count = 1
> unregister_netdevice: waiting for eth0 to become free. Usage count = 1
> unregister_netdevice: waiting for eth0 to become free. Usage count = 1
> unregister_netdevice: waiting for eth0 to become free. Usage count = 1
> unregister_netdevice: waiting for eth0 to become free. Usage count = 1
> unregister_netdevice: waiting for eth0 to become free. Usage count = 1
> unregister_netdevice: waiting for eth0 to become free. Usage count = 1
> unregister_netdevice: waiting for eth0 to become free. Usage count = 1
> unregister_netdevice: waiting for eth0 to become free. Usage count = 1
> [...]
> 
> The only way to shut down at this point is to turn off the power.

IIRC the problem is your hotplug scripts.  Maybe the hotplug folk can tell
you the minimum version for 2.6.

-- 
Russell King (rmk@arm.linux.org.uk)	http://www.arm.linux.org.uk/personal/
Linux kernel maintainer of:
  2.6 ARM Linux   - http://www.arm.linux.org.uk/
  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
  2.6 Serial core
