Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422993AbWBOGOJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422993AbWBOGOJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Feb 2006 01:14:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423002AbWBOGOI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Feb 2006 01:14:08 -0500
Received: from smtp114.sbc.mail.re2.yahoo.com ([68.142.229.91]:44392 "HELO
	smtp114.sbc.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S1422993AbWBOGOG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Feb 2006 01:14:06 -0500
Message-Id: <20060215060140.243794000.dtor_core@ameritech.net>
Date: Wed, 15 Feb 2006 01:01:40 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [GIT PATCH 0/6] Input update for 2.6.16
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please do a pull from:

	rsync://rsync.kernel.org/pub/scm/linux/kernel/git/dtor/input.git/
or
	master.kernel.org:/pub/scm/linux/kernel/git/dtor/input.git


Changelog:

    Input: kill remnants of 98kbd{,-io} and 98spkr (Arthur Othieno)
    Input: ads7846 - assorted updates (David Brownell)
    Input: ads7846 - convert to to dynamic input_dev allocation
    Input: trackpoint - enable devices connected to external port
    Input: logips2pp - add new signature (99) (Meelis Roos)
    Input: ixp4xx-beeper - fix compile error (Alessandro Zummo)

Diffstat:

 keyboard/Makefile     |    1 
 misc/Makefile         |    1 
 misc/ixp4xx-beeper.c  |    1 
 mouse/logips2pp.c     |    1 
 mouse/trackpoint.c    |   20 ++++--
 mouse/trackpoint.h    |    4 -
 serio/Makefile        |    1 
 touchscreen/ads7846.c |  149 ++++++++++++++++++++++++++++++--------------------
 8 files changed, 110 insertions(+), 68 deletions(-)

--
Dmitry

