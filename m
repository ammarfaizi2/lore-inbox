Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310190AbSCSGMK>; Tue, 19 Mar 2002 01:12:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310193AbSCSGL7>; Tue, 19 Mar 2002 01:11:59 -0500
Received: from netfinity.realnet.co.sz ([196.28.7.2]:38563 "HELO
	netfinity.realnet.co.sz") by vger.kernel.org with SMTP
	id <S310190AbSCSGLo>; Tue, 19 Mar 2002 01:11:44 -0500
Date: Tue, 19 Mar 2002 07:54:12 +0200 (SAST)
From: Zwane Mwaikambo <zwane@linux.realnet.co.sz>
X-X-Sender: zwane@netfinity.realnet.co.sz
To: MrChuoi <MrChuoi@yahoo.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: Linux 2.4.19-pre3-ac1
In-Reply-To: <20020319012940.430CC4E534@mail.vnsecurity.net>
Message-ID: <Pine.LNX.4.44.0203190753140.25412-100000@netfinity.realnet.co.sz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
Just a question, does the commited as field specify how much memory has 
actually been *allocated* as per requests, but not necesserily in use? 
This one is my home box, looks a bit crazy don't you think? The box has 
about ~120 processes right now, heavy X session (2000x2000@32 virtual, 
KDE2 with lots of eye candy), two kernel builds in the background and 
cdrecord. 

Linux version 2.4.19-pre2-ac3 (zwane@montezuma) (gcc version 2.96 20000731 
(Red Hat Linux 7.1 2.96-98)) #2 Sat Mar 9 20:44:38 SAST 2002

        total:    used:    free:  shared: buffers:  cached:
Mem:  527527936 519610368  7917568        0 16871424 398352384
Swap: 542785536 73433088 469352448
MemTotal:       515164 kB
MemFree:          7732 kB
MemShared:           0 kB
Buffers:         16476 kB
Cached:         380044 kB
SwapCached:       8972 kB
Active:         262252 kB
Inact_dirty:    209392 kB
Inact_clean:     11248 kB
Inact_target:    96576 kB
HighTotal:           0 kB
HighFree:            0 kB
LowTotal:       515164 kB
LowFree:          7732 kB
SwapTotal:      530064 kB
SwapFree:       458352 kB
Committed AS:  8060848 kB

Things could get interesting if everyone touches their pages ;)


