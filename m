Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277059AbRJDBKa>; Wed, 3 Oct 2001 21:10:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277060AbRJDBKT>; Wed, 3 Oct 2001 21:10:19 -0400
Received: from [209.237.5.66] ([209.237.5.66]:15778 "EHLO clyde.stargateip.com")
	by vger.kernel.org with ESMTP id <S277059AbRJDBKK>;
	Wed, 3 Oct 2001 21:10:10 -0400
From: "Ian Thompson" <ithompso@stargateip.com>
To: <linux-kernel@vger.kernel.org>
Subject: How can I jump to non-linux address space?
Date: Wed, 3 Oct 2001 18:10:31 -0700
Message-ID: <NFBBIBIEHMPDJNKCIKOBEEGJCAAA.ithompso@stargateip.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2910.0)
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

I'm sorry if this is off-topic, but I wasn't sure where else to ask...

My kernel is running from RAM, and I want to jump to an address in ROM
(which unfortunately, the kernel doesn't seem to know anything about).  I
don't plan on trying to resume the kernel after doing this.  However, I'm
getting a prefetch abort.  If I try and load the data, I get a similar
error: "Unable to handle kernel paging request at virtual address 00003000"
where 0x3000 is the ROM address I'm trying to jump to / load from.  How can
I pass execution to this address?  Do I have to turn off the MMU?  FYI, I'm
running a 2.2 variant on an XScale, and used inline assembly to generate the
load & the branch.

Thanks for your help,

-ian

