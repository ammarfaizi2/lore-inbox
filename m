Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131461AbRCWVqq>; Fri, 23 Mar 2001 16:46:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131463AbRCWVqh>; Fri, 23 Mar 2001 16:46:37 -0500
Received: from [209.23.127.10] ([209.23.127.10]:34066 "HELO digibel.net")
	by vger.kernel.org with SMTP id <S131461AbRCWVqb>;
	Fri, 23 Mar 2001 16:46:31 -0500
Date: Fri, 23 Mar 2001 22:44:58 +0100 (CET)
From: Michael Devogelaere <michael@digibel.be>
To: linux-kernel@vger.kernel.org
Subject: network unusable
Message-ID: <Pine.LNX.4.21.0103232233030.29774-100000@gisco.digibel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I'm experiencing problems with an rtl8029-nic. The computer acts as a
multicast-client receiving a disk-image from a server. That transfer went
fine during the first 1.5 gb and then the machine stopped responding.
I tried to ping it, but got no answer. On the machine i see that the
error-packets (/sbin/ifconfig) grow very fast, but the machine cannot
send or receive anymore.  The arp-table contains 00:00:.. for all 
hw-addresses.  Dmesg shows: 
eth0: bogus packet size: 65360, status=0x0 nxpg=0x0
(repeated for 100+ times)

The machine runs kernel 2.4.2 without module-support. All other participating 
computers have exactly the same hardware and software (they were all cloned 
with ghost).  If i restart the program, everything goes fine for some 
minutes and then another computer crashes with exactly the same symptoms.
When i restart the network-configuration, everything seems to work again.

Any help would be appreciated !

Kindly regards,
Michael Devogelaere.

