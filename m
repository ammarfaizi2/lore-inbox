Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262326AbTINIK6 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Sep 2003 04:10:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262329AbTINIK6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Sep 2003 04:10:58 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:56588 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S262326AbTINIK5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Sep 2003 04:10:57 -0400
Date: Sun, 14 Sep 2003 09:10:51 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Philip Clark <pclark@SLAC.Stanford.EDU>
Cc: linux-kernel@vger.kernel.org
Subject: Re: PCMCIA in 2.6.0-test5
Message-ID: <20030914091051.A20889@flint.arm.linux.org.uk>
Mail-Followup-To: Philip Clark <pclark@SLAC.Stanford.EDU>,
	linux-kernel@vger.kernel.org
References: <x34y8ws47an.fsf@bbrcu5.slac.stanford.edu> <20030914001539.D23169@flint.arm.linux.org.uk> <x34pti4453z.fsf@bbrcu5.slac.stanford.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <x34pti4453z.fsf@bbrcu5.slac.stanford.edu>; from pclark@SLAC.Stanford.EDU on Sat, Sep 13, 2003 at 04:54:08PM -0700
X-Message-Flag: Your copy of Microsoft Outlook is vulnerable to viruses. See www.mutt.org for more details.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 13, 2003 at 04:54:08PM -0700, Philip Clark wrote:
> I am running a Dell Latitude CpiA 366XT with a Texas instruments cardbus
> controller. I have attached the full details. The lspci -vv output,
> dmesg output and my kernel configuration. 
> 
> Seems like the card services are just not working in test5. 

You're building yenta as a module - are you sure your init scripts are
loading the module?

-- 
Russell King (rmk@arm.linux.org.uk)	http://www.arm.linux.org.uk/personal/
Linux kernel maintainer of:
  2.6 ARM Linux   - http://www.arm.linux.org.uk/
  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
  2.6 Serial core
