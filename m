Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282644AbRK0TTi>; Tue, 27 Nov 2001 14:19:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282730AbRK0TT3>; Tue, 27 Nov 2001 14:19:29 -0500
Received: from [200.210.136.3] ([200.210.136.3]:55824 "EHLO rf.com.br")
	by vger.kernel.org with ESMTP id <S282647AbRK0TTL>;
	Tue, 27 Nov 2001 14:19:11 -0500
From: "Joao Soares Veiga" <jsveiga_lkml@rf.com.br>
To: "lkml" <linux-kernel@vger.kernel.org>
Cc: "Heikki Levanto" <heikki@indexdata.dk>
Subject: RE: 2.4.16: "Address family not supported" on RH IBM T23
Date: Tue, 27 Nov 2001 17:18:38 -0200
Message-ID: <NDBBJAJICKAIHFABDALNGEEECJAA.jsveiga_lkml@rf.com.br>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2911.0)
X-MimeOLE: Produced By Microsoft MimeOLE V5.00.2314.1300
Importance: Normal
In-Reply-To: <20011127200522.B27480@indexdata.dk>
X-AntiVirus: scanned for viruses by AMaViS 0.2.1 (http://amavis.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> 
> Large problem: Network won't come up. Says:
> > Cannot open netlink socket: Address family not supported by protocol
> 

Have you compiled the netlink device into the kernel?

Check this:
yk /usr/src/linux $ grep NETLINK .config
CONFIG_NETLINK=y

