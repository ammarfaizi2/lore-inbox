Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932129AbVJ2T0O@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932129AbVJ2T0O (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Oct 2005 15:26:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932123AbVJ2T0O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Oct 2005 15:26:14 -0400
Received: from mail.dvmed.net ([216.237.124.58]:3462 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S932119AbVJ2T0M (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Oct 2005 15:26:12 -0400
Message-ID: <4363CCBD.6060207@pobox.com>
Date: Sat, 29 Oct 2005 15:25:49 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Max Kellermann <max@duempel.org>
CC: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.14-rc4-mm1 and later: second ata_piix controller is invisible
References: <20051025095646.GA24977@roonstrasse.net>
In-Reply-To: <20051025095646.GA24977@roonstrasse.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Max Kellermann wrote:
> Hi Andrew,
> 
> since 2.6.14-rc4-mm1, my second ata_piix (SATA) controller does not
> show up in dmesg, effectively hiding /dev/sdb.  2.6.14-rc2-mm2 and
> older (with the same kernel config) were ok, the same for Linus'
> kernels: 2.6.14-rc5 without -mm1 has /dev/sdb, too.
> 
> 0000:00:1f.2 IDE interface: Intel Corp. 82801EB (ICH5) Serial ATA 150
> Storage Controller (rev 02) (prog-if 8f [Master SecP SecO PriP PriO])
> 0000:00:1f.2 0101: 8086:24d1 (rev 02)
> 
> This PCI device (on-board on an Asus P4 mainboard) has two SATA
> connectors, showing up as ata1/sda and ata2/sdb.
> 
> dmesg from 2.6.14-rc5:

Thanks for this report.  Would it be possible for you to test 2.6.14 
(release) and 2.6.14-git1, as additional data points?

Once its out, I might ask you to try 2.6.14-git2 (tonight's upcoming 
snapshot) as well.

Regards,

	Jeff




