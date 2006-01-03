Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751160AbWACF3B@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751160AbWACF3B (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jan 2006 00:29:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751162AbWACF3B
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jan 2006 00:29:01 -0500
Received: from thorn.pobox.com ([208.210.124.75]:42893 "EHLO thorn.pobox.com")
	by vger.kernel.org with ESMTP id S1751160AbWACF3A (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jan 2006 00:29:00 -0500
Date: Mon, 2 Jan 2006 23:28:53 -0600
From: Rodney Gordon II <meff@pobox.com>
To: linux-kernel@vger.kernel.org
Subject: P-D x86_64: "trap invalid operand" kernel messages
Message-ID: <20060103052853.GA9159@spherenet.spherevision.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="1yeeQ81UyVL57Vl7"
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--1yeeQ81UyVL57Vl7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

I can reproduce consistantly a kernel trap message when using
the app "transcode".

They all look similar to this:
transcode[27576] trap invalid operand rip:2aaaae2c5990
rsp:7fffff8e7548 error:0

Is this kernel related, or a bug in the application?

Information:
Debian sid, amd64 port w/ marillat debs
2.6.14.5 compiled SMP x86_64 w/ EM64T specified
Pentium D (Dualcore) 3GHz - 1536MB RAM
Asus P5LD2 Mobo - BIOS Rev. 0815 (latest)

Attached is a /proc/cpuinfo output.

Any help is appreciated, please Cc me directly.

-r

-- 
Rodney Gordon II (meff)             |         meff <at> pobox <dot> com
GPG Key ID: 7FF4B2BC                |                   AIM ID: mefforz

--1yeeQ81UyVL57Vl7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=cpuinfo

processor	: 0
vendor_id	: GenuineIntel
cpu family	: 15
model		: 4
model name	:               Intel(R) Pentium(R) D CPU 3.00GHz
stepping	: 4
cpu MHz		: 3010.825
cache size	: 1024 KB
physical id	: 0
siblings	: 2
core id		: 0
cpu cores	: 2
fpu		: yes
fpu_exception	: yes
cpuid level	: 5
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm syscall nx lm constant_tsc pni monitor ds_cpl est cid cx16 xtpr
bogomips	: 6027.74
clflush size	: 64
cache_alignment	: 128
address sizes	: 36 bits physical, 48 bits virtual
power management:

processor	: 1
vendor_id	: GenuineIntel
cpu family	: 15
model		: 4
model name	:               Intel(R) Pentium(R) D CPU 3.00GHz
stepping	: 4
cpu MHz		: 3010.825
cache size	: 1024 KB
physical id	: 0
siblings	: 2
core id		: 1
cpu cores	: 2
fpu		: yes
fpu_exception	: yes
cpuid level	: 5
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm syscall nx lm constant_tsc pni monitor ds_cpl est cid cx16 xtpr
bogomips	: 6020.49
clflush size	: 64
cache_alignment	: 128
address sizes	: 36 bits physical, 48 bits virtual
power management:


--1yeeQ81UyVL57Vl7--
