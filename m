Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261483AbVGRS7w@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261483AbVGRS7w (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Jul 2005 14:59:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261513AbVGRS7v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Jul 2005 14:59:51 -0400
Received: from mta09-winn.ispmail.ntl.com ([81.103.221.49]:23875 "EHLO
	mta09-winn.ispmail.ntl.com") by vger.kernel.org with ESMTP
	id S261483AbVGRS7o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Jul 2005 14:59:44 -0400
Message-ID: <42DBFC9E.1040607@gentoo.org>
Date: Mon, 18 Jul 2005 20:01:50 +0100
From: Daniel Drake <dsd@gentoo.org>
User-Agent: Mozilla Thunderbird 1.0.5 (X11/20050715)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: jgarzik@pobox.com, martin.povolny@solnet.cz
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Promise TX4200 support?
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I recieved an email from someone claiming to be stuck with Linux 2.4, due to 
relying on a Promise TX4200 disk controller (using the fdsata driver from 
promise's website, which is 2.4-only):

0000:01:09.0 RAID bus controller: Promise Technology, Inc.: Unknown device 
3519 (rev 02)
         Subsystem: Promise Technology, Inc.: Unknown device 3519
         Flags: bus master, 66Mhz, medium devsel, latency 64, IRQ 9
         I/O ports at dc00 [size=128]
         I/O ports at d800 [size=256]
         Memory at ff8ff000 (32-bit, non-prefetchable) [size=4K]
         Memory at ff8c0000 (32-bit, non-prefetchable) [size=128K]
         Expansion ROM at ff8e0000 [disabled] [size=64K]
         Capabilities: [60] Power Management version 2

What is the status of this on 2.6? I found a blank changeset (??) in the mail 
below, from 24th May:

Jeff Garzik wrote:
 > Please pull the 'new-ids' branch from
 >
 > rsync://rsync.kernel.org/pub/scm/linux/kernel/git/jgarzik/libata-dev.git
 >
 > This add new PCI ids to some SATA drivers.
<snip>
 > commit 37c15447c565ab458ee3778e198d08f4041caa99
 > tree 2eda289903e3bf19eebce7d5f9aaed2240a02479
 > parent 9422e59ddf6cae68e46d7a2c3afe1ce4e739d3eb
 > author Martin Povolny <martin.povolny@solnet.cz> Mon, 16 May 2005 02:41:00 
-0400
 > committer Jeff Garzik <jgarzik@pobox.com> Mon, 16 May 2005 02:41:00 -0400
 >
 > [PATCH] sata_promise: new PCI ID for TX4200
 >
 > [note - blank changeset]
 >

Was this accidently removed, or is the sata_promise driver actually 
incompatible with this hardware?

Thanks,
Daniel

