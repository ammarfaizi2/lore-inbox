Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262193AbTIMU13 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Sep 2003 16:27:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262195AbTIMU13
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Sep 2003 16:27:29 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:48146 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S262193AbTIMU1W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Sep 2003 16:27:22 -0400
Date: Sat, 13 Sep 2003 21:27:19 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Thomas Molina <tmolina@cablespeed.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: presario laptop pcmcia loading problems
Message-ID: <20030913212719.A23169@flint.arm.linux.org.uk>
Mail-Followup-To: Thomas Molina <tmolina@cablespeed.com>,
	linux-kernel@vger.kernel.org
References: <Pine.LNX.4.44.0309121603280.1579-800000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.44.0309121603280.1579-800000@localhost.localdomain>; from tmolina@cablespeed.com on Fri, Sep 12, 2003 at 04:20:23PM -0400
X-Message-Flag: Your copy of Microsoft Outlook is vulnerable to viruses. See www.mutt.org for more details.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 12, 2003 at 04:20:23PM -0400, Thomas Molina wrote:
> My Presario 12XL325 laptop is having a number of problems (see bugzilla 
> 973).  During late test4 or early test5 it started refusing to properly 
> initialize my wireless ethernet card, an SMC2632W.  I am getting the 
> following output when the card is inserted:

> # CONFIG_ISA is not set

Turn this on.

-- 
Russell King (rmk@arm.linux.org.uk)	http://www.arm.linux.org.uk/personal/
Linux kernel maintainer of:
  2.6 ARM Linux   - http://www.arm.linux.org.uk/
  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
  2.6 Serial core
