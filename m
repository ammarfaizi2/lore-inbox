Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264825AbTFQPma (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jun 2003 11:42:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264827AbTFQPma
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jun 2003 11:42:30 -0400
Received: from [206.107.96.195] ([206.107.96.195]:59472 "EHLO
	penguin.defeet.net") by vger.kernel.org with ESMTP id S264825AbTFQPm1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jun 2003 11:42:27 -0400
Message-ID: <3EEF36D9.40605@defeet.com>
Date: Tue, 17 Jun 2003 11:42:17 -0400
From: Daniel Whitener <dwhitener@defeet.com>
Organization: DeFeet International
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3) Gecko/20030312
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [sparc64] wrong uptime in 2.5.72
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm getting a bad uptime with 2.5.72... It comes up with 497 as soon as you 
boot (I've rebooted multiple times).  The problem wasn't there in 2.5.70. 
This machine is a Sun Ultra 5.

I found this mail in the archives that might help some...
http://www.ussg.iu.edu/hypermail/linux/kernel/0306.1/1698.html

sun root # uname -a
Linux sun.nowhere.net 2.5.72 #1 Tue Jun 17 10:25:45 EST 2003 sparc64 sun4u 
TI UltraSparc IIi GNU/Linux
sun root # uptime
  10:46:35 up 497 days,  2:24,  1 user,  load average: 0.28, 0.17, 0.07
sun root # cat /proc/uptime
42949481.55 77.26
sun root # cat /proc/stat
cpu  1382 0 1783 7626 466
cpu0 1382 0 1783 7626 466
intr 12650 11256 0 0 0 928 459 0 0 0 0 0 0 7 0 0 0
ctxt 14048
btime 1055864690
processes 4217
procs_running 2
procs_blocked 0
sun root # cat /proc/cpuinfo
cpu             : TI UltraSparc IIi
fpu             : UltraSparc IIi integrated FPU
promlib         : Version 3 Revision 25
prom            : 3.25.1
type            : sun4u
ncpus probed    : 1
ncpus active    : 1
Cpu0Bogo        : 719.25
Cpu0ClkTck      : 0000000015752a00
MMU Type        : Spitfire

