Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131028AbRC0JYL>; Tue, 27 Mar 2001 04:24:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131063AbRC0JYB>; Tue, 27 Mar 2001 04:24:01 -0500
Received: from mail.n-online.net ([195.30.220.100]:48657 "HELO
	mohawk.n-online.net") by vger.kernel.org with SMTP
	id <S131028AbRC0JXy>; Tue, 27 Mar 2001 04:23:54 -0500
Date: Tue, 27 Mar 2001 11:23:07 +0200
From: Thomas Foerster <puckwork@madz.net>
To: linux-kernel@vger.kernel.org
Subject: RE: URGENT : System hands on "Freeing unused kernel memory: "
X-Mailer: Thomas Foerster's registered AK-Mail 3.1 publicbeta2a [ger]
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <20010327092358Z131028-406+4343@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Does it hang forever ?

Yes :(

> I've noticed that my kernel (2.4.2) stalls for several minutes with the same
> message but suddenly after that the login prompt appears (anything between,
> like configurations and services starting messages, are gone). We've been
> able to track it down to a change we did to /etc/lilo.conf to add support
> for kernel prints to go out to a serial debugger. Before that everything was
> OK, but after we added append="console=tty0 console=ttyS1,38400", this
> problem started. We did notice however that everything that doesn't appear
> on the console does appear on the serial debugger.

We didn't change anything on the system .. it once crashed and now it won't boot
anymore, it always stops at "freeing unused kernel memory ..."

Thomas

