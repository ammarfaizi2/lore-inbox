Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751716AbVJ1U7D@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751716AbVJ1U7D (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Oct 2005 16:59:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751720AbVJ1U7C
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Oct 2005 16:59:02 -0400
Received: from hell.sks3.muni.cz ([147.251.210.189]:50340 "EHLO
	anubis.fi.muni.cz") by vger.kernel.org with ESMTP id S1751716AbVJ1U7B
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Oct 2005 16:59:01 -0400
Date: Fri, 28 Oct 2005 22:58:33 +0200
From: Lukas Hejtmanek <xhejtman@mail.muni.cz>
To: linux-kernel@vger.kernel.org
Subject: Re: 4GB memory and Intel Dual-Core system
Message-ID: <20051028205833.GM2533@mail.muni.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-echelon: NSA, CIA, CI5, MI5, FBI, KGB, BIS, Plutonium, Bin Laden, bomb
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I have system with 2 Pentium 4 Xeon EM64T processors using 4GB of RAM.

Kernel is 2.6.13.4 compiled for x86_64 architecture.

Btw, /proc/cpuinfo reports, that only 36 bits are availalable for physical 
memory. Not 40.

# cat /proc/meminfo 
MemTotal:      4075408 kB
MemFree:         23696 kB

# cat /proc/iomem
[...]
dd100000-dd3fffff : PCI Bus #01
  dd100000-dd100fff : 0000:01:00.1
  dd101000-dd101fff : 0000:01:00.3
  dd200000-dd2fffff : PCI Bus #02
    dd200000-dd201fff : 0000:02:02.0
      dd200000-dd200fff : aic79xx
    dd202000-dd203fff : 0000:02:02.1
      dd202000-dd202fff : aic79xx
    dd220000-dd23ffff : 0000:02:03.0
      dd220000-dd23ffff : e1000
    dd240000-dd25ffff : 0000:02:03.1
      dd240000-dd25ffff : e1000
  dd300000-dd3fffff : PCI Bus #03
    dd300000-dd3fffff : 0000:03:04.0
dd400000-deffffff : PCI Bus #06
  dd400000-dd400fff : 0000:06:01.0
  de000000-deffffff : 0000:06:01.0
e0000000-efffffff : reserved
fec00000-fec0ffff : reserved
fee00000-fee00fff : reserved
ff800000-ffbfffff : reserved
fffffc00-ffffffff : reserved
100000000-12fffffff : System RAM

According to /proc/pci it is E7520/E7525 board. It has a number of PCI devices.

-- 
Luká¹ Hejtmánek
