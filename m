Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131262AbRCNCLZ>; Tue, 13 Mar 2001 21:11:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131265AbRCNCLF>; Tue, 13 Mar 2001 21:11:05 -0500
Received: from host3.sputnik7.com ([64.61.8.83]:34402 "EHLO mail.bluetape.com")
	by vger.kernel.org with ESMTP id <S131262AbRCNCKq>;
	Tue, 13 Mar 2001 21:10:46 -0500
Message-ID: <3AAED2F5.AA5E0701@sputnik7.com>
Date: Tue, 13 Mar 2001 21:09:57 -0500
From: Avi Green <avi-help@sputnik7.com>
Reply-To: avi-nospam@sputnik7.com
Organization: sputnik7.com
X-Mailer: Mozilla 4.51 [en] (X11; I; Linux 2.2.5-15 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Can't get driver to work: D-Link DFE-570TX (de4x5.o) on Linux 2.4
X-Priority: 2 (High)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Dear folks,

I apologize for bothering you, but if by any chance this is an easy
question for you to answer (wishful thinking, huh?) I'd be very grateful
if you would.*

I have some new Hawk PCs (Pentium-III) with D-Link DFE-570TX Fast
Ethernet 4-port server adapters.  When I build the machines using Red
Hat's standard 6.2 installer, it automatically finds the de4x5.o driver
module, inserts it into the kernel (which is 2.2), and sets up four
Ethernet interfaces using that driver.

Unfortunately, when I build the 2.4 kernel (which I must do because I
need Netfilter), I can't get the card to work.

* I've tried inserting the old de4x5.o module that came with 2.2, but
there are unmatched symbols.

* I've tried inserting the new de4x5.o module that came with 2.4 in
drivers/net, but it either complains of no such device, I/O error, or
"couldn't find the kernel version the module was compiled for".

* I've tried configuring the kernel with the 3c590/3c900, {DEPCA, DE10x,
DE200, DE201, DE202, DE422}, Tulip (dc21x4x), Generic DECchip, and VIA
Rhine chips, but it doesn't seem to help, whether they're included as
modules or compiled into the kernel.  I've downloaded the latest Tulip
driver but haven't tried it yet.

* I've spent many hours trying to get this to work, and my manager is
getting desparate.

Do you have any ideas?

Thank you VERY, VERY much,
Avi

======================================================
= Avi Green :-) avi at sputnik7.com (-: 212 217-1147 =
========  Unix SysAdmin & System Specialist  =========
=============  http://www.sputnik7.com  ==============
===== Netcasting Music, Videos, Film & Anime 24/7 ====


* I _do_ appreciate any help you give me, and I apologize for bothering
you without first exhausting all of my other resources.  I only do this
because it's so time-critical.  I haven't contributed yet to this
community, but I've given lots in other places.  Thanks for being
understanding.
