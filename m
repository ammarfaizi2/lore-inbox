Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264582AbTLLNzV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Dec 2003 08:55:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264880AbTLLNzV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Dec 2003 08:55:21 -0500
Received: from mail.blue-edge.bg ([213.222.56.114]:26008 "HELO
	mail.blue-edge.bg") by vger.kernel.org with SMTP id S264582AbTLLNy4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Dec 2003 08:54:56 -0500
Message-ID: <3FD9C8AC.5000008@blue-edge.bg>
Date: Fri, 12 Dec 2003 15:54:52 +0200
From: Deian Chepishev <deian@blue-edge.bg>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.5) Gecko/20031007
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, tsd@asus.com
Subject: P4P800-VM - ASUS - HIGH MEMORY extremely slow under some circumstaces
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I have ASUS P4P800-VM mother board.
Chipset:     Intel 865G GMCH
                 Intel ICH5   - 800MHz FSB

BIOS  Revision: 1007

Embedded LAN  : Intel 82562EZ
Embedded Graphics: Intel Extreme Graphics 2

RAM  2G    4x512M  DDR400 Samsung
HDD IDE  Seagate Barracuda  120G
Processor:  P4 - 2.6 GHz   HyperThreading

OS: Slackware Linux 9.1

Description of the problem:

I have installed 2 GB memory 4x512M
The embedded video uses system memory. If i set it to use only 1 MB or
32MB of system RAM everything seems ok. The system boots normally and
working normally.
If i set it to use 4,8 or 16 MB of the system memory the system boots
much slower and despite it has no errors or something wrong it works
slow. I mean the difference between fast and slow working is really HUGE.
I have made the following test: in a 600MB text file  replace some text
with sed. The line looks like this:

sed s/deian/test/g  testfile > /dev/null

when the system is working normally this is done for ~ 30sec. When the
system is working slowly it takes ~ 9 min and 30 sec.
I have tested this with kernel 2.4.23 from kernel.org. High memory
support is enabled - 4GB. If i have no high memory support enabled the
thing are ok but the kernel see only 900MB of my memory.
The other strange thing is that with kernel 2.6 the system works 
normally ONLY IF video card uses 32MB. It is not like with 2.4.23 when 1 
and 32M but only with 32MB.
I dont think this is normal behavior. And i hope that the problem is not 
the chipset or hardware. I have searched the news groups and other 
people has the same problem too but no solution yet.

I have attached some logs which may help u find what is wrong. If u need 
me to do something more just mail me i shall respond as fast as i can.

Regards,

  Deian Chepishev

