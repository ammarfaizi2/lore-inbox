Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262824AbTIQTHe (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Sep 2003 15:07:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262848AbTIQTHe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Sep 2003 15:07:34 -0400
Received: from porch.xs4all.nl ([80.126.78.181]:3845 "EHLO porch.xs4all.nl")
	by vger.kernel.org with ESMTP id S262824AbTIQTH3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Sep 2003 15:07:29 -0400
Message-ID: <3F68B0EE.1@nl.tiscali.com>
Date: Wed, 17 Sep 2003 21:07:26 +0200
From: Mark de Vries <m.devries@nl.tiscali.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030908 Debian/1.4-4
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: 1GB, highmem or no?
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I recently added some memory and now have 1GB and the kernel tells me:
"Warning only 896MB will be used.
Use a HIGHMEM enabled kernel.
896MB LOWMEM available."

So I'm not using ~128MB of my memory...

My question is: is enableling HIGHMEM worth it?
It don't know exactly how it works, but I'm guessing the kernel has to 
use some 'trickery' to use the memory above (the mentioned) 896MB. 
'Trickery' implies overhead, no? But how much?
Assuming I'm not stressed for memory; is the extra 128MB worth it??

TIA,
Mark.

ps. pls cc me on reply. I can't handle the traffic so I'm not on the list.

And in case it matters:

I have a system w/ a ASUS A7V8 (VIA KT400) w/ 2x 512MB pc2700 (333MHz) 
now running vanilla 2.4.22-pre4

$ cat /proc/cpuinfo
processor       : 0
vendor_id       : AuthenticAMD
cpu family      : 6
model           : 8
model name      : AMD Athlon(TM) XP 2400+
stepping        : 1
cpu MHz         : 2000.120
cache size      : 256 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge 
mca cmov pat pse36 mmx fxsr sse syscall mmxext 3dnowext 3dnow
bogomips        : 3984.58


