Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263282AbTC0Qar>; Thu, 27 Mar 2003 11:30:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263285AbTC0Qar>; Thu, 27 Mar 2003 11:30:47 -0500
Received: from 12-229-138-196.client.attbi.com ([12.229.138.196]:21123 "EHLO
	waltsathlon.localhost.net") by vger.kernel.org with ESMTP
	id <S263282AbTC0Qap>; Thu, 27 Mar 2003 11:30:45 -0500
Message-ID: <3E8329D2.7040909@comcast.net>
Date: Thu, 27 Mar 2003 08:41:54 -0800
From: Walt H <waltabbyh@comcast.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4a) Gecko/20030326
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: vesafb problem
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all,

I've got a strange problem with my 760MPX system dual proc system. If I 
try to use vesafb to setup the video on boot, the system will boot fine, 
but will be unable to display anything on the console. The system 
appears to be largely unaffacted by any underlying problem, as it is 
stable after boot and seems to run fine. In looking through logs 
afterward, I find these suspect messages:

mtrr: your CPUs had inconsistent fixed MTRR settings
vesafb: abort, cannot ioremap video memory 0x8000000 @ 0xe8000000

I've tried using the rivafb frame buffer, which also does not work. From 
what I could see in scanning the archives, this appears to possibly be a 
BIOS issue, however, I'm game to throw nearly anything at it to try and 
resolve it. Hardware is as follows:

Chaintech 7KDD 760MPX chipset motherboard
2 x AMD 2400MP
1 GB Ram
Nvidia GeForce 4600

I've tried a vanilla 2.4.20 linux kernel as well as my current 2.4.20-ck 
patched kernel, both with same result. I've also tried compiling as UP, 
which has no effect. I'm currently using acpi and apic, however, I've 
tried disabling both, to no avail. Any other ideas? Please CC me, as I'm 
not susbscribed. Thanks,

-Walt

PS. Maybe unrelated, but... I have to pass mem=nopentium as boot param, 
otherwise I system appears to get corrupted memory issues within short 
period of time after boot. ie: unable to launch apps, segfaults etc...

