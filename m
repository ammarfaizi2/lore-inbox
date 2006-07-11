Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750874AbWGKUhm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750874AbWGKUhm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jul 2006 16:37:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751297AbWGKUhm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jul 2006 16:37:42 -0400
Received: from static-ip-62-75-166-246.inaddr.intergenia.de ([62.75.166.246]:35806
	"EHLO bu3sch.de") by vger.kernel.org with ESMTP id S1750870AbWGKUhl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jul 2006 16:37:41 -0400
From: Michael Buesch <mb@bu3sch.de>
To: Daniel Drake <dsd@gentoo.org>
Subject: Re: [patch] do not allow IPW_2100=Y or IPW_2200=Y
Date: Tue, 11 Jul 2006 22:39:17 +0200
User-Agent: KMail/1.9.1
References: <20060710152032.GA8540@elf.ucw.cz> <200607102305.06572.mb@bu3sch.de> <44B3912F.3010300@gentoo.org>
In-Reply-To: <44B3912F.3010300@gentoo.org>
Cc: Jeff Garzik <jgarzik@pobox.com>, Pavel Machek <pavel@ucw.cz>,
       yi.zhu@intel.com, jketreno@linux.intel.com,
       Netdev list <netdev@vger.kernel.org>, linville@tuxdriver.com,
       kernel list <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200607112239.17405.mb@bu3sch.de>
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 11 July 2006 13:53, you wrote:
> Michael Buesch wrote:
> > Does the ipw driver _really_ need the firmware on insmod time?
> > bcm43xx, for example, loads the firmware on "ifconfig up" time.
> > If ipw really needs the firmware on insmod, is it possible to
> > defer it to later at "ifconfig up" time?
> 
> Is bcm43xx able to get the MAC address before the firmware is loaded?

Yes. We have a PROM that is readable without firmware.
(And we actually do this and did it forever. So I don't know
where your assumption comes from ;) )

> Last time I checked, if the MAC address is only discovered after the 
> interface is created (as would be the case with ipw loading firmware on 
> ifconfig up, I think), interface renaming does not work.

-- 
Greetings Michael.
