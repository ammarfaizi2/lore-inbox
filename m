Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263600AbTC2Qxv>; Sat, 29 Mar 2003 11:53:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263822AbTC2Qxv>; Sat, 29 Mar 2003 11:53:51 -0500
Received: from anchor-post-39.mail.demon.net ([194.217.242.80]:11243 "EHLO
	anchor-post-39.mail.demon.net") by vger.kernel.org with ESMTP
	id <S263820AbTC2Qxu>; Sat, 29 Mar 2003 11:53:50 -0500
Date: Sat, 29 Mar 2003 17:04:57 +0000
From: Craig Robinson <craig.robinson@btinternet.com>
X-Mailer: The Bat! (v1.61) Business
Reply-To: Craig Robinson <craig.robinson@btinternet.com>
Organization: BT
X-Priority: 3 (Normal)
Message-ID: <153495685337.20030329170457@btinternet.com>
To: linux-kernel-owner@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re[2]: 845GE Chipset severe performance problems
In-Reply-To: <1048949147.6725.3.camel@dhcp22.swansea.linux.org.uk>
References: <188481168784.20030329130300@btinternet.com>
 <1048949147.6725.3.camel@dhcp22.swansea.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Alan,


Many thanks for the reply..

cat /proc/mtrr shows things, but not sure what it SHOULD be...(output
below)

Running 2.5.66 now seems to have speeded up things considerably,
however, I still consider this slow for a 2.4Ghz machine (we have some
2Ghz under alot of load that will still compile things quicker..)

So any suggestions and of course the help you have already provided
are appreciated.

Craig

--

 [/usr/src]# cat /proc/mtrr
reg00: base=0x00000000 (   0MB), size= 256MB: write-back, count=1
reg01: base=0x10000000 ( 256MB), size= 128MB: write-back, count=1
reg02: base=0x18000000 ( 384MB), size=  64MB: write-back, count=1
reg03: base=0x1c000000 ( 448MB), size=  32MB: write-back, count=1
reg04: base=0x1e000000 ( 480MB), size=  16MB: write-back, count=1
reg05: base=0x1f000000 ( 496MB), size=   8MB: write-back, count=1
reg06: base=0xe0000000 (3584MB), size=  64MB: write-combining, count=1

-
Saturday, March 29, 2003, 2:45:48 PM, you wrote:

AC> Check the mtrr ranges. The odd junk bios gets this wrong and leaves
AC> you with parts of main memory uncached. The symptoms you see might
AC> be from that if they are all identical boxes.

AC> Alan



-- 
Best regards,
 Craig                            mailto:craig.robinson@btinternet.com


