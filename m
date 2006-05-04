Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030332AbWEDVhu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030332AbWEDVhu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 May 2006 17:37:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030333AbWEDVhu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 May 2006 17:37:50 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:10442 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S1030332AbWEDVht (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 May 2006 17:37:49 -0400
Date: Thu, 4 May 2006 23:37:48 +0200
From: Martin Mares <mj@ucw.cz>
To: Peter Jones <pjones@redhat.com>
Cc: Jon Smirl <jonsmirl@gmail.com>,
       Matthew Garrett <mgarrett@chiark.greenend.org.uk>,
       Bjorn Helgaas <bjorn.helgaas@hp.com>,
       linux-pci@atrey.karlin.mff.cuni.cz, Dave Airlie <airlied@linux.ie>,
       Andrew Morton <akpm@osdl.org>, greg@kroah.com,
       linux-kernel@vger.kernel.org, Arjan van de Ven <arjan@linux.intel.com>
Subject: Re: Add a "enable" sysfs attribute to the pci devices to allow userspace (Xorg) to enable devices without doing foul direct access
Message-ID: <mj+md-20060504.213631.30953.atrey@ucw.cz>
References: <1146300385.3125.3.camel@laptopd505.fenrus.org> <200605041309.53910.bjorn.helgaas@hp.com> <445A51F1.9040500@linux.intel.com> <200605041326.36518.bjorn.helgaas@hp.com> <E1FbjiL-0001B9-00@chiark.greenend.org.uk> <9e4733910605041340r65d47209h2da079d9cf8fceae@mail.gmail.com> <1146776736.27727.11.camel@localhost.localdomain> <mj+md-20060504.211425.25445.atrey@ucw.cz> <1146778197.27727.26.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1146778197.27727.26.camel@localhost.localdomain>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

> By allowing tools to read the rom from the pci device itself, instead of
> whichever device's rom happens to be at 0xC0000.

The ROMs are already accessible through sysfs, aren't they?

				Have a nice fortnight
-- 
Martin `MJ' Mares   <mj@ucw.cz>   http://atrey.karlin.mff.cuni.cz/~mj/
Faculty of Math and Physics, Charles University, Prague, Czech Rep., Earth
Anyone who says sunshine brings happiness has never danced in the rain.
