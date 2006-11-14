Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965600AbWKNNHs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965600AbWKNNHs (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Nov 2006 08:07:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965606AbWKNNHs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Nov 2006 08:07:48 -0500
Received: from xdsl-664.zgora.dialog.net.pl ([81.168.226.152]:23315 "EHLO
	tuxland.pl") by vger.kernel.org with ESMTP id S965600AbWKNNHr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Nov 2006 08:07:47 -0500
From: Mariusz Kozlowski <m.kozlowski@tuxland.pl>
Organization: tuxland
To: Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.19-rc5-mm2
Date: Tue, 14 Nov 2006 14:07:19 +0100
User-Agent: KMail/1.9.5
Cc: linux-kernel@vger.kernel.org
References: <20061114014125.dd315fff.akpm@osdl.org> <200611141346.52401.m.kozlowski@tuxland.pl>
In-Reply-To: <200611141346.52401.m.kozlowski@tuxland.pl>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200611141407.19720.m.kozlowski@tuxland.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, 

	Not sure if this is important. On 2 boxes I've seen a bunch of similar 
warnings. Please see the log:

http://tuxland.pl/misc/2.6.19-rc5-mm2-report.txt (211kB)

both boxes used 'allmodconfig' configuration. This is from one of them:

Linux orion 2.6.19-rc5-mm2 #1 PREEMPT Tue Nov 14 11:14:35 CET 2006 i686 
Intel(R) Pentium(R) 4 CPU 2.40GHz GenuineIntel GNU/Linux
 
Gnu C                  4.1.1
Gnu make               3.81
binutils               2.17
util-linux             2.12r
mount                  2.12r
module-init-tools      3.2.2
e2fsprogs              1.39
pcmciautils            014
pcmcia-cs              3.2.9
nfs-utils              1.0.6
Linux C Library        > libc.2.4
Dynamic linker (ldd)   2.4
Procps                 3.2.6
Net-tools              1.60
Kbd                    1.12
Sh-utils               6.4
udev                   087
wireless-tools         29
Modules Loaded         orinoco_cs orinoco hermes pcmcia firmware_class 8139too 
yenta_socket rsrc_nonstatic pcmcia_core

processor       : 0
vendor_id       : GenuineIntel
cpu family      : 15
model           : 2
model name      : Intel(R) Pentium(R) 4 CPU 2.40GHz
stepping        : 9
cpu MHz         : 2392.531
cache size      : 512 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 sep mtrr pge mca cmov pat 
pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe cid xtpr
bogomips        : 4786.53
clflush size    : 64

-- 
Regards,

	Mariusz Kozlowski
