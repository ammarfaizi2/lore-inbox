Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279418AbRJ2Tj0>; Mon, 29 Oct 2001 14:39:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279414AbRJ2TjQ>; Mon, 29 Oct 2001 14:39:16 -0500
Received: from web11301.mail.yahoo.com ([216.136.131.204]:9550 "HELO
	web11301.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S279408AbRJ2Ti4>; Mon, 29 Oct 2001 14:38:56 -0500
Message-ID: <20011029193932.64498.qmail@web11301.mail.yahoo.com>
Date: Mon, 29 Oct 2001 11:39:32 -0800 (PST)
From: Alex Deucher <agd5f@yahoo.com>
Subject: opl3sa2 sound driver and mixers
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have a toshiba portege 3020ct and a libretto 50ct
with a opl3sa2 sound chips.  The modules load ok and
sound works, but an extra mixer seems to always load. 
I always suspected t was because of code sharing or
somthing, but I thought I'd ask here to see if it was
a bug or just a quirk of the driver.  I don't have the
notebook on hand right, now do these are from memory. 
When I load sound, several modules get loaded, opl3sa2
and AD18?? (can't remember the number off hand). 
What's strange is that 2 mixers seem to get loaded. 
The first is for a CS4??? (can't recall the exact
numbers) and the second is for the opl3sa2.  The
problem is that most sound applications like gmix for
example, seem to enumerate the CS4??? mixer (which
does nothing) as the first mixer and the opl3sa2 mixer
(which works) as the second mixer.  Why is that?  Is
there a way to get rid of the CS4??? mixer or have it
be enumerated as the second mixer device?

Just curious,

Alex

__________________________________________________
Do You Yahoo!?
Make a great connection at Yahoo! Personals.
http://personals.yahoo.com
