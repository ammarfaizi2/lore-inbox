Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262289AbSJ0Fcp>; Sun, 27 Oct 2002 01:32:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262290AbSJ0Fcp>; Sun, 27 Oct 2002 01:32:45 -0400
Received: from whitsun.whitsunday.net.au ([203.25.188.10]:27407 "EHLO
	mail1.whitsunday.net.au") by vger.kernel.org with ESMTP
	id <S262289AbSJ0Fco> convert rfc822-to-8bit; Sun, 27 Oct 2002 01:32:44 -0400
From: John W Fort <johnf@whitsunday.net.au>
To: patmans@us.ibm.com
Cc: andmike@us.ibm.com, linux-kernel@vger.kernel.org
Subject: SCSI host changes, multi-path crap
Date: Sun, 27 Oct 2002 15:39:59 +1000
Message-ID: <jqumrucl0cu7i9vtr186d05difvcipdk0l@4ax.com>
X-Mailer: Forte Agent 1.92/32.572
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

HEY! andmike and patmans of @us.ibm.com YOU FUCKED UP.

For two weeks in a row you have submitted code that deliberately 
breaks scsi drivers.

Could you spell out your master plan for everyone who isn't using
IBfuckingM sanctioned hardware.

>From Patrick's proposed patches for lower level changes crap.
	
drivers/scsi/inia100.c: In function `inia100_biosparam':
drivers/scsi/inia100.c:661: structure has no member named `host'
drivers/scsi/inia100.c:662: structure has no member named `id'
drivers/scsi/inia100.c:659: warning: `pTcb' might be used uninitialized in
this function

There are more than 3 SCSI drivers in the linux kernel and you need to fix
all of them instead of fucking N-3 of them.

Given that 99% of Linux users will never know WTF multi-pathed SCSI hosts
are, shouldn't you adjust your code to reflect this.

I am starting to remember all the reasons I hated IBM people, but then
along came the Oracle people.

mumble, mumble, it will be fixed in the next release,
mumble, mumble, it will be fixed in the next release,
mumble, mumble, it will be fixed in the next release,
mumble, mumble, it will be fixed in the next release,
mumble, mumble, it will be fixed in the next release,

Patrick, should I mention that the ('-1\t' * 9) could be
('-1\t' * 5) in sg.c, but 'suck my cock' would work as well.

enough bile for today,
cu  johnf


