Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267032AbRGMLRL>; Fri, 13 Jul 2001 07:17:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267034AbRGMLRB>; Fri, 13 Jul 2001 07:17:01 -0400
Received: from mohawk.n-online.net ([195.30.220.100]:23305 "HELO
	mohawk.n-online.net") by vger.kernel.org with SMTP
	id <S267032AbRGMLQu>; Fri, 13 Jul 2001 07:16:50 -0400
Date: Fri, 13 Jul 2001 13:12:44 +0200
From: Thomas Foerster <puckwork@madz.net>
To: linux-kernel@vger.kernel.org
Subject: Re: Again: Linux 2.4.x and AMD Athlon
X-Mailer: Thomas Foerster's registered AK-Mail 3.11 [ger]
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <20010713111652Z267032-720+1961@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

>> My BIOS is the latest release.
>> I've just phoned with Epox here in Germany and they told me, that their boards
>> are testet with linux and they are working.

> They dont test with Athlon optimisations on . ;)

Seems to be so :)

>> NOTE : Things are ONLY crashing when being NOT root!!

> Thats important.

>>        If i log in as root i can't get KDE/Gnome apps to crash, only when i'm a
>>        "normal" user! Opening xterm as normal user, su-ing to root and starting
>>        applications works too!

> Do you get random crashes or actual logged kernel oopses. Also what X server

I got only one oops in inode.c (forget the actual line number)
The rest are random application crashes on XFree 4.0.3 (GeForce2 GTS, nVidi DRI (older version))
The System NEVER hangs, only applications crash!
(i strace'd konqueror and tried to get some clue why it's crashing ... for me it seems to crash
when bulding list or something like that in memory, if you want, i can attach a strace output)

>> I'm very, very, very confused!

> The kernel isnt known for a tendancy to oops according to user id, so me too

That's what i belivieve in :)

But it's real .. being root (login in as root or suing to root in xterm) prevents applications
from crashing. (doing exactly the same as if i were non-root)

Thomas

