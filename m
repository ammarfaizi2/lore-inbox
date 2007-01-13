Return-Path: <linux-kernel-owner+w=401wt.eu-S1161264AbXAMDpR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161264AbXAMDpR (ORCPT <rfc822;w@1wt.eu>);
	Fri, 12 Jan 2007 22:45:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161261AbXAMDpR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Jan 2007 22:45:17 -0500
Received: from eazy.amigager.de ([213.239.192.238]:48087 "EHLO
	eazy.amigager.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161253AbXAMDpP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Jan 2007 22:45:15 -0500
Date: Sat, 13 Jan 2007 04:45:12 +0100
From: Tino Keitel <tino.keitel@tikei.de>
To: Pavel Machek <pavel@ucw.cz>, Luming Yu <luming.yu@gmail.com>,
       Adrian Bunk <bunk@stusta.de>, Lee Revell <rlrevell@joe-job.com>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.20-rc3 regression: suspend to RAM broken on Mac mini Core Duo
Message-ID: <20070113034512.GA6422@dose.home.local>
Mail-Followup-To: Pavel Machek <pavel@ucw.cz>,
	Luming Yu <luming.yu@gmail.com>, Adrian Bunk <bunk@stusta.de>,
	Lee Revell <rlrevell@joe-job.com>, linux-kernel@vger.kernel.org
References: <20070107151744.GA9799@dose.home.local> <1168194194.18788.63.camel@mindpipe> <20070107200453.GA3227@thinkpad.home.local> <20070107222706.GA6092@thinkpad.home.local> <20070107234445.GM20714@stusta.de> <20070108210428.GA7199@dose.home.local> <3877989d0701090651m84d7f41v5d06e1638a7eb31d@mail.gmail.com> <20070109231655.GA5958@thinkpad.home.local> <20070112145025.GB7685@ucw.cz> <20070113030528.GA8269@dose.home.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070113030528.GA8269@dose.home.local>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 13, 2007 at 04:05:28 +0100, Tino Keitel wrote:

[...]

> I think I found the problem. In 2.6.18, I had a slightly different
> config. With 2.6.20-rc4, I had sucessful suspend/resume cycles without
> the USB DVB-T box attached. I tweaked the USB options a bit and
> activated some options (CONFIG_USB_SUSPEND,
> CONFIG_USB_MULTITHREAD_PROBE, CONFIG_USB_EHCI_SPLIT_ISO,
> CONFIG_USB_EHCI_ROOT_HUB_TT, CONFIG_USB_EHCI_TT_NEWSCHED) and now I can
> suspend/resume without hangs. At least I haven't seen one until now.

Just after I sent the mail, I had 2 failures again. :-(

Regards,
Tino
