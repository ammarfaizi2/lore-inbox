Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272135AbRIOHTk>; Sat, 15 Sep 2001 03:19:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272124AbRIOHTa>; Sat, 15 Sep 2001 03:19:30 -0400
Received: from pD900DE6D.dip.t-dialin.net ([217.0.222.109]:21287 "EHLO
	bennew01.localdomain") by vger.kernel.org with ESMTP
	id <S272121AbRIOHTN>; Sat, 15 Sep 2001 03:19:13 -0400
Date: Sat, 15 Sep 2001 09:20:01 +0200
From: Matthias Haase <matthias_haase@bennewitz.com>
To: Martin Josefsson <gandalf@wlug.westbo.se>
Cc: linux-kernel@vger.kernel.org
Subject: Re: repeatable SMP lockups - kernel 2.4.9
Message-Id: <20010915092001.08a7fe2a.matthias_haase@bennewitz.com>
In-Reply-To: <Pine.LNX.4.21.0109141824580.453-100000@tux.rsn.bth.se>
In-Reply-To: <20010914182325.225a7211.matthias_haase@bennewitz.com>
	<Pine.LNX.4.21.0109141824580.453-100000@tux.rsn.bth.se>
X-Operating-System: linux smp kernel 2.4* on i686
X-Mailer: Sylpheed
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 14 Sep 2001 18:26:04 +0200 (CEST)
Martin Josefsson <gandalf@wlug.westbo.se> wrote:

> I don't think it sounds that stupid.. but if it had hung you wouldn't
> have
> known if it was the possible interupthandeling bug or some oghet bug in
> DRI/DRM :)
Yes, but I now (relative) sure, that's ram-timing (it's DDR-RAM on 266
mHz) and cpu-clock are right.

Have found last night, that the box lockup too, if I use the scanner and
scanning a large file.
For scanning, I use an second additional SCSI-Controller (Dawicontrol,
based on AMD 53c974 [PCscsi]). The preview scan is o.k., but the scan
itself stops (and lockup hard the machine of course), if 4-5 mb are
transfered.

Sounds like an interrupt handling error?

> I'm going to start my tests here soon.
> 
> /Martin

Please let me known about your results.

regards

                          Matthias

-- 
Gruesse


Matthias Haase            | Telefon +49-(0)3733-23713
Markt 2                   | Telefax +49-(0)3733-22660
                          |
D-09456 Annaberg-Buchholz | http://www.bennewitz.com

