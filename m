Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129245AbRDBTRe>; Mon, 2 Apr 2001 15:17:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129460AbRDBTRZ>; Mon, 2 Apr 2001 15:17:25 -0400
Received: from athena.intergrafix.net ([206.245.154.69]:16804 "HELO
	athena.intergrafix.net") by vger.kernel.org with SMTP
	id <S129245AbRDBTRP>; Mon, 2 Apr 2001 15:17:15 -0400
Date: Mon, 2 Apr 2001 15:16:34 -0400 (EDT)
From: Admin Mailing Lists <mlist@intergrafix.net>
To: linux-kernel@vger.kernel.org
Cc: linux-scsi@vger.kernel.org, aic7xxx@freebsd.org
Subject: aic7xxx TCQ settings?
Message-ID: <Pine.LNX.4.10.10104021509450.32252-100000@athena.intergrafix.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I'm using 2.4.3 vanilla with aic7xxx (aic7880 onboard)
I set the max # of TCQ commands per device setting to 50..what's a really
good setting for this, just the default of 253?

In /proc/scsi/aic7xxx/0 i see for my drives these numbers:
	Commands Queued 140000
	Commands Active 0
	Command Openings 253
	Max Tagged Openings 253

and the Queued number keeps increasing, never decreasing. is it supposed
to do this? 
Sometimes Commands Active is at 50, but mostly 0

Thanx,

-Tony
.-._.-._.-._.-._.-._.-._.-._.-._.-._.-._.-._.-._.-._.-._.-._.-._.-._.-.
Anthony J. Biacco                       Network Administrator/Engineer
thelittleprince@asteroid-b612.org       Intergrafix Internet Services

    "Dream as if you'll live forever, live as if you'll die today"
http://www.asteroid-b612.org                http://www.intergrafix.net
.-._.-._.-._.-._.-._.-._.-._.-._.-._.-._.-._.-._.-._.-._.-._.-._.-._.-.


