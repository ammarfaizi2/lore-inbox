Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274306AbRIYBGh>; Mon, 24 Sep 2001 21:06:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274309AbRIYBG1>; Mon, 24 Sep 2001 21:06:27 -0400
Received: from paloma12.e0k.nbg-hannover.de ([62.159.219.12]:54505 "HELO
	paloma12.e0k.nbg-hannover.de") by vger.kernel.org with SMTP
	id <S274306AbRIYBGS>; Mon, 24 Sep 2001 21:06:18 -0400
Content-Type: text/plain; charset=US-ASCII
From: Dieter =?iso-8859-1?q?N=FCtzel?= <Dieter.Nuetzel@hamburg.de>
Organization: DN
To: Dirk Mueller <dmuell@gmx.net>, ReiserFS List <reiserfs-list@namesys.com>,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        Linux SCSI List <linux-scsi@vger.kernel.org>
Subject: Re: URGENCY: IBM U160 SCSI disk spin-down from time to time
Date: Tue, 25 Sep 2001 03:06:08 +0200
X-Mailer: KMail [version 1.3.1]
Cc: Chris Mason <mason@suse.com>, Nikita Danilov <Nikita@namesys.com>,
        "Vladimir V. Saveliev" <vs@namesys.com>,
        Hans Reiser <reiser@namesys.com>, support@storage.ibm.com
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20010925010619Z274306-760+16463@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Dienstag, 24. September 2001 23:49 schrieb Dirk Mueller:
>
> > All spin-downs occur during heavy dbench (16/32/+ clients) on the same 
> > partition (/dev/sda8; the last one).
>
> Most likely the drive is overheating

Nope.
I've forgotten that info.

ALL three disks are actively cooled of there own.
Even the DDYS (10k RPM) is fewer than "handwarm".

> and is spinning down/up again to recalibrate itself.

NO, it _only_ restart and recalibrate during reboot (the AHA-2940UW BIOS 
detection routine).

> you should give it a better cooling ;-)

You're thinking about liquid nitrogen or sodium...;-)

-Dieter
