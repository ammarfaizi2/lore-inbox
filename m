Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264924AbRFZDLu>; Mon, 25 Jun 2001 23:11:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264925AbRFZDLk>; Mon, 25 Jun 2001 23:11:40 -0400
Received: from horus.its.uow.edu.au ([130.130.68.25]:60336 "EHLO
	horus.its.uow.edu.au") by vger.kernel.org with ESMTP
	id <S264924AbRFZDLc>; Mon, 25 Jun 2001 23:11:32 -0400
Message-ID: <3B37FD71.44158F33@uow.edu.au>
Date: Tue, 26 Jun 2001 13:11:45 +1000
From: Andrew Morton <andrewm@uow.edu.au>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.5 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: lkml <linux-kernel@vger.kernel.org>,
        "ext3-users@redhat.com" <ext3-users@redhat.com>
CC: "Stephen C. Tweedie" <sct@redhat.com>,
        Andreas Dilger <adilger@turbolinux.com>,
        "Peter J. Braam" <braam@clusterfilesystem.com>
Subject: ext3-2.4-0.0.8
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ext3 patches against kernels 2.4.5, 2.4.6-pre5 and 2.4.5-ac17 are
available at http://www.uow.edu.au/~andrewm/linux/ext3/

Almost all testing thus far has been against 2.4.5.  Known
problems in 0.0.8 are:

- A theoretical deadlock with quotas in -ac.  This is proving
  impossible to demonstrate, and will be fixed in 0.0.9.

- A fairly straightforward deadlock with quotas in 2.4.5[-pre].
  This will probably be fixed in 0.0.9 as a side-effect of the
  version 2 quota fix.

We wouldn't encourage people to put all their data on ext3,
destroy their backups and then play russian roulette with
power cords; however this software is in pretty good shape.

Please test, and send any problem reports to ext3-users@redhat.com

Thanks.

-
