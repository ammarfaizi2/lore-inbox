Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271749AbTG2PCf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Jul 2003 11:02:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271755AbTG2PCf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Jul 2003 11:02:35 -0400
Received: from mail.convergence.de ([212.84.236.4]:18669 "EHLO
	mail.convergence.de") by vger.kernel.org with ESMTP id S271749AbTG2PCd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Jul 2003 11:02:33 -0400
Message-ID: <3F268C84.6060004@convergence.de>
Date: Tue, 29 Jul 2003 17:02:28 +0200
From: Michael Hunold <hunold@convergence.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de-AT; rv:1.4) Gecko/20030715
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: ranty@debian.org
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] request_firmware() private workqueue
References: <3F1BD157.4090509@convergence.de> <20030726101818.GA25104@ranty.pantax.net> <20030726155952.GA23335@ranty.pantax.net>
In-Reply-To: <20030726155952.GA23335@ranty.pantax.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Manuel,

I've applied your patches
- request_firmware_own-workqueue.diff
- sysfs-bin-unbreak.diff

and it's working very well for the av7110 DVB driver.

I hope that these patches are applied to the mainline kernel soon, so 
the other DVB drivers which need binary firmware blobs (namely 
dvb-ttusb-dec, dvb-ttusb-budget and one frontend driver) can be ported.

This will get rid of the av7110 firmware in the kernel and the ugly 
config hacks to get the other drivers working.

CU
Michael.

