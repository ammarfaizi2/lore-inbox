Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932099AbWDAGAh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932099AbWDAGAh (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 Apr 2006 01:00:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932121AbWDAGAh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 Apr 2006 01:00:37 -0500
Received: from xproxy.gmail.com ([66.249.82.205]:49494 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932099AbWDAGAg convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 Apr 2006 01:00:36 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=nJv+WpzfVfet54pCezh9644UoleF1uS8k+maO3OS1eofCy6pVWyrK0kTbikV7NlsVJXLQHsdMKVpgE67uuASWmZZj1QwR1SBOf5xzc8DWfmwC8IDNEyKSFv6MrYnM3fEhUh6V0upvrc5yxWsoDKragEuVKncff2IKaECM8UpCTE=
Message-ID: <1305ed680603312200l3cbc734fpd19f31cd770cf25@mail.gmail.com>
Date: Sat, 1 Apr 2006 14:00:35 +0800
From: drangon <drangon.zhou@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: turion MT32 insmod powernow-k8 failed.
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, I have a notebook with turion MT32, there is something wrong with
powernow-k8 module,

Apr  1 13:49:34 localhost kernel: powernow-k8: Found 1 AMD Athlon 64 /
Opteron processors (version 1.60.1)
Apr  1 13:49:34 localhost kernel: register performance failed: bad ACPI data
Apr  1 13:49:34 localhost kernel: found PSB header at 0xffff8100000fcd40
Apr  1 13:49:34 localhost kernel: table vers: 0x14
Apr  1 13:49:34 localhost kernel: flags: 0x0
Apr  1 13:49:34 localhost kernel: voltage stabilization time: 5(*20us)
Apr  1 13:49:34 localhost kernel: flags2: 0xe
Apr  1 13:49:34 localhost kernel: ramp voltage offset: 2
Apr  1 13:49:34 localhost kernel: isochronous relief time: 3
Apr  1 13:49:34 localhost kernel: maximum voltage step: 0 - 0x1
Apr  1 13:49:34 localhost kernel: numpst: 0x1
Apr  1 13:49:34 localhost kernel: plllocktime: 0x2 (units 1us)
Apr  1 13:49:34 localhost kernel: maxfid: 0xa
Apr  1 13:49:34 localhost kernel: maxvid: 0x16
Apr  1 13:49:34 localhost kernel: numpstates: 0x3
Apr  1 13:49:34 localhost kernel: zjg : 0 -- fid 0, vid 22
Apr  1 13:49:34 localhost kernel: zjg : 1 -- fid 8, vid 12
Apr  1 13:49:34 localhost kernel: zjg : 2 -- fid 10, vid 10
Apr  1 13:49:34 localhost kernel: powernow-k8: BIOS error: maxvid
exceeded with pstate 0, (vid 22, rvo 2, max 22))

[root@localhost ~]# uname -a
Linux localhost.localdomain 2.6.16-git19-zjg #3 Sat Apr 1 12:55:05 CST
2006 x86_64 x86_64 x86_64 GNU/Linux

[root@localhost ~]# cat /proc/cpuinfo
processor       : 0
vendor_id       : AuthenticAMD
cpu family      : 15
model           : 36
model name      : AMD Turion(tm) 64 Mobile Technology MT-32
stepping        : 2
cpu MHz         : 1800.100
cache size      : 512 KB
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge
mca cmov pat pse36 clflush mmx fxsr sse sse2 syscall nx mmxext
fxsr_opt lm 3dnowext 3dnow pni lahf_lm
bogomips        : 3603.62
TLB size        : 1024 4K pages
clflush size    : 64
cache_alignment : 64
address sizes   : 40 bits physical, 48 bits virtual
power management: ts fid vid ttp tm stc

any suggestion ??
thank you!
