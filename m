Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264962AbTBGNo2>; Fri, 7 Feb 2003 08:44:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265099AbTBGNo2>; Fri, 7 Feb 2003 08:44:28 -0500
Received: from ns.investici.org ([213.140.29.37]:33416 "EHLO
	astio.investici.org") by vger.kernel.org with ESMTP
	id <S264962AbTBGNo1>; Fri, 7 Feb 2003 08:44:27 -0500
Message-ID: <3E43C79A.2010506@autistici.org>
Date: Fri, 07 Feb 2003 14:50:02 +0000
From: c1cc10 <c1cc10@autistici.org>
Reply-To: c1cc10@autistici.org
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020623 Debian/1.0.0-0.woody.1
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Cyrix III processor and kernel boot problem
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,
I made an unsuccessfull search on the m-l archive about this problem, so 
now I'm going to report it in the developing m-l.
I own a Cyrix III processor (400 Mhz up to 800Mhz) on a via chipset 
motherboard. When I boot with a kernel compiled for Cyrix processor or 
with a 686 pentium the lilo gets the images, put it on memory and 
decompress it, but when it has to boot (after the "Loading 
mlinuz..........") it always reboot the computer.
I've found out that the Cyrix III has no CMOV instruction and that this 
could be the problem.
So I compiled a pentium mmx version (after mrproper and dep) and all 
worked fine.
My question is: ok, it can't work if 686 compiled, but why does not it 
work also for the Cyrix III version?

I tried a "vanilla" kernel and some htb pathced one.
kernel versions: 2.4.19 and 2.4.20.
hope my report will help

keep up the good work

feel free to contact me

bye

c1cc10
-- 
pub  1024D/76A9AC52 2002-12-13 ciunociciunozero (PORCODIO) <c1cc10@ecn.org>
      Key fingerprint = 64A9 9498 B297 B49F D676  AAA1 9DA9 CABA 76A9 AC52
sub  2048g/F248FA79 2002-12-13 [expires: 2004-12-12]


