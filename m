Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129616AbRCCROS>; Sat, 3 Mar 2001 12:14:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129613AbRCCROI>; Sat, 3 Mar 2001 12:14:08 -0500
Received: from slamp.tomt.net ([195.139.204.145]:11238 "HELO slamp.tomt.net")
	by vger.kernel.org with SMTP id <S129609AbRCCRNv>;
	Sat, 3 Mar 2001 12:13:51 -0500
From: "Andre Tomt" <andre@tomt.net>
To: "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
Subject: RE: 2.4.1 crashing every other day
Date: Sat, 3 Mar 2001 18:14:02 +0100
Message-ID: <OPECLOJPBIHLFIBNOMGBGECCDGAA.andre@tomt.net>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2910.0)
In-Reply-To: <OPECLOJPBIHLFIBNOMGBIEHEDBAA.andre@tomt.net>
X-MIMEOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Looks like you were bitten by either the RAID 1 bugs or the
> > elevator bugs.
> > Try a 2.4.2-pre4 or an 2.4.1-ac18 kernel.  Should solve it.
>
> Just installed 2.4.2pre4, seems to be stable for now (testing it
> ATM, running dnetc, several kernel compiles etc.). On 2.4.1 even
> su segfault'd if the server were loaded. But, the problems have
> never appeared before after one or two days uptime, so we'll just
> have to see what happens later on.
>
> As the BIOS settings are the same on both servers, and the CPU
> temperature peaked at +43.5C on the crashing server, I might just
> think it's a software bug. Well, time will tell :-)
>
> Thanks for the input

PS: I'm replying to my own message.

We have solved this problem, it was a CPU fault. It gave all sort of strange
behaviour, like failing pop3 auth, random crashes, files just getting lost
etc. After changing the motherboard and CPU for new ones, this server has
been running flawlessly ever since on 2.4.2-pre4.

Now all I need is some OpenWall'ish patch for 2.4.x that works ;)

Great work guys :-)

--
Regards,
Andre Tomt

