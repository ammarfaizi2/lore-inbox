Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261458AbTH1Oko (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Aug 2003 10:40:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263894AbTH1Oko
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Aug 2003 10:40:44 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:25984 "EHLO
	perninha.conectiva.com.br") by vger.kernel.org with ESMTP
	id S261458AbTH1Okn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Aug 2003 10:40:43 -0400
Date: Thu, 28 Aug 2003 11:36:18 -0300 (BRT)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
X-X-Sender: marcelo@freak.distro.conectiva
To: "Robert L. Harris" <Robert.L.Harris@rdlg.net>,
       "David S. Miller" <davem@redhat.com>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.22-bk2 and 2.4.23-pre1 broke routing
Message-ID: <Pine.LNX.4.55L.0308281134120.9167@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


David?


---------------------------

I'm running 2.4.22 now and have a NAT behind my firewall as well as IPv6
happily run through unixcore.com.  I upgraded to 2.4.22-bk2 last night
to fix an odd problem where I can't ssh-6 to one host.  All of a sudden
it all works within the nat but nothing behind the firewall can get out
from behind to the real work though the firewall still can.  Recompiled
trying 2.4.23-pre1 and I get the exact same behavior.  All 3 use the
same .config file.

The only noticable change I can see is a bunch of messages:

Aug 27 22:09:10 wally kernel: MASQUERADE: No route: Rusty's brain broke!
Aug 27 22:09:16 wally kernel: MASQUERADE: No route: Rusty's brain broke!
Aug 27 22:09:16 wally kernel: MASQUERADE: No route: Rusty's brain broke!


As soon as I reverted to 2.4.22 everything works great again.  Attaching
my .config.  Please contact me directly if you need any additional
testing done.

Dual AMD Athalon
512Megs of ram
00:0a.1 I2O: Distributed Processing Technology SmartRAID V Controller (rev
02)
  (Adaptec I20 SCSI controller, no hardware or software raid in use
though)
00:0c.0 Ethernet controller: Intel Corp. 82557/8/9 [Ethernet Pro 100] (rev
02)
00:0d.0 Ethernet controller: Lite-On Communications Inc LNE100TX (rev 20)

Robert

