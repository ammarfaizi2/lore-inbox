Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262141AbVDFICS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262141AbVDFICS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Apr 2005 04:02:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262142AbVDFICS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Apr 2005 04:02:18 -0400
Received: from web53903.mail.yahoo.com ([206.190.36.126]:47254 "HELO
	web53903.mail.yahoo.com") by vger.kernel.org with SMTP
	id S262141AbVDFICG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Apr 2005 04:02:06 -0400
Comment: DomainKeys? See http://antispam.yahoo.com/domainkeys
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  b=OZdHLie3yjT4VvSsRd+ss1uUzeg9Rww06EE0RQNpoG23m/Ast85hODnNILbfoYReSZBIVVwI1VE3Ddrnr0zrqW73XJ1jBkawhdeFot5c+I66dnkeEZG89w2QSIcOK/HKnb+6nqhCppYwKXpEFZIL1vFYqZObra0OTLLrNKD9+og=  ;
Message-ID: <20050406080205.48789.qmail@web53903.mail.yahoo.com>
Date: Wed, 6 Apr 2005 01:02:05 -0700 (PDT)
From: nobin matthew <nobin_matthew@yahoo.com>
Subject: HELP:(VIPER BOARD)AC'97 controller driver for rtlinux(rtlinux core driver) 
To: kernelnewbies@nl.linux.org, linux-kernel@vger.kernel.org,
       linux-net@vger.kernel.org, linux-arm-kernel@lists.arm.linux.org.uk
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear friends,

I am trying to develop a codec driver (rtlinux driver)
from scratch.
In Viper board (PXA255) physical memory range
0x40000000-0x43FFFFFF is used by the PXA255
peripherals.In that address range
0x40500000-0x405005FC is needed for AC'97 controller
registers. Is this memory range is already mapped to
virtual address space, else How to map this to virtual
address space.

When i tried ioremap() it is giving same virtual
address with different physical address(i tried
ioremap with another driver(same board)with different
physical memory address)
 
Or if this driver already available for RTLinux Please
sent me.

Nobin Mathew




		
__________________________________ 
Do you Yahoo!? 
Yahoo! Personals - Better first dates. More second dates. 
http://personals.yahoo.com

