Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264196AbTEHAfT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 May 2003 20:35:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264332AbTEHAfT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 May 2003 20:35:19 -0400
Received: from web14006.mail.yahoo.com ([216.136.175.122]:12044 "HELO
	web14006.mail.yahoo.com") by vger.kernel.org with SMTP
	id S264196AbTEHAfS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 May 2003 20:35:18 -0400
Message-ID: <20030508004753.74841.qmail@web14006.mail.yahoo.com>
Date: Wed, 7 May 2003 17:47:53 -0700 (PDT)
From: Tony Spinillo <tspinillo@yahoo.com>
Subject: Re: Kernel Panic - IDE-SCSI
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Same here. 

Kernel 2.4.21-pre1 with RedHat 9. INTEL 845PESVL motherboard. 
It oopses and logs me off from the console.
Thanks,

T

Here is my oops:

ksymoops 2.4.9 on i686 2.4.21-rc1b.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.21-rc1b/ (default)
     -m /usr/src/linux/System.map (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

kernel: Unable to handle kernel NULL pointer dereference at virtual
address 00000000
kernel: 00000000
kernel: *pde = 00000000
kernel: Oops: 0000
kernel: CPU:    0
kernel: EIP:    0010:[<00000000>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
kernel: EFLAGS: 00010246
kernel: eax: f6e33f70   ebx: 00000004   ecx: 00000000   edx: c03398e0
kernel: esi: f6e1b000   edi: f7e5b680   ebp: 00000004   esp: f6e33f54
kernel: ds: 0018   es: 0018   ss: 0018
kernel: Process bash (pid: 13515, stackpage=f6e33000)
kernel: Stack: c021c590 f6e1b000 f6e33f70 00000000 00000004 00000002
00000001 0000000a 
kernel:        00000000 f7805c00 ffffffea c015daf0 f7805c00 080e8408
00000004 f7e5b680 
kernel:        c013d1f3 f7805c00 080e8408 00000004 f7805c20 00000003
00000000 f6e32000 
kernel: Call Trace:    [<c021c590>] [<c015daf0>] [<c013d1f3>]
[<c01090ef>]
kernel: Code:  Bad EIP value.
>>EIP; 00000000 Before first symbol
>>eax; f6e33f70 <_end+36a78878/3848c968>
>>edx; c03398e0 <idescsi_template+0/80>
>>esi; f6e1b000 <_end+36a5f908/3848c968>
>>edi; f7e5b680 <_end+37a9ff88/3848c968>
>>esp; f6e33f54 <_end+36a7885c/3848c968>

Trace; c021c590 <proc_scsi_write+a0/c0>
Trace; c015daf0 <proc_file_write+40/50>
Trace; c013d1f3 <sys_write+a3/140>
Trace; c01090ef <system_call+33/38>

1 warning issued.  Results may not be reliable.

