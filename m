Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261576AbUENPtp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261576AbUENPtp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 May 2004 11:49:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261597AbUENPtp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 May 2004 11:49:45 -0400
Received: from wsip-68-99-153-203.ri.ri.cox.net ([68.99.153.203]:2738 "EHLO
	blue-labs.org") by vger.kernel.org with ESMTP id S261576AbUENPth
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 May 2004 11:49:37 -0400
Message-ID: <40A4EA8D.3080200@blue-labs.org>
Date: Fri, 14 May 2004 11:49:33 -0400
From: David Ford <david+challenge-response@blue-labs.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8a) Gecko/20040513
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel mailing list <linux-kernel@vger.kernel.org>
Subject: APIC null ptr dereference, vanilla 2.6.6
Content-Type: multipart/mixed;
 boundary="------------030408020703050309070607"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------030408020703050309070607
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit


May 13 19:22:26 Huntington-Beach Unable to handle kernel NULL pointer 
dereference at virtual address 00000095
May 13 19:22:26 Huntington-Beach printing eip:
May 13 19:22:26 Huntington-Beach c038ed50
May 13 19:22:26 Huntington-Beach *pde = 00000000
May 13 19:22:26 Huntington-Beach Oops: 0002 [#1]
May 13 19:22:26 Huntington-Beach PREEMPT
May 13 19:22:26 Huntington-Beach CPU:    0
May 13 19:22:26 Huntington-Beach EIP:    0060:[<c038ed50>]    Not tainted
May 13 19:22:26 Huntington-Beach EFLAGS: 00010246   (2.6.6)
May 13 19:22:26 Huntington-Beach EIP is at ov51x_v4l1_read+0x30/0x630
May 13 19:22:26 Huntington-Beach eax: 00000095   ebx: f7c04194   ecx: 
00000095   edx: 402be008
May 13 19:22:26 Huntington-Beach esi: 00000000   edi: 00000001   ebp: 
00070800   esp: f489df2c
May 13 19:22:26 Huntington-Beach ds: 007b   es: 007b   ss: 0068
May 13 19:22:26 Huntington-Beach Process camsource (pid: 8176, 
threadinfo=f489d000 task=f1cd31b0)
May 13 19:22:26 Huntington-Beach Stack: ee6b8758 c01048e2 ee6b8758 
ee6b8758 d551daa8 00000002 00020003 c015df0d
May 13 19:22:26 Huntington-Beach 00000095 ffffffff 402be008 f1ab1900 
00000002 f1ab17f8 c0166705 00000000
May 13 19:22:26 Huntington-Beach f1b405b4 00000023 f1b405b4 c0611800 
f6cf7540 00070800 f6cf7560 c014e2a0
May 13 19:22:26 Huntington-Beach Call Trace:
May 13 19:22:26 Huntington-Beach [<c01048e2>] apic_timer_interrupt+0x1a/0x20
May 13 19:22:26 Huntington-Beach [<c015df0d>] send_sigio+0x3d/0xd0
May 13 19:22:26 Huntington-Beach [<c0166705>] __inode_dir_notify+0x85/0xb0
May 13 19:22:26 Huntington-Beach [<c014e2a0>] vfs_read+0xb0/0x100
May 13 19:22:26 Huntington-Beach [<c014e4d8>] sys_read+0x38/0x60
May 13 19:22:26 Huntington-Beach [<c0103e89>] sysenter_past_esp+0x52/0x71
May 13 19:22:26 Huntington-Beach
May 13 19:22:26 Huntington-Beach Code: ff 8f 94 00 00 00 0f 88 48 25 00 
00 31 c0 85 c0 ba fc ff ff


--------------030408020703050309070607
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


--------------030408020703050309070607--
