Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268177AbUGWXdM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268177AbUGWXdM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jul 2004 19:33:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268178AbUGWXdM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jul 2004 19:33:12 -0400
Received: from wsip-68-99-153-203.ri.ri.cox.net ([68.99.153.203]:56965 "EHLO
	blue-labs.org") by vger.kernel.org with ESMTP id S268177AbUGWXdH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jul 2004 19:33:07 -0400
Message-ID: <4101A08D.4080008@blue-labs.org>
Date: Fri, 23 Jul 2004 19:34:37 -0400
From: David Ford <david+challenge-response@blue-labs.org>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.8a3) Gecko/20040721
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel mailing list <linux-kernel@vger.kernel.org>
Subject: [OOPS] 2.6.8-rc2, USB HID
Content-Type: multipart/mixed;
 boundary="------------080308090102050908070509"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------080308090102050908070509
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Unplugged my UPS to tidy up the cables, this is what happened:

usb 2-1.1: USB disconnect, address 3
Unable to handle kernel paging request at 00000002dbd9c158 RIP:
<ffffffff803d3fed>{hiddev_cleanup+29}
PML4 1ab71067 PGD 0
Oops: 0002 [1] PREEMPT
CPU 0
Modules linked in: ipt_MASQUERADE iptable_nat ip_conntrack 
iptable_mangle ipt_TCPMSS ipt_REJECT iptable_filter ip_tables
Pid: 6152, comm: apcupsd Tainted: P   2.6.8-rc2
RIP: 0010:[<ffffffff803d3fed>] <ffffffff803d3fed>{hiddev_cleanup+29}
RSP: 0018:000001001cd55ed8  EFLAGS: 00010246
RAX: ffffffff807e6900 RBX: 000001001f84abb0 RCX: 0000000000000000
RDX: 000000006b6b6b6b RSI: ffffffff80732160 RDI: 000001001f84abb0
RBP: 000001001f84ac00 R08: 0000007fbffff6d0 R09: ffffffff00000000
R10: 0000000000000008 R11: 0000000000000206 R12: 000001001a2025f8
R13: 000001001e850660 R14: 0000000000000001 R15: 0000007fbffff8f0
FS:  0000002a95e8a920(0000) GS:ffffffff80806a40(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
CR2: 00000002dbd9c158 CR3: 0000000000101000 CR4: 00000000000006e0
Process apcupsd (pid: 6152, threadinfo 000001001cd54000, task 
000001001dc22cb0)
Stack: 000001001f84abb0 ffffffff803d40ad 000001001e7c5200 000001001fefb258
       000001001de7ab08 ffffffff80192312 000000000000009f 000001001e7c5200
       0000000000000000 000001001fecb890
Call Trace:<ffffffff803d40ad>{hiddev_release+141} 
<ffffffff80192312>{__fput+98}
       <ffffffff8019041e>{filp_close+126} <ffffffff801905db>{sys_close+411}
       <ffffffff80110e56>{system_call+126}

Code: 48 c7 84 d0 00 fd ff ff 00 00 00 00 48 8b 47 48 48 8b b8 80
RIP <ffffffff803d3fed>{hiddev_cleanup+29} RSP <000001001cd55ed8>
CR2: 00000002dbd9c158
 <6>usb 2-1.1: new low speed USB device using address 7
hiddev97: USB HID v1.10 Device [APC Back-UPS ES 350 FW:1.e2.D USB FW:e2] 
on usb-0000:00:10.0-1.1


--------------080308090102050908070509
Content-Type: text/x-vcard; charset=utf-8;
 name="david+challenge-response.vcf"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="david+challenge-response.vcf"

begin:vcard
fn:David Ford
n:Ford;David
email;internet:david@blue-labs.org
title:Industrial Geek
tel;home:Ask please
tel;cell:(203) 650-3611
x-mozilla-html:TRUE
version:2.1
end:vcard


--------------080308090102050908070509--
