Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262835AbVBDWza@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262835AbVBDWza (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Feb 2005 17:55:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264548AbVBDWyS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Feb 2005 17:54:18 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:148 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S264502AbVBDWNV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Feb 2005 17:13:21 -0500
Date: Fri, 4 Feb 2005 22:13:10 +0000 (GMT)
From: James Simmons <jsimmons@www.infradead.org>
X-X-Sender: jsimmons@pentafluge.infradead.org
To: Jon Smirl <jonsmirl@gmail.com>
cc: Jesse Barnes <jbarnes@engr.sgi.com>, Pavel Machek <pavel@ucw.cz>,
       Carl-Daniel Hailfinger <c-d.hailfinger.devel.2005@gmx.net>,
       ncunningham@linuxmail.org, ACPI List <acpi-devel@lists.sourceforge.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [RFC] Reliable video POSTing on resume
In-Reply-To: <9e473391050204122942da8aa7@mail.gmail.com>
Message-ID: <Pine.LNX.4.56.0502042211440.26459@pentafluge.infradead.org>
References: <20050122134205.GA9354@wsc-gmbh.de>  <20050204163019.GC1290@elf.ucw.cz>
  <9e4733910502040931955f5a6@mail.gmail.com>  <200502041010.13220.jbarnes@engr.sgi.com>
 <9e473391050204122942da8aa7@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> I would prefer to use hotplug for the user space call out but when I
> do I run into the framebuffer and DRM drivers. This having multiple
> drivers for the same piece of hardware is a pain. So hotplug on the
> standard device is not an option.

I know. It could be merged. The secert is a gradual move to /sys/graphics/
for both interfaces :-)

