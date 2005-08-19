Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932542AbVHSIxX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932542AbVHSIxX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Aug 2005 04:53:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932546AbVHSIxX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Aug 2005 04:53:23 -0400
Received: from smtp3.nextra.sk ([195.168.1.142]:26893 "EHLO mailhub3.nextra.sk")
	by vger.kernel.org with ESMTP id S932542AbVHSIxX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Aug 2005 04:53:23 -0400
Message-ID: <43059DF8.2060209@rainbow-software.org>
Date: Fri, 19 Aug 2005 10:53:12 +0200
From: Ondrej Zary <linux@rainbow-software.org>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050716)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Imanpreet Arora <imanpreet@gmail.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Linux under 8MB
References: <c26b9592050818151154ff1a89@mail.gmail.com>
In-Reply-To: <c26b9592050818151154ff1a89@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've made a printserver with i386DX/25, 8MB RAM and 170MB HDD. Kernel is 
2.6.12 (very light - 1.2MB uncompressed), userspace is based on 
Slackware 9.0 (init scripts modified), print server is CUPS. It boots in 
about a minute. It ran with 4MB too but the boot time was around 15 
minutes :-) (with original init scripts).

root@printserver:~# uname -a
Linux printserver 2.6.12-printserver #6 Fri Jul 1 23:40:17 CEST 2005 
i386 unknown
root@printserver:~# cat /proc/cpuinfo
processor       : 0
vendor_id       : unknown
cpu family      : 3
model           : 0
model name      : 386
stepping        : unknown
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : no
fpu_exception   : no
cpuid level     : -1
wp              : no
flags           :
bogomips        : 4.28

root@printserver:~# free
              total       used       free     shared    buffers     cached
Mem:          6752       6196        556          0        528       3980
-/+ buffers/cache:       1688       5064
Swap:        32000          0      32000

-- 
Ondrej Zary
