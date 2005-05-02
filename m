Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261242AbVEBOD3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261242AbVEBOD3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 May 2005 10:03:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261248AbVEBOD3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 May 2005 10:03:29 -0400
Received: from rproxy.gmail.com ([64.233.170.196]:59670 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261242AbVEBOCs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 May 2005 10:02:48 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:x-accept-language:mime-version:to:subject:content-type:content-transfer-encoding;
        b=mumPmXmpNNCZQcScvGwV43yWuNykHoPTJOyL0csuoryaRKwDsjw6YnXAvvmtbyyshvmUQijXI8hkNxzDSkEuOBSrBIlm1nBb+ZdCOGjxLMEN5NjT1OpbswtDHD3Rlhk0rNm5MzdPmfu9CliIz94ryN6pJEC8Boo3iWVvVcfZI9o=
Message-ID: <42763388.1030008@gmail.com>
Date: Mon, 02 May 2005 16:04:56 +0200
From: Mateusz Berezecki <mateuszb@gmail.com>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050331)
X-Accept-Language: pl, en-us, en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: 2.6.12-rc3 OOPS  in vanilla source (once more)
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

i send it once more....

May  2 12:56:31 localhost kernel: Unable to handle kernel NULL pointer 
dereference at virtual address 00000000
May  2 12:56:31 localhost kernel:  printing eip:
May  2 12:56:31 localhost kernel: 00000000
May  2 12:56:31 localhost kernel: *pde = 00000000
May  2 12:56:31 localhost kernel: Oops: 0000 [#21]
May  2 12:56:31 localhost kernel: PREEMPT
May  2 12:56:31 localhost kernel: Modules linked in: b44
May  2 12:56:31 localhost kernel: CPU:    0
May  2 12:56:31 localhost kernel: EIP:    0060:[<00000000>]    Not 
tainted VLI
May  2 12:56:31 localhost kernel: EFLAGS: 00010286   (2.6.12-rc3-debug)
May  2 12:56:31 localhost kernel: EIP is at 0x0
May  2 12:56:31 localhost kernel: eax: ca086000   ebx: ce873d00   ecx: 
cee73a20   edx: 00000000
May  2 12:56:31 localhost kernel: esi: cee73a20   edi: 00002e9a   ebp: 
01200011   esp: ca086fc4
May  2 12:56:31 localhost kernel: ds: 007b   es: 007b   ss: 0068
May  2 12:56:31 localhost kernel: Process make-jpkg (pid: 4209, 
threadinfo=ca086000 task=cee73a20)
May  2 12:56:31 localhost kernel: Stack: 01202011 00000000 00000000 
00000000 b7f00bc8 bff65438 00000000 0000007b
May  2 12:56:31 localhost kernel:        c010007b 00000078 b7e71a53 
00000073 00000282 bff653f0 0000007b
May  2 12:56:31 localhost kernel: Call Trace:
May  2 12:56:31 localhost kernel:  [show_stack+127/160] show_stack+0x7f/0xa0
May  2 12:56:31 localhost kernel:  [show_registers+342/448] 
show_registers+0x156/0x1c0
May  2 12:56:31 localhost kernel:  [die+234/384] die+0xea/0x180
May  2 12:56:31 localhost kernel:  [do_page_fault+806/1682] 
do_page_fault+0x326/0x692
May  2 12:56:31 localhost kernel:  [error_code+79/84] error_code+0x4f/0x54
May  2 12:56:31 localhost kernel: Code:  Bad EIP value.
May  2 13:02:32 localhost kernel:  <1>divide error: 0000 [#22]
May  2 13:02:32 localhost kernel: PREEMPT
May  2 13:02:32 localhost kernel: Modules linked in: b44
May  2 13:02:32 localhost kernel: CPU:    0
May  2 13:02:32 localhost kernel: EIP:    0060:[<b7e34b52>]    Not 
tainted VLI
May  2 13:02:32 localhost kernel: EFLAGS: 00010246   (2.6.12-rc3-debug)
May  2 13:02:32 localhost kernel: EIP is at 0xb7e34b52
May  2 13:02:32 localhost kernel: eax: ca03b000   ebx: cef04580   ecx: 
cf48f520   edx: 00000000
May  2 13:02:32 localhost kernel: esi: cf48f520   edi: 000c2de0   ebp: 
007d0f00   esp: ca03bfc4
May  2 13:02:32 localhost kernel: ds: 007b   es: 007b   ss: 0068
May  2 13:02:32 localhost kernel: Process 5filozofow (pid: 4283, 
threadinfo=ca03b000 task=cf48f520)
May  2 13:02:32 localhost kernel: Stack: 007d2f00 b7e34b48 b7e34bf8 
bfa9f9a0 b7e34bf8 bfa9f9c8 00000000 0000007b
May  2 13:02:32 localhost kernel:        c010007b 00000078 b7f0d17c 
00000073 00000296 b7e34b48 0000007b
May  2 13:02:32 localhost kernel: Call Trace:
May  2 13:02:32 localhost kernel:  [show_stack+127/160] show_stack+0x7f/0xa0
May  2 13:02:32 localhost kernel:  [show_registers+342/448] 
show_registers+0x156/0x1c0
May  2 13:02:32 localhost kernel:  [die+234/384] die+0xea/0x180
May  2 13:02:32 localhost kernel:  [do_divide_error+188/208] 
do_divide_error+0xbc/0xd0
May  2 13:02:32 localhost kernel:  [error_code+79/84] error_code+0x4f/0x54
May  2 13:02:32 localhost kernel: Code:  Bad EIP value.
May  2 13:02:32 localhost kernel:  <1>divide error: 0000 [#23]
May  2 13:02:32 localhost kernel: PREEMPT
May  2 13:02:32 localhost kernel: Modules linked in: b44
May  2 13:02:32 localhost kernel: CPU:    0
May  2 13:02:32 localhost kernel: EIP:    0060:[<b7634b52>]    Not 
tainted VLI
May  2 13:02:32 localhost kernel: EFLAGS: 00010246   (2.6.12-rc3-debug)
May  2 13:02:32 localhost kernel: EIP is at 0xb7634b52
May  2 13:02:32 localhost kernel: eax: c9695000   ebx: cef5dd00   ecx: 
cf0c8a20   edx: 00000000
May  2 13:02:32 localhost kernel: esi: cf0c8a20   edi: 00005077   ebp: 
007d0f00   esp: c9695fc4
May  2 13:02:32 localhost kernel: ds: 007b   es: 007b   ss: 0068
May  2 13:02:32 localhost kernel: Process 5filozofow (pid: 4284, 
threadinfo=c9695000 task=cf0c8a20)
May  2 13:02:32 localhost kernel: Stack: 007d2f00 b7634b48 b7634bf8 
bfa9f9a0 b7634bf8 bfa9f9c8 00000000 0000007b
May  2 13:02:32 localhost kernel:        c010007b 00000078 b7f0d17c 
00000073 00000296 b7634b48 0000007b
May  2 13:02:32 localhost kernel: Call Trace:
May  2 13:02:32 localhost kernel:  [show_stack+127/160] show_stack+0x7f/0xa0
May  2 13:02:32 localhost kernel:  [show_registers+342/448] 
show_registers+0x156/0x1c0
May  2 13:02:32 localhost kernel:  [die+234/384] die+0xea/0x180
May  2 13:02:32 localhost kernel:  [do_divide_error+188/208] 
do_divide_error+0xbc/0xd0
May  2 13:02:32 localhost kernel:  [error_code+79/84] error_code+0x4f/0x54
May  2 13:02:32 localhost kernel: Code:  Bad EIP value.
May  2 13:02:32 localhost kernel:  <1>Unable to handle kernel paging 
request at virtual address b5e3535e
May  2 13:02:32 localhost kernel:  printing eip:
May  2 13:02:32 localhost kernel: b5e34b52
May  2 13:02:32 localhost kernel: *pde = 0a2fd067
May  2 13:02:32 localhost kernel: *pte = 00000000
May  2 13:02:32 localhost kernel: Oops: 0000 [#24]
May  2 13:02:32 localhost kernel: PREEMPT
May  2 13:02:32 localhost kernel: Modules linked in: b44
May  2 13:02:32 localhost kernel: CPU:    0
May  2 13:02:32 localhost kernel: EIP:    0060:[<b5e34b52>]    Not 
tainted VLI
May  2 13:02:32 localhost kernel: EFLAGS: 00010246   (2.6.12-rc3-debug)
May  2 13:02:32 localhost kernel: EIP is at 0xb5e34b52
May  2 13:02:32 localhost kernel: eax: ca03b000   ebx: ce873800   ecx: 
cf48f520   edx: 00000000
May  2 13:02:32 localhost kernel: esi: cf48f520   edi: 000007ae   ebp: 
007d0f00   esp: ca03bfc4
May  2 13:02:32 localhost kernel: ds: 007b   es: 007b   ss: 0068
May  2 13:02:32 localhost kernel: Process 5filozofow (pid: 4287, 
threadinfo=ca03b000 task=cf48f520)
May  2 13:02:32 localhost kernel: Stack: 007d2f00 b5e34b48 b5e34bf8 
bfa9f9a0 b5e34bf8 bfa9f9c8 00000000 0000007b
May  2 13:02:32 localhost kernel:        c010007b 00000078 b7f0d17c 
00000073 00000296 b5e34b48 0000007b
May  2 13:02:32 localhost kernel: Call Trace:
May  2 13:02:32 localhost kernel:  [show_stack+127/160] show_stack+0x7f/0xa0
May  2 13:02:32 localhost kernel:  [show_registers+342/448] 
show_registers+0x156/0x1c0
May  2 13:02:32 localhost kernel:  [die+234/384] die+0xea/0x180
May  2 13:02:32 localhost kernel:  [do_page_fault+806/1682] 
do_page_fault+0x326/0x692
May  2 13:02:32 localhost kernel:  [error_code+79/84] error_code+0x4f/0x54
May  2 13:02:32 localhost kernel: Code:  Bad EIP value.
May  2 13:02:32 localhost kernel:  <1>divide error: 0000 [#25]
May  2 13:02:32 localhost kernel: PREEMPT
May  2 13:02:32 localhost kernel: Modules linked in: b44
May  2 13:02:32 localhost kernel: CPU:    0
May  2 13:02:32 localhost kernel: EIP:    0060:[<b6e34b52>]    Not 
tainted VLI
May  2 13:02:32 localhost kernel: EFLAGS: 00010246   (2.6.12-rc3-debug)
May  2 13:02:32 localhost kernel: EIP is at 0xb6e34b52
May  2 13:02:32 localhost kernel: eax: ca19f000   ebx: cef5dd00   ecx: 
cf0c8520   edx: 00000000
May  2 13:02:32 localhost kernel: esi: cf0c8520   edi: 00004773   ebp: 
007d0f00   esp: ca19ffc4
May  2 13:02:32 localhost kernel: ds: 007b   es: 007b   ss: 0068
May  2 13:02:32 localhost kernel: Process 5filozofow (pid: 4285, 
threadinfo=ca19f000 task=cf0c8520)
May  2 13:02:32 localhost kernel: Stack: 007d2f00 b6e34b48 b6e34bf8 
bfa9f9a0 b6e34bf8 bfa9f9c8 00000000 0000007b
May  2 13:02:32 localhost kernel:        c010007b 00000078 b7f0d17c 
00000073 00000296 b6e34b48 0000007b
May  2 13:02:32 localhost kernel: Call Trace:
May  2 13:02:32 localhost kernel:  [show_stack+127/160] show_stack+0x7f/0xa0
May  2 13:02:32 localhost kernel:  [show_registers+342/448] 
show_registers+0x156/0x1c0
May  2 13:02:32 localhost kernel:  [die+234/384] die+0xea/0x180
May  2 13:02:32 localhost kernel:  [do_divide_error+188/208] 
do_divide_error+0xbc/0xd0
May  2 13:02:32 localhost kernel:  [error_code+79/84] error_code+0x4f/0x54
May  2 13:02:32 localhost kernel: Code:  Bad EIP value.
May  2 13:02:32 localhost kernel:  <1>divide error: 0000 [#26]
May  2 13:02:32 localhost kernel: PREEMPT
May  2 13:02:32 localhost kernel: Modules linked in: b44
May  2 13:02:32 localhost kernel: CPU:    0
May  2 13:02:32 localhost kernel: EIP:    0060:[<b6634b52>]    Not 
tainted VLI
May  2 13:02:32 localhost kernel: EFLAGS: 00010246   (2.6.12-rc3-debug)
May  2 13:02:32 localhost kernel: EIP is at 0xb6634b52
May  2 13:02:32 localhost kernel: eax: ca1d3000   ebx: ce873800   ecx: 
cee2f520   edx: 00000000
May  2 13:02:32 localhost kernel: esi: cee2f520   edi: 000003dd   ebp: 
007d0f00   esp: ca1d3fc4
May  2 13:02:32 localhost kernel: ds: 007b   es: 007b   ss: 0068
May  2 13:02:32 localhost kernel: Process 5filozofow (pid: 4286, 
threadinfo=ca1d3000 task=cee2f520)
May  2 13:02:32 localhost kernel: Stack: 007d2f00 b6634b48 b6634bf8 
bfa9f9a0 b6634bf8 bfa9f9c8 00000000 0000007b
May  2 13:02:32 localhost kernel:        c010007b 00000078 b7f0d17c 
00000073 00000296 b6634b48 0000007b
May  2 13:02:32 localhost kernel: Call Trace:
May  2 13:02:32 localhost kernel:  [show_stack+127/160] show_stack+0x7f/0xa0
May  2 13:02:32 localhost kernel:  [show_registers+342/448] 
show_registers+0x156/0x1c0
May  2 13:02:32 localhost kernel:  [die+234/384] die+0xea/0x180
May  2 13:02:32 localhost kernel:  [do_divide_error+188/208] 
do_divide_error+0xbc/0xd0
May  2 13:02:32 localhost kernel:  [error_code+79/84] error_code+0x4f/0x54
May  2 13:02:32 localhost kernel: Code:  Bad EIP value.
May  2 13:04:50 localhost kernel:  <1>Unable to handle kernel paging 
request at virtual address dbb0b7ef
May  2 13:04:50 localhost kernel:  printing eip:
May  2 13:04:50 localhost kernel: b7dbdb50
May  2 13:04:50 localhost kernel: *pde = 00000000
May  2 13:04:50 localhost kernel: Oops: 0002 [#27]
May  2 13:04:50 localhost kernel: PREEMPT
May  2 13:04:50 localhost kernel: Modules linked in:
May  2 13:04:50 localhost kernel: CPU:    0
May  2 13:04:50 localhost kernel: EIP:    0060:[<b7dbdb50>]    Not 
tainted VLI
May  2 13:04:50 localhost kernel: EFLAGS: 00010202   (2.6.12-rc3-debug)
May  2 13:04:50 localhost kernel: EIP is at 0xb7dbdb50
May  2 13:04:50 localhost kernel: eax: cda4e000   ebx: ce873080   ecx: 
cec3da20   edx: 00000000
May  2 13:04:50 localhost kernel: esi: cec3da20   edi: 000008ec   ebp: 
007d0f00   esp: cda4efc4
May  2 13:04:50 localhost kernel: ds: 007b   es: 007b   ss: 0068
May  2 13:04:50 localhost kernel: Process 5filozofow (pid: 4322, 
threadinfo=cda4e000 task=cec3da20)
May  2 13:04:50 localhost kernel: Stack: 007d2f00 b7dbdb48 b7dbdbf8 
bfa26460 b7dbdbf8 bfa26488 00000000 0000007b
May  2 13:04:50 localhost kernel:        c010007b 00000078 b7e9617c 
00000073 00000296 b7dbdb48 0000007b
May  2 13:04:50 localhost kernel: Call Trace:
May  2 13:04:50 localhost kernel:  [show_stack+127/160] show_stack+0x7f/0xa0
May  2 13:04:50 localhost kernel:  [show_registers+342/448] 
show_registers+0x156/0x1c0
May  2 13:04:50 localhost kernel:  [die+234/384] die+0xea/0x180
May  2 13:04:50 localhost kernel:  [do_page_fault+806/1682] 
do_page_fault+0x326/0x692
May  2 13:04:50 localhost kernel:  [error_code+79/84] error_code+0x4f/0x54
May  2 13:04:50 localhost kernel: Code:  Bad EIP value.
May  2 13:04:50 localhost kernel:  <1>Unable to handle kernel paging 
request at virtual address dbb0b7ef
May  2 13:04:50 localhost kernel:  printing eip:
May  2 13:04:50 localhost kernel: b75bdb50
May  2 13:04:50 localhost kernel: *pde = 00000000
May  2 13:04:50 localhost kernel: Oops: 0002 [#28]
May  2 13:04:50 localhost kernel: PREEMPT
May  2 13:04:50 localhost kernel: Modules linked in:
May  2 13:04:50 localhost kernel: CPU:    0
May  2 13:04:50 localhost kernel: EIP:    0060:[<b75bdb50>]    Not 
tainted VLI
May  2 13:04:50 localhost kernel: EFLAGS: 00010202   (2.6.12-rc3-debug)
May  2 13:04:50 localhost kernel: EIP is at 0xb75bdb50
May  2 13:04:50 localhost kernel: eax: cda4e000   ebx: ce873080   ecx: 
cec3da20   edx: 00000000
May  2 13:04:50 localhost kernel: esi: cec3da20   edi: 00000836   ebp: 
007d0f00   esp: cda4efc4
May  2 13:04:50 localhost kernel: ds: 007b   es: 007b   ss: 0068
May  2 13:04:50 localhost kernel: Process 5filozofow (pid: 4323, 
threadinfo=cda4e000 task=cec3da20)
May  2 13:04:50 localhost kernel: Stack: 007d2f00 b75bdb48 b75bdbf8 
bfa26460 b75bdbf8 bfa26488 00000000 0000007b
May  2 13:04:50 localhost kernel:        c010007b 00000078 b7e9617c 
00000073 00000296 b75bdb48 0000007b
May  2 13:04:50 localhost kernel: Call Trace:
May  2 13:04:50 localhost kernel:  [show_stack+127/160] show_stack+0x7f/0xa0
May  2 13:04:50 localhost kernel:  [show_registers+342/448] 
show_registers+0x156/0x1c0
May  2 13:04:50 localhost kernel:  [die+234/384] die+0xea/0x180
May  2 13:04:50 localhost kernel:  [do_page_fault+806/1682] 
do_page_fault+0x326/0x692
May  2 13:04:50 localhost kernel:  [error_code+79/84] error_code+0x4f/0x54
May  2 13:04:50 localhost kernel: Code:  Bad EIP value.
May  2 13:04:50 localhost kernel:  <1>Unable to handle kernel paging 
request at virtual address dbb0b7ef
May  2 13:04:50 localhost kernel:  printing eip:
May  2 13:04:50 localhost kernel: b6dbdb50
May  2 13:04:50 localhost kernel: *pde = 00000000
May  2 13:04:50 localhost kernel: Oops: 0002 [#29]
May  2 13:04:50 localhost kernel: PREEMPT
May  2 13:04:50 localhost kernel: Modules linked in:
May  2 13:04:50 localhost kernel: CPU:    0
May  2 13:04:50 localhost kernel: EIP:    0060:[<b6dbdb50>]    Not 
tainted VLI
May  2 13:04:50 localhost kernel: EFLAGS: 00010202   (2.6.12-rc3-debug)
May  2 13:04:50 localhost kernel: EIP is at 0xb6dbdb50
May  2 13:04:50 localhost kernel: eax: cda4e000   ebx: ce873080   ecx: 
cec3da20   edx: 00000000
May  2 13:04:50 localhost kernel: esi: cec3da20   edi: 000008a5   ebp: 
007d0f00   esp: cda4efc4
May  2 13:04:50 localhost kernel: ds: 007b   es: 007b   ss: 0068
May  2 13:04:50 localhost kernel: Process 5filozofow (pid: 4324, 
threadinfo=cda4e000 task=cec3da20)
May  2 13:04:50 localhost kernel: Stack: 007d2f00 b6dbdb48 b6dbdbf8 
bfa26460 b6dbdbf8 bfa26488 00000000 0000007b
May  2 13:04:50 localhost kernel:        c010007b 00000078 b7e9617c 
00000073 00000296 b6dbdb48 0000007b
May  2 13:04:50 localhost kernel: Call Trace:
May  2 13:04:50 localhost kernel:  [show_stack+127/160] show_stack+0x7f/0xa0
May  2 13:04:50 localhost kernel:  [show_registers+342/448] 
show_registers+0x156/0x1c0
May  2 13:04:50 localhost kernel:  [die+234/384] die+0xea/0x180
May  2 13:04:50 localhost kernel:  [do_page_fault+806/1682] 
do_page_fault+0x326/0x692
May  2 13:04:50 localhost kernel:  [error_code+79/84] error_code+0x4f/0x54
May  2 13:04:50 localhost kernel: Code:  Bad EIP value.
May  2 13:04:50 localhost kernel:  <1>Unable to handle kernel paging 
request at virtual address dbb0b7ef
May  2 13:04:50 localhost kernel:  printing eip:
May  2 13:04:50 localhost kernel: b65bdb50
May  2 13:04:50 localhost kernel: *pde = 00000000
May  2 13:04:50 localhost kernel: Oops: 0002 [#30]
May  2 13:04:50 localhost kernel: PREEMPT
May  2 13:04:50 localhost kernel: Modules linked in:
May  2 13:04:50 localhost kernel: CPU:    0
May  2 13:04:50 localhost kernel: EIP:    0060:[<b65bdb50>]    Not 
tainted VLI
May  2 13:04:50 localhost kernel: EFLAGS: 00010202   (2.6.12-rc3-debug)
May  2 13:04:50 localhost kernel: EIP is at 0xb65bdb50
May  2 13:04:50 localhost kernel: eax: cda4e000   ebx: ce873080   ecx: 
cec3da20   edx: 00000000
May  2 13:04:50 localhost kernel: esi: cec3da20   edi: 00000820   ebp: 
007d0f00   esp: cda4efc4
May  2 13:04:50 localhost kernel: ds: 007b   es: 007b   ss: 0068
May  2 13:04:50 localhost kernel: Process 5filozofow (pid: 4325, 
threadinfo=cda4e000 task=cec3da20)
May  2 13:04:50 localhost kernel: Stack: 007d2f00 b65bdb48 b65bdbf8 
bfa26460 b65bdbf8 bfa26488 00000000 0000007b
May  2 13:04:50 localhost kernel:        c010007b 00000078 b7e9617c 
00000073 00000296 b65bdb48 0000007b
May  2 13:04:50 localhost kernel: Call Trace:
May  2 13:04:50 localhost kernel:  [show_stack+127/160] show_stack+0x7f/0xa0
May  2 13:04:50 localhost kernel:  [show_registers+342/448] 
show_registers+0x156/0x1c0
May  2 13:04:50 localhost kernel:  [die+234/384] die+0xea/0x180
May  2 13:04:50 localhost kernel:  [do_page_fault+806/1682] 
do_page_fault+0x326/0x692
May  2 13:04:50 localhost kernel:  [error_code+79/84] error_code+0x4f/0x54
May  2 13:04:50 localhost kernel: Code:  Bad EIP value.
May  2 13:04:50 localhost kernel:  <1>Unable to handle kernel paging 
request at virtual address dbb0b7ef
May  2 13:04:50 localhost kernel:  printing eip:
May  2 13:04:50 localhost kernel: b5dbdb50
May  2 13:04:50 localhost kernel: *pde = 00000000
May  2 13:04:50 localhost kernel: Oops: 0002 [#31]
May  2 13:04:50 localhost kernel: PREEMPT
May  2 13:04:50 localhost kernel: Modules linked in:
May  2 13:04:50 localhost kernel: CPU:    0
May  2 13:04:50 localhost kernel: EIP:    0060:[<b5dbdb50>]    Not 
tainted VLI
May  2 13:04:50 localhost kernel: EFLAGS: 00010202   (2.6.12-rc3-debug)
May  2 13:04:50 localhost kernel: EIP is at 0xb5dbdb50
May  2 13:04:50 localhost kernel: eax: cda4e000   ebx: ce873080   ecx: 
cec3da20   edx: 00000000
May  2 13:04:50 localhost kernel: esi: cec3da20   edi: 00000872   ebp: 
007d0f00   esp: cda4efc4
May  2 13:04:50 localhost kernel: ds: 007b   es: 007b   ss: 0068
May  2 13:04:50 localhost kernel: Process 5filozofow (pid: 4326, 
threadinfo=cda4e000 task=cec3da20)
May  2 13:04:50 localhost kernel: Stack: 007d2f00 b5dbdb48 b5dbdbf8 
bfa26460 b5dbdbf8 bfa26488 00000000 0000007b
May  2 13:04:50 localhost kernel:        c010007b 00000078 b7e9617c 
00000073 00000296 b5dbdb48 0000007b
May  2 13:04:50 localhost kernel: Call Trace:
May  2 13:04:50 localhost kernel:  [show_stack+127/160] show_stack+0x7f/0xa0
May  2 13:04:50 localhost kernel:  [show_registers+342/448] 
show_registers+0x156/0x1c0
May  2 13:04:50 localhost kernel:  [die+234/384] die+0xea/0x180
May  2 13:04:50 localhost kernel:  [do_page_fault+806/1682] 
do_page_fault+0x326/0x692
May  2 13:04:50 localhost kernel:  [error_code+79/84] error_code+0x4f/0x54
May  2 13:04:50 localhost kernel: Code:  Bad EIP value.

and another one

May  2 13:34:14 localhost kernel: Unable to handle kernel paging request 
at virtual address fbb0b7f2
May  2 13:34:14 localhost kernel:  printing eip:
May  2 13:34:14 localhost kernel: b7defb50
May  2 13:34:14 localhost kernel: *pde = 00000000
May  2 13:34:14 localhost kernel: Oops: 0002 [#1]
May  2 13:34:14 localhost kernel: PREEMPT
May  2 13:34:14 localhost kernel: Modules linked in:
May  2 13:34:14 localhost kernel: CPU:    0
May  2 13:34:14 localhost kernel: EIP:    0060:[<b7defb50>]    Not 
tainted VLI
May  2 13:34:14 localhost kernel: EFLAGS: 00010202   (2.6.12-rc3-debug)
May  2 13:34:14 localhost kernel: EIP is at 0xb7defb50
May  2 13:34:14 localhost kernel: eax: cdd6f000   ebx: ceeab080   ecx: 
ce6a9020   edx: 00000000
May  2 13:34:14 localhost kernel: esi: ce6a9020   edi: 000037ec   ebp: 
007d0f00   esp: cdd6ffc4
May  2 13:34:14 localhost kernel: ds: 007b   es: 007b   ss: 0068
May  2 13:34:14 localhost kernel: Process 5 (pid: 3898, 
threadinfo=cdd6f000 task=ce6a9020)
May  2 13:34:14 localhost kernel: Stack: 007d2f00 b7defb48 b7defbf8 
bfb57a60 b7defbf8 bfb57a88 00000000 0000007b
May  2 13:34:14 localhost kernel:        c010007b 00000078 b7ec817c 
00000073 00000296 b7defb48 0000007b
May  2 13:34:14 localhost kernel: Call Trace:
May  2 13:34:14 localhost kernel:  [show_stack+127/160] show_stack+0x7f/0xa0
May  2 13:34:14 localhost kernel:  [show_registers+342/448] 
show_registers+0x156/0x1c0
May  2 13:34:14 localhost kernel:  [die+234/384] die+0xea/0x180
May  2 13:34:14 localhost kernel:  [do_page_fault+806/1682] 
do_page_fault+0x326/0x692
May  2 13:34:14 localhost kernel:  [error_code+79/84] error_code+0x4f/0x54
May  2 13:34:14 localhost kernel: Code:  Bad EIP value.
May  2 13:34:14 localhost kernel:  <1>Unable to handle kernel paging 
request at virtual address fbb0b7f2
May  2 13:34:14 localhost kernel: Unable to handle kernel paging request 
at virtual address fbb0b7f2
May  2 13:34:14 localhost kernel:  printing eip:
May  2 13:34:14 localhost kernel: b6defb50
May  2 13:34:14 localhost kernel: *pde = 00000000
May  2 13:34:14 localhost kernel: Oops: 0002 [#2]
May  2 13:34:14 localhost kernel: PREEMPT
May  2 13:34:14 localhost kernel: Modules linked in:
May  2 13:34:14 localhost kernel: CPU:    0
May  2 13:34:14 localhost kernel: EIP:    0060:[<b6defb50>]    Not 
tainted VLI
May  2 13:34:14 localhost kernel: EFLAGS: 00010202   (2.6.12-rc3-debug)
May  2 13:34:14 localhost kernel: EIP is at 0xb6defb50
May  2 13:34:14 localhost kernel: eax: ce3d2000   ebx: ceeab800   ecx: 
cf48f020   edx: 00000000
May  2 13:34:14 localhost kernel: esi: cf48f020   edi: 000002b0   ebp: 
007d0f00   esp: ce3d2fc4
May  2 13:34:14 localhost kernel: ds: 007b   es: 007b   ss: 0068
May  2 13:34:14 localhost kernel: Process 5 (pid: 3900, 
threadinfo=ce3d2000 task=cf48f020)
May  2 13:34:14 localhost kernel: Stack: 007d2f00 b6defb48 b6defbf8 
bfb57a60 b6defbf8 bfb57a88 00000000 0000007b
May  2 13:34:14 localhost kernel:        c010007b 00000078 b7ec817c 
00000073 00000296 b6defb48 0000007b
May  2 13:34:14 localhost kernel: Call Trace:
May  2 13:34:14 localhost kernel:  [show_stack+127/160] show_stack+0x7f/0xa0
May  2 13:34:14 localhost kernel:  [show_registers+342/448] 
show_registers+0x156/0x1c0
May  2 13:34:14 localhost kernel:  [die+234/384] die+0xea/0x180
May  2 13:34:14 localhost kernel:  [do_page_fault+806/1682] 
do_page_fault+0x326/0x692
May  2 13:34:14 localhost kernel:  [error_code+79/84] error_code+0x4f/0x54
May  2 13:34:14 localhost kernel: Code:  Bad EIP value.
May  2 13:34:14 localhost kernel:  <1>Unable to handle kernel paging 
request at virtual address fbb0b7f2
May  2 13:34:14 localhost kernel:  printing eip:
May  2 13:34:14 localhost kernel: b65efb50
May  2 13:34:14 localhost kernel: *pde = 00000000
May  2 13:34:14 localhost kernel: Oops: 0002 [#3]
May  2 13:34:14 localhost kernel: PREEMPT
May  2 13:34:14 localhost kernel: Modules linked in:
May  2 13:34:14 localhost kernel: CPU:    0
May  2 13:34:14 localhost kernel: EIP:    0060:[<b65efb50>]    Not 
tainted VLI
May  2 13:34:14 localhost kernel: EFLAGS: 00010202   (2.6.12-rc3-debug)
May  2 13:34:14 localhost kernel: EIP is at 0xb65efb50
May  2 13:34:14 localhost kernel: eax: cdd6f000   ebx: ceeab800   ecx: 
ce6a9020   edx: 00000000
May  2 13:34:14 localhost kernel: esi: ce6a9020   edi: 00000881   ebp: 
007d0f00   esp: cdd6ffc4
May  2 13:34:14 localhost kernel: ds: 007b   es: 007b   ss: 0068
May  2 13:34:14 localhost kernel: Process 5 (pid: 3901, 
threadinfo=cdd6f000 task=ce6a9020)
May  2 13:34:14 localhost kernel: Stack: 007d2f00 b65efb48 b65efbf8 
bfb57a60 b65efbf8 bfb57a88 00000000 0000007b
May  2 13:34:14 localhost kernel:        c010007b 00000078 b7ec817c 
00000073 00000296 b65efb48 0000007b
May  2 13:34:14 localhost kernel: Call Trace:
May  2 13:34:14 localhost kernel:  [show_stack+127/160] show_stack+0x7f/0xa0
May  2 13:34:14 localhost kernel:  [show_registers+342/448] 
show_registers+0x156/0x1c0
May  2 13:34:14 localhost kernel:  [die+234/384] die+0xea/0x180
May  2 13:34:14 localhost kernel:  [do_page_fault+806/1682] 
do_page_fault+0x326/0x692
May  2 13:34:14 localhost kernel:  [error_code+79/84] error_code+0x4f/0x54
May  2 13:34:14 localhost kernel: Code:  Bad EIP value.
May  2 13:34:14 localhost kernel:  <1>Unable to handle kernel paging 
request at virtual address fbb0b7f2
May  2 13:34:14 localhost kernel:  printing eip:
May  2 13:34:14 localhost kernel: b5defb50
May  2 13:34:14 localhost kernel: *pde = 00000000
May  2 13:34:14 localhost kernel: Oops: 0002 [#4]
May  2 13:34:14 localhost kernel: PREEMPT
May  2 13:34:14 localhost kernel: Modules linked in:
May  2 13:34:14 localhost kernel: CPU:    0
May  2 13:34:14 localhost kernel: EIP:    0060:[<b5defb50>]    Not 
tainted VLI
May  2 13:34:14 localhost kernel: EFLAGS: 00010202   (2.6.12-rc3-debug)
May  2 13:34:14 localhost kernel: EIP is at 0xb5defb50
May  2 13:34:14 localhost kernel: eax: cdd6f000   ebx: ceeab800   ecx: 
ce6a9020   edx: 00000000
May  2 13:34:14 localhost kernel: esi: ce6a9020   edi: 0000082a   ebp: 
007d0f00   esp: cdd6ffc4
May  2 13:34:14 localhost kernel: ds: 007b   es: 007b   ss: 0068
May  2 13:34:14 localhost kernel: Process 5 (pid: 3902, 
threadinfo=cdd6f000 task=ce6a9020)
May  2 13:34:14 localhost kernel: Stack: 007d2f00 b5defb48 b5defbf8 
bfb57a60 b5defbf8 bfb57a88 00000000 0000007b
May  2 13:34:14 localhost kernel:        c010007b 00000078 b7ec817c 
00000073 00000296 b5defb48 0000007b
May  2 13:34:14 localhost kernel: Call Trace:
May  2 13:34:14 localhost kernel:  [show_stack+127/160] show_stack+0x7f/0xa0
May  2 13:34:14 localhost kernel:  [show_registers+342/448] 
show_registers+0x156/0x1c0
May  2 13:34:14 localhost kernel:  [die+234/384] die+0xea/0x180
May  2 13:34:14 localhost kernel:  [do_page_fault+806/1682] 
do_page_fault+0x326/0x692
May  2 13:34:14 localhost kernel:  [error_code+79/84] error_code+0x4f/0x54
May  2 13:34:14 localhost kernel: Code:  Bad EIP value.
May  2 13:34:14 localhost kernel:  <1> printing eip:
May  2 13:34:14 localhost kernel: b75efb50
May  2 13:34:14 localhost kernel: *pde = 00000000
May  2 13:34:14 localhost kernel: Oops: 0002 [#5]
May  2 13:34:14 localhost kernel: PREEMPT
May  2 13:34:14 localhost kernel: Modules linked in:
May  2 13:34:14 localhost kernel: CPU:    0
May  2 13:34:14 localhost kernel: EIP:    0060:[<b75efb50>]    Not 
tainted VLI
May  2 13:34:14 localhost kernel: EFLAGS: 00010202   (2.6.12-rc3-debug)
May  2 13:34:14 localhost kernel: EIP is at 0xb75efb50
May  2 13:34:14 localhost kernel: eax: cdf66000   ebx: ceeab800   ecx: 
cf48fa20   edx: 00000000
May  2 13:34:14 localhost kernel: esi: cf48fa20   edi: 000008ca   ebp: 
007d0f00   esp: cdf66fc4
May  2 13:34:14 localhost kernel: ds: 007b   es: 007b   ss: 0068
May  2 13:34:14 localhost kernel: Process 5 (pid: 3899, 
threadinfo=cdf66000 task=cf48fa20)
May  2 13:34:14 localhost kernel: Stack: 007d2f00 b75efb48 b75efbf8 
bfb57a60 b75efbf8 bfb57a88 00000000 0000007b
May  2 13:34:14 localhost kernel:        c010007b 00000078 b7ec817c 
00000073 00000296 b75efb48 0000007b
May  2 13:34:14 localhost kernel: Call Trace:
May  2 13:34:14 localhost kernel:  [show_stack+127/160] show_stack+0x7f/0xa0
May  2 13:34:14 localhost kernel:  [show_registers+342/448] 
show_registers+0x156/0x1c0
May  2 13:34:14 localhost kernel:  [die+234/384] die+0xea/0x180
May  2 13:34:14 localhost kernel:  [do_page_fault+806/1682] 
do_page_fault+0x326/0x692
May  2 13:34:14 localhost kernel:  [error_code+79/84] error_code+0x4f/0x54
May  2 13:34:14 localhost kernel: Code:  Bad EIP value.

if someone gets interested i can send more details including kernel config
