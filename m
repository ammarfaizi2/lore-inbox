Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423066AbWJYGvk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423066AbWJYGvk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Oct 2006 02:51:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423065AbWJYGvk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Oct 2006 02:51:40 -0400
Received: from einhorn.in-berlin.de ([192.109.42.8]:32427 "EHLO
	einhorn.in-berlin.de") by vger.kernel.org with ESMTP
	id S1423064AbWJYGvj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Oct 2006 02:51:39 -0400
X-Envelope-From: stefanr@s5r6.in-berlin.de
Message-ID: <453F095E.4060106@s5r6.in-berlin.de>
Date: Wed, 25 Oct 2006 08:51:10 +0200
From: Stefan Richter <stefanr@s5r6.in-berlin.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.6) Gecko/20060730 SeaMonkey/1.0.4
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
CC: linux1394-devel@lists.sourceforge.net,
       linuxppc-dev list <linuxppc-dev@ozlabs.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       Greg KH <greg@kroah.com>
Subject: Re: pci_set_power_state() failure and breaking suspend
References: <1161672898.10524.596.camel@localhost.localdomain> <1161675611.10524.598.camel@localhost.localdomain> <tkrat.1b479115136413cf@s5r6.in-berlin.de> <453F08A0.9040506@s5r6.in-berlin.de>
In-Reply-To: <453F08A0.9040506@s5r6.in-berlin.de>
X-Enigmail-Version: 0.94.1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

And this should go on top of ohci1394_pci_suspend:

+	printk(KERN_INFO "%s does not fully support suspend yet\n",
+	       OHCI1394_DRIVER_NAME);
+
-- 
Stefan Richter
-=====-=-==- =-=- ==--=
http://arcgraph.de/sr/
