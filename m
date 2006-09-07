Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422705AbWIGXTt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422705AbWIGXTt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Sep 2006 19:19:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422709AbWIGXTs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Sep 2006 19:19:48 -0400
Received: from shawidc-mo1.cg.shawcable.net ([24.71.223.10]:31616 "EHLO
	pd4mo2so.prod.shaw.ca") by vger.kernel.org with ESMTP
	id S1422705AbWIGXTq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Sep 2006 19:19:46 -0400
Date: Thu, 07 Sep 2006 17:18:13 -0600
From: Robert Hancock <hancockr@shaw.ca>
Subject: Re: Panics on AMD X2/NVidiaMCP55Ultra
In-reply-to: <fa.5Ci7uSCK5S3sGLcqEDBk92xuBGc@ifi.uio.no>
To: Tim Okrongli <j6cubic@gmail.com>
Cc: linux-kernel@vger.kernel.org
Message-id: <4500A8B5.7040305@shaw.ca>
MIME-version: 1.0
Content-type: text/plain; charset=ISO-8859-15; format=flowed
Content-transfer-encoding: 7bit
References: <fa.5Ci7uSCK5S3sGLcqEDBk92xuBGc@ifi.uio.no>
User-Agent: Thunderbird 1.5.0.5 (Windows/20060719)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tim Okrongli wrote:
> [6.] Output of my system going down in flames (note: this was copied by 
> hand, but there shuldn't be any typos)
> invalid operand: 0000 [1] SMP
> CPU 1
> Modules linked in: forcedeth yealink floppy pcspkr eth1394 dm_mirror 
> dm_mod pdc_adma sata_mv ata_piix ahci sata_qstor sata_vsc sata_uli 
> sata_sis sata_sx4 sata_nv sata_svw sata_sil24 sata_sil sata_promise 
> libata sbp2 ohci1394 ieee1394 sl811 ohci_hcd uhci_hcd usb_storage usbhid 
> ehci_hcd usbcore
> Pid: 0, comm: swapper Not tainted 2.6.15-gentoo-r5 #1
> RIP: 0010:[<fffffffff80128f64>] [<ffffffff80128f64>]
> RSP: 0018:ffff8100028bbdd0  EFLAGS: 00010202
> RAX: 0000000000000001 RBX: ffff81004f0c29c0 RCX: ffff81003fd40870
> RDX: 0000000000000000 RSI: 0000000000000001 RDI: ffff81003fd40870
> RBP: ffff81004f0c29c0 R08: ffff81005f100c18 R09: ffff81000251a8c0
> R10: 0000000000000002 R11: ffffffff80169a39 R12: ffff81005b027cd0
> R13: 0000000000000000 R14: 000000000000da00 R15: 0000000000002600
> FS:  00002aaaaaf44dc0(0000) GS:ffffffff80478880(0000) 
> knlGS:0000000000000000
> CS:  0010 DS: 0018 CR0: 000000008005003b
> CR2: 000000000054c048 CR3: 0000000059cde000 CR4: 00000000000006a0
> Process swapper (pid: 0, threadinfo ffff8100028b4000, task 
> ffff8100028aa080)
> Stack: ffffffff80169a68 0000000000000200 ffffffff8026b40e ffff81005efc8d48
>       0000000000000282 0000000000000001 ffffffff80269cdb 0000000000000000
>       ffff81005b027cd0 ffff81005ef46240
> Call Trace: <IRQ> [<ffffffff80169a68>] [<ffffffff8026b40e>] 
> [<ffffffff80269cdb>]
>       [<ffffffff8030d581>] [<ffffffff8030d87b>] [<ffffffff803129e9>]
>       [<ffffffff8030d2a0>] [<ffffffff80309901>] [<ffffffff80131a04>]
>       [<ffffffff8010eb4b>] [<ffffffff8011036a>] [<ffffffff80110334>]
>       [<ffffffff8010ddf4>]  <EOI> [<ffffffff8010bc36>] [<ffffffff8010be37>]
>       [<ffffffff8048fda1>]
> 
> Code: 07 3b 45 cc 7e 0c eb 05 3b 47 2c 7d 05 e8 f1 d8 ff ff 48 8b
> RIP [<ffffffff80128f64>] RSP <ffff8100028bbdd0>

With no symbols in the stack trace this is not very useful. Do you have 
CONFIG_KALLSYMS enabled?

-- 
Robert Hancock      Saskatoon, SK, Canada
To email, remove "nospam" from hancockr@nospamshaw.ca
Home Page: http://www.roberthancock.com/

