Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267243AbTAGBCc>; Mon, 6 Jan 2003 20:02:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267244AbTAGBCc>; Mon, 6 Jan 2003 20:02:32 -0500
Received: from mail.icehouse.net ([204.203.53.8]:528 "HELO mail.icehouse.net")
	by vger.kernel.org with SMTP id <S267243AbTAGBCb>;
	Mon, 6 Jan 2003 20:02:31 -0500
From: "Kaleb Pederson" <kibab@icehouse.net>
To: <alan@lxorguk.ukuu.org.uk>
Cc: "Lkml" <linux-kernel@vger.kernel.org>
Subject: RE: windows=stable, linux=reboots 5 times/50 minutes
Date: Tue, 7 Jan 2003 01:11:08 -0800
Message-ID: <LDEEIFJOHNKAPECELHOAAEJICCAA.kibab@icehouse.net>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2911.0)
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox Wrote:
> Start with the easy bits. Check the CPU fans, run memtest86, reseat all
the cards
> ... Also if your windows test wasnt SMP its not going to have tested much.

I just reseated everything on my system and it still keeps rebooting.  I
have two nice fans for my processors using thermal compound and both are
working correctly.  I forgot to mention that I ran through several
iterations of memtest86 a few weeks ago and it found no problems.  I also
re-ran it two days ago and it again passed several iterations without errors
at which point I started looking to other things.  LKML is my last resort.

As for testing under Windows,  hard drive/controller access seems to be fine
as I can copy GBs of data back/forth without problem, even during
compilation.  I'm not sure if nmake is multithreaded by default or not so
I'm currently compiling two large projects (about 2hrs each on my system)
with both processors stuck at 100%.  If anything should happen under
Windows, I then presume I'm having a hardware problem.

Thanks again.

--Kaleb
PS: Although I'm going to try to monitor the list for the next few days,
please CC me in case I miss it.

