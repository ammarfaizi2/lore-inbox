Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279321AbRKARLy>; Thu, 1 Nov 2001 12:11:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279377AbRKARLq>; Thu, 1 Nov 2001 12:11:46 -0500
Received: from mail.internet-factory.de ([195.122.142.5]:14304 "EHLO
	mail.internet-factory.de") by vger.kernel.org with ESMTP
	id <S279321AbRKARLd>; Thu, 1 Nov 2001 12:11:33 -0500
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: Holger Lubitz <h.lubitz@internet-factory.de>
Newsgroups: lists.linux.kernel
Subject: aic7xxx 6.2.1 unstable?
Date: Thu, 01 Nov 2001 18:11:32 +0100
Organization: Internet Factory AG
Message-ID: <3BE18244.9AB8A602@internet-factory.de>
NNTP-Posting-Host: bastille.internet-factory.de
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Trace: darkstar.internet-factory.de 1004634692 13296 195.122.142.158 (1 Nov 2001 17:11:32 GMT)
X-Complaints-To: usenet@internet-factory.de
NNTP-Posting-Date: 1 Nov 2001 17:11:32 GMT
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.13-ac5 i686)
X-Accept-Language: en
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi,

i came to work today to find out that our news & web proxy server, which
i updated from 2.4.8 to 2.4.13 a week ago, hung after a week of uptime.
the machine was locked solid, last kernel messages on the console seemed
to indicate a scsi problem.

the machine in question is a 440gx based p3 800 mhz with onboard adaptec
7896 controller (dual channel, one u2w, one uw).

the drives are ibm ddys (1x 9gb, 1x 18gb) connected to the u2w port.

the problem is similar to another problem which turned up when i first
tried the "new" adaptec driver with 2.4.2. i later updated to aic7xxx
6.1.5, but the problem remained, so i kept using the old driver.

when i switched to 2.4.5 with 6.1.13 included, i felt adventurous again.
and to my surprise, everything was fine. the machine has not shown a
single scsi error since then, using the new driver. i updated to 2.4.8
some time later, the machine continued to run fine.

so, after nearly half a year without problems, i was reluctant to update
the aic driver again, but was trying nevertheless because of the
security fixes in recent kernels, which i considered "nice to have".
however, version 6.2.1 of the adaptec driver seems to have broken the
setup once again. i'm back to 2.4.8 for now.

this is not meant as a real bug report, more like a word of warning,
because there's not enough evidence that aic7xxx is the only possible
suspect. however, given that the problems have not been there for half a
year and the messages indicated a scsi problem, i consider it the
primary one. since the machine is a production machine, i am unable to
run extensive tests, but if i can do anything else to assist, i'd be
glad to. 

holger
