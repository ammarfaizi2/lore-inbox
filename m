Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261561AbRF2Vdo>; Fri, 29 Jun 2001 17:33:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261562AbRF2Vdd>; Fri, 29 Jun 2001 17:33:33 -0400
Received: from datafoundation.com ([209.150.125.194]:22801 "EHLO
	datafoundation.com") by vger.kernel.org with ESMTP
	id <S261561AbRF2Vd2>; Fri, 29 Jun 2001 17:33:28 -0400
Date: Fri, 29 Jun 2001 17:33:26 -0400 (EDT)
From: Dmitry Meshchaninov <dima@flash.datafoundation.com>
To: <linux-kernel@vger.kernel.org>
cc: <torvalds@transmeta.com>, <alan@lxorguk.ukuu.org.uk>, <cwl@iol.unh.edu>,
        Denis Gerasimov <denis@datafoundation.com>
Subject: qlogicfc driver
Message-ID: <Pine.LNX.4.30.0106291714470.11344-100000@flash.datafoundation.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  Hi!
  Judging from recent messages on linux-kernel and from the code which is
currently in 2.4.x the qlogicfc driver needs to be updated a bit. I have
done some amount of work on this driver and have sent patches to
Chris in the past, however I did not receive any comments on my changes.
It looks like Chris is too busy with other things right now, and I will
gladly maintain the driver if there is a consensus that the driver needs
a new maintainer. Meanwhile I am cleaning up driver for 2.4.4
(not tested with 2.4.5 yet, but probably will work). I'll publish those
changes if there will be any interest.  It is a  drop-in replacement for
the five files in drivers/scsi/ (qlogicfc.c, qlogicfc.h, qlogicfc_inc.h,
qlogicfc_asm_ip.c and qlogicfc_asm.c).  This contains updated (both with
and without ip support) firmware and many bugfixes. I decided not to
provide a patch because it is bigger then just those five files combind.
I have splitted up driver body into .h-file with types&defines  and
driver itself (as it should be). But this is negotiable.

Sincerely,
Dmitry Meshchaninov
software engineer
DataFoundation Inc

