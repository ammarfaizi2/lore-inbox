Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751231AbWBOSqs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751231AbWBOSqs (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Feb 2006 13:46:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751234AbWBOSqs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Feb 2006 13:46:48 -0500
Received: from solarneutrino.net ([66.199.224.43]:19721 "EHLO
	tau.solarneutrino.net") by vger.kernel.org with ESMTP
	id S1751231AbWBOSqs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Feb 2006 13:46:48 -0500
Date: Wed, 15 Feb 2006 13:46:41 -0500
To: Jean Delvare <khali@linux-fr.org>
Cc: linux-kernel@vger.kernel.org, Erik Mouw <erik@harddisk-recovery.com>,
       Nick Warne <nick@linicks.net>
Subject: Re: Random reboots
Message-ID: <20060215184641.GD17864@tau.solarneutrino.net>
References: <20060215160036.GB17864@tau.solarneutrino.net> <ARSSpsNs.1140020437.1823510.khali@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ARSSpsNs.1140020437.1823510.khali@localhost>
User-Agent: Mutt/1.5.9i
From: Ryan Richter <ryan@tau.solarneutrino.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I just remembered something that might be related.  Another thing that's
unique about this machine is that it uses ethernet bonding.  When I
first set this up (on some old kernel, I don't remember which) I of
course tried to see if I could saturate both gigabit ethernet
interfaces.  I set up two UDP streams to different machines with 64-bit
PCI busses, and that didn't quite do it.  So I started up a third, and
that did it, but caused the machine to instantly reboot itself after a
few seconds.  I tried this a few more times, and it was repeatable.
Some later kernel version fixed this - probably 2.6.11.3.

I just tried again, and I can still saturate both interfaces with
outbound UDP traffic, but no reboot.

Just a thought.

-ryan
