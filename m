Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264878AbTARRfi>; Sat, 18 Jan 2003 12:35:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264944AbTARRfi>; Sat, 18 Jan 2003 12:35:38 -0500
Received: from mailout10.sul.t-online.com ([194.25.134.21]:13980 "EHLO
	mailout10.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S264878AbTARRfh>; Sat, 18 Jan 2003 12:35:37 -0500
Reply-to: Wolfgang Fritz <wolfgang.fritz@gmx.net>
To: linux-kernel@vger.kernel.org
From: Wolfgang Fritz <wolfgang.fritz@gmx.net>
Subject: swsuspend: possible with VIA Eden processor? Or alternatives?
Date: Sat, 18 Jan 2003 18:14:04 +0100
Organization: None
Message-ID: <b0c20t$rt$1@fritz38552.news.dfncis.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3a) Gecko/20021212
X-Accept-Language: en-us, en, de-de, de
X-AntiVirus: checked by AntiVir MailGate (version: 2.0.1.7; AVE: 6.17.0.2; VDF: 6.17.0.17; host: gurke)
X-AntiVirus: checked by AntiVir MailGate (version: 2.0.1.7; AVE: 6.17.0.2; VDF: 6.17.0.17; host: gurke)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

the swsuspend mini howto says that a processor with pse/pse36 feature is 
required for swsupend in 2.4.

The VIA Eden processor on my EPIA ME6000 board gives:

vdr:~ # cat /proc/cpuinfo
processor       : 0
vendor_id       : CentaurHauls
cpu family      : 6
model           : 7
model name      : VIA Samuel 2
stepping        : 3
cpu MHz         : 599.731
cache size      : 64 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu de tsc msr cx8 mtrr pge mmx 3dnow
bogomips        : 1196.03

So I am obviously out of luck with 2.4 kernels, but what about 2.5 (the 
mini-howto is silent here)?

Or are there alternatives to sw suspend for fast boot in this case 
(preferred for 2.4 kernels as I do not have a 2.5 kernel tree and the 
required infrastructure up to now)

Wolfgang


