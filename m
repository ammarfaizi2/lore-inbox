Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262535AbTCIQ1p>; Sun, 9 Mar 2003 11:27:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262536AbTCIQ1p>; Sun, 9 Mar 2003 11:27:45 -0500
Received: from tag.witbe.net ([81.88.96.48]:52233 "EHLO tag.witbe.net")
	by vger.kernel.org with ESMTP id <S262535AbTCIQ1o>;
	Sun, 9 Mar 2003 11:27:44 -0500
From: "Paul Rolland" <rol@as2917.net>
To: "'Paul Rolland'" <rol@as2917.net>, "'lkml'" <linux-kernel@vger.kernel.org>
Subject: Re: [Bug 2.5.64 ???] Immediate reboot at boot
Date: Sun, 9 Mar 2003 17:38:22 +0100
Message-ID: <00aa01c2e65a$4cac98a0$2101a8c0@witbe>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.3416
In-Reply-To: <008701c2e623$f7a3b4a0$2101a8c0@witbe>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hmmmm.....

Following a very good remark from Mark Hahn, this problem is directly
related to the IO APIC on Uniprocessor option. Disabling it makes the
system boot...

Regards,
Paul

> I've installed 2.5.64, and I've compiled it using the same 
> set of options as I've in 2.5.63... (copy of .config from one 
> tree to the other one, then make menuconfig, check it's OK, 
> save, make bzImage)....
> 
> However, when booting 2.5.64, I've :
> boot: test
> Loading test...........................................
> 
> and then the server reboots...
> 
> Machine is brand new P4, so options are set accordingly...
> 

