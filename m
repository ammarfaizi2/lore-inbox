Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261692AbVGFMdr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261692AbVGFMdr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Jul 2005 08:33:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262222AbVGFMdq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Jul 2005 08:33:46 -0400
Received: from web60012.mail.yahoo.com ([209.73.178.75]:38798 "HELO
	web60012.mail.yahoo.com") by vger.kernel.org with SMTP
	id S261692AbVGFJ1H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Jul 2005 05:27:07 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=hCGupNKrcTCo6hbD9+37LJhELrvfMAokW7BvAT098lVpC7WUrc7tx0ivd0V3oXTlnRc/XdXcUqw/5bq6Gtl6KRIUC0OmQ/NZMBSGEVobdIcRt5B0xnc+XapEMib/gPJIleudm40o9tw/fLxvud7GDGkMRxmfOS6YRyGTItyvPsw=  ;
Message-ID: <20050706092657.95280.qmail@web60012.mail.yahoo.com>
Date: Wed, 6 Jul 2005 02:26:57 -0700 (PDT)
From: Rob Prowel <tempest766@yahoo.com>
Subject: PROBLEM: please remove reserved word "new" from kernel headers
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[1.] One line summary of the problem:    

2.4 and 2.6 kernel headers use c++ reserved word "new"
as identifier in function prototypes.

[2.] Full description of the problem/report:

When kernel headers are included in compilation of c++
programs the compile fails because some header files
use "new" in a way that is illegal for c++.  This
shows up when compiling mySQL under linux 2.6.  It
uses $KERNELSOURCE/include/asm-i386/system.h.


[3.] Keywords (i.e., modules, networking, kernel):

new, c++, kernel headers

[4.] Kernel version (from /proc/version):

2.4 and 2.6


While not an error, per se, it is kind of sloppy and
it is amazing that it hasn't shown up before now. 
using the identifier "new" in kernel headers that are
visible to applications programs is a bad idea.

Thanks,
Rob Prowel





		
____________________________________________________
Sell on Yahoo! Auctions – no fees. Bid on great items.  
http://auctions.yahoo.com/
