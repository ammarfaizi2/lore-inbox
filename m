Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290498AbSAQWYh>; Thu, 17 Jan 2002 17:24:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290497AbSAQWYZ>; Thu, 17 Jan 2002 17:24:25 -0500
Received: from warden.digitalinsight.com ([208.29.163.2]:14988 "HELO
	warden.diginsite.com") by vger.kernel.org with SMTP
	id <S290496AbSAQWYR>; Thu, 17 Jan 2002 17:24:17 -0500
From: David Lang <david.lang@digitalinsight.com>
To: linux-kernel@vger.kernel.org
Date: Thu, 17 Jan 2002 14:23:52 -0800 (PST)
Subject: Tulip driver bug in 2.4.17 (fwd)
Message-ID: <Pine.LNX.4.40.0201171423050.26448-100000@dlang.diginsite.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

as I have not received any response directly I am sending this to the full
list for help.

David Lang

---------- Forwarded message ----------
Date: Mon, 14 Jan 2002 15:10:42 -0800 (PST)
From: David Lang <dlang@diginsite.com>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
Subject: Tulip driver bug in 2.4.17

I am running a dlink DFE-570TX quad card that works fine with the 0.9.14
driver in 2.4.8, but with the 2.4.15-pre9 driver in 2.4.14-2.4.17 I run
into a bug when trying to use all the interfaces.

if I use eth3 alone it works
if I use eth0, eth1, eth2 it works
if I use eth0, eth1, eth3 it locks up immediatly following the ifconfig,
locking up to the point that the magic sysreq stuff doesn't work!

if I work the other direction and ifconfig eth3, eth2, eth1, eth0 I get a
shell prompt back after the last ifconfig before it locks up.

I posted this friday on sourceforge, but looking today at the activity
there it doesn't look like it's in use much now so I'm sending this
directly to you. If there is any other place I should send it or any
additional tests I should perform, please let me know (I have 50 of these
cards either in production or headed there soon :-)

David Lang
