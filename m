Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1754548AbWKHMIW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754548AbWKHMIW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Nov 2006 07:08:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754553AbWKHMIW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Nov 2006 07:08:22 -0500
Received: from xdsl-664.zgora.dialog.net.pl ([81.168.226.152]:18952 "EHLO
	tuxland.pl") by vger.kernel.org with ESMTP id S1754548AbWKHMIW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Nov 2006 07:08:22 -0500
From: Mariusz Kozlowski <m.kozlowski@tuxland.pl>
Organization: tuxland
To: Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.19-rc5-mm1
Date: Wed, 8 Nov 2006 13:07:26 +0100
User-Agent: KMail/1.9.5
Cc: linux-kernel@vger.kernel.org
References: <20061108015452.a2bb40d2.akpm@osdl.org>
In-Reply-To: <20061108015452.a2bb40d2.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200611081307.27365.m.kozlowski@tuxland.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

	This was seen on athlon machine with 'make allmodconfig'.

  CC [M]  drivers/kvm/kvm_main.o
{standard input}: Assembler messages:
{standard input}:830: Error: no such instruction: `vmclear -12(%ebp)'
{standard input}:979: Error: no such instruction: `vmptrld -36(%ebp)'
{standard input}:1557: Error: no such instruction: `vmxon -20(%ebp)'
{standard input}:1579: Error: no such instruction: `vmxoff'
{standard input}:1935: Error: no such instruction: `vmread %eax,%eax'
{standard input}:1966: Error: no such instruction: `vmwrite %edx,%eax'
{standard input}:8697: Error: no such instruction: `vmwrite %esp,%eax'
{standard input}:8709: Error: no such instruction: `vmlaunch '
{standard input}:8711: Error: no such instruction: `vmresume '
make[2]: *** [drivers/kvm/kvm_main.o] Error 1
make[1]: *** [drivers/kvm] Error 2
make: *** [drivers] Error 2


system info:

Linux localhost 2.6.16-gentoo-r13 #4 PREEMPT Sat Oct 14 17:47:21 CEST 2006 i686 AMD Athlon(tm) XP 1700+ AuthenticAMD GNU/Linux
 
Gnu C                  3.4.6
Gnu make               3.81
binutils               2.16.1
util-linux             2.12r
mount                  2.12r
module-init-tools      3.2.2
e2fsprogs              1.39
nfs-utils              1.0.6
Linux C Library        > libc.2.4
Dynamic linker (ldd)   2.4
Procps                 3.2.6
Net-tools              1.60
Kbd                    1.12
Sh-utils               6.4
udev                   087
Modules Loaded

Regards,

	Mariusz Kozlowski
   
