Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280771AbRKGEyw>; Tue, 6 Nov 2001 23:54:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280768AbRKGEym>; Tue, 6 Nov 2001 23:54:42 -0500
Received: from smyk.apk.net ([207.54.158.17]:60875 "EHLO smyk.apk.net")
	by vger.kernel.org with ESMTP id <S280771AbRKGEyd>;
	Tue, 6 Nov 2001 23:54:33 -0500
Date: Tue, 6 Nov 2001 23:54:30 -0500
From: Mike Kasick <ic382@apk.net>
To: linux-kernel@vger.kernel.org
Subject: EMU10K1 and High Memory conflict in 2.4.13/2.4.14
Message-Id: <20011106235430.1e0df1d4.ic382@apk.net>
X-Mailer: Sylpheed version 0.6.4 (GTK+ 1.2.10; i386-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've been having problems with the EMU10K1 Sound Blaster Live! driver since the release of 2.4.13.  Though I get no errors, all the sounds play garbled and distorted, or not at all.  I didn't have this problem with 2.4.12 and below.  After not hearing anything on the issue I checked over my entire configuration tonight and found that with 4GB or 64GB High Memory Support enabled in my otherwise stock kernel I get these distortions, however with High Memory Support off, everything seems ok.

Among other things, my hardware includes:
Abit KT7 Motherboard (KT-133 chipset)
AMD Athlon Thunderbird 800 MHz processor
1.0 GB PC133 SD-RAM (I think its all Micron, but I'm not sure)
Soundblaster Live! Value

This is my first time posting to the mailing list so forgive me for not being very familiar with the formalities, particularly I have no idea who to mail this to so I'm just posting it to the list in hopes someone reads it.  Also, my primary email address isn't subscribed, so I would appreciate it if all replies were CC'ed to ic382@apk.net -- Thanks.
