Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318041AbSGWLu5>; Tue, 23 Jul 2002 07:50:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318040AbSGWLu4>; Tue, 23 Jul 2002 07:50:56 -0400
Received: from [196.26.86.1] ([196.26.86.1]:34738 "HELO
	infosat-gw.realnet.co.sz") by vger.kernel.org with SMTP
	id <S318036AbSGWLu4>; Tue, 23 Jul 2002 07:50:56 -0400
Date: Tue, 23 Jul 2002 14:11:50 +0200 (SAST)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
X-X-Sender: zwane@linux-box.realnet.co.sz
To: Alan Cox <alan@lxorguk.ukuu.org.uk>, James Cleverdon <jamesclv@us.ibm.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.19-rc3-ac2 SMP
In-Reply-To: <Pine.LNX.4.44.0207231355230.32636-100000@linux-box.realnet.co.sz>
Message-ID: <Pine.LNX.4.44.0207231409000.32636-100000@linux-box.realnet.co.sz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 23 Jul 2002, Zwane Mwaikambo wrote:

> Around here the machine gets a vector 0x31 (timer) interrupt on CPU0 then 
> locks up since the destination cpu bitmask is 0, It also seems that the 
> code is trying to use logical apic id in places instead of the physical 
> apic id, i saw attempted deliveries to physical apic id 4 and 8, this can 
> possibly explain the APIC receive errors people were reporting? 

Correction, the logical/physical apic id problem doesn't appear to be 
there with the summit patch. What i'm currently seeing is a destination of 
0 with a non flat/physical destination format.

-- 
function.linuxpower.ca

