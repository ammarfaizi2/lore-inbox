Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265972AbUA1PAi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jan 2004 10:00:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265974AbUA1PAi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jan 2004 10:00:38 -0500
Received: from albireo.ucw.cz ([81.27.194.19]:20355 "EHLO albireo.ucw.cz")
	by vger.kernel.org with ESMTP id S265972AbUA1PAg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jan 2004 10:00:36 -0500
Date: Wed, 28 Jan 2004 16:00:35 +0100
From: Martin Mares <mj@ucw.cz>
To: Vladimir Kondratiev <vladimir.kondratiev@intel.com>
Cc: "Durairaj, Sundarapandian" <sundarapandian.durairaj@intel.com>,
       linux-kernel@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz,
       torvalds@osdl.org, alan@lxorguk.ukuu.org.uk, greg@kroah.com,
       Andi Kleen <ak@colin2.muc.de>, akpm@osdl.org,
       "Seshadri, Harinarayanan" <harinarayanan.seshadri@intel.com>,
       "Nakajima, Jun" <jun.nakajima@intel.com>
Subject: Re: [patch] PCI Express Enhanced Config Patch - 2.6.0-test11
Message-ID: <20040128150035.GK4600@ucw.cz>
References: <6B09584CC3D2124DB45C3B592414FA83011A336E@bgsmsx402.gar.corp.intel.com> <4017CA6C.1070301@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4017CA6C.1070301@intel.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

> - if you will present 4k config space for all devices, it will save lots 
> of work: you do not need to modify struct pci_dev, do not need almost 
> all stuff in drivers/pci/proc.c. By presenting 4k config for PCI device 
> you should not broke anything.

For example the sizes of files in /sys/bus/pci should reflect the real size of
configuration space.

				Have a nice fortnight
-- 
Martin `MJ' Mares   <mj@ucw.cz>   http://atrey.karlin.mff.cuni.cz/~mj/
Faculty of Math and Physics, Charles University, Prague, Czech Rep., Earth
"Anyone can build a fast CPU. The trick is to build a fast system." -- S. Cray
