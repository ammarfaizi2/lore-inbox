Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261309AbTKTTd0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Nov 2003 14:33:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261758AbTKTTdZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Nov 2003 14:33:25 -0500
Received: from the-penguin.otak.com ([65.37.126.18]:47744 "EHLO
	the-penguin.otak.com") by vger.kernel.org with ESMTP
	id S261309AbTKTTdY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Nov 2003 14:33:24 -0500
Date: Thu, 20 Nov 2003 11:33:18 -0800
From: Lawrence Walton <lawrence@the-penguin.otak.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Opps on boot 2.6.0-pre9-mm4
Message-ID: <20031120193318.GA5578@the-penguin.otak.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Operating-System: Linux 2.6.0-test9 on an i686
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all, I got this opps when booting 2.6.0-test9-mm4
It happens consistently every boot.

I had to copy it down by hand, I think I got all of it correctly.
As always flames, additional questions, and patches are welcome.





ksymoops 2.4.9 on i686 2.6.0-test9.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.6.0-test9-mm4/ (specified)
     -m /System.map (specified)

Error (regular_file): read_ksyms stat /proc/ksyms failed
No modules in ksyms, skipping objects
No ksyms, skipping lsmod
CPU:    0
EIP:    0098:[<00005121>]  Not tainted VLI
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010046
esi: 0000a15a   edi: 00000000     ebp: c151fe8c       esp: c151fe5a
ds: 00a0   es: 00a8   ss: 0068
Stack: 00000cfe 0e5700a0 000b000b 9daba392 9d3a9b03 9ad10001 00000000 007b0001
       9ab6007b 00000246 00020082 000bdfdc 00020090 00000002 000100a8 000000a0
       9ce70000 0060c025 00020000 00000000 00000000 007b0000 007b0000 02460000
Call Trace:
Code: Bad EIP Value.


>>EIP; 00005121 Before first symbol   <=====

>>ebp; c151fe8c <acqseq_lock.7+108bfa4/3fb69118>
>>esp; c151fe5a <acqseq_lock.7+108bf72/3fb69118>

<0>Kernel panic: Attempted to kill init!

1 error issued.  Results may not be reliable.
-- 
*--* Mail: lawrence@otak.com
*--* Voice: 425.739.4247
*--* Fax: 425.827.9577
*--* HTTP://www.otak-k.com/~lawrence/
--------------------------------------
- - - - - - O t a k  i n c . - - - - - 


