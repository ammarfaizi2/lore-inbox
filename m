Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261375AbVE2SBZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261375AbVE2SBZ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 May 2005 14:01:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261373AbVE2SBZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 May 2005 14:01:25 -0400
Received: from mail.dvmed.net ([216.237.124.58]:43751 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S261369AbVE2SBV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 May 2005 14:01:21 -0400
Message-ID: <429A036D.8090104@pobox.com>
Date: Sun, 29 May 2005 14:01:17 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050328 Fedora/1.7.6-1.2.5
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Erik Slagter <erik@slagter.name>
CC: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org,
       Jens Axboe <axboe@suse.de>
Subject: Re: Playing with SATA NCQ
References: <20050526140058.GR1419@suse.de>	 <1117382598.4851.3.camel@localhost.localdomain>	 <4299EF16.2050208@pobox.com>	 <1117385429.4851.8.camel@localhost.localdomain>	 <4299F4E2.4020305@pobox.com>	 <1117387432.4851.13.camel@localhost.localdomain>	 <20050529172949.GA3578@havoc.gtf.org> <1117388703.4851.21.camel@localhost.localdomain>
In-Reply-To: <1117388703.4851.21.camel@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Erik Slagter wrote:
> I guess the only way to have, for example the ICH6, not using legacy
> IRQ/ports, is to switch it to AHCI, which only the BIOS can do (if
> implemented).

"native mode" is where PATA and/or SATA PCI device is programmed into 
full PCI mode -- PCI BARs, PCI irq, etc.  Some BIOSen allow you to 
enable mode, which disables all use of legacy IRQ/ports.

Also, ICH6 silicon does not support AHCI, only ICH6-R and ICH6-M.

	Jeff


