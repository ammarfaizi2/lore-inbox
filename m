Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318630AbSIISLs>; Mon, 9 Sep 2002 14:11:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318722AbSIISLs>; Mon, 9 Sep 2002 14:11:48 -0400
Received: from out005pub.verizon.net ([206.46.170.143]:28138 "EHLO
	out005.verizon.net") by vger.kernel.org with ESMTP
	id <S318630AbSIISLA>; Mon, 9 Sep 2002 14:11:00 -0400
From: "Jeffrey J. Kosowsky" <jeff.kosowsky@verizon.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15740.58694.753733.167242@surgeon.pretender>
Date: Mon, 9 Sep 2002 14:15:34 -0400
To: linux-kernel@vger.kernel.org
Subject: XCdroast/cdrecord crashes kernel 2.4.18 when mastering on the fly
X-Mailer: VM 6.97 under Emacs 21.2.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


  When backing up a partition on the fly, XCdroast/cdrecord crashed (which is
  forgiveable) but it also crashed my Linux system (which is
  not). System and consoles were totally unresponsive, requiring a
  dreaded unclean reboot.

  Joerg schilling (maintainer of cdrecord) suggests problem is with Linux
  kernel and not with 'cdrecord'
  
  Any thoughts on what might be going on?
  
  Note that mastering-on-the-fly seemed to work OK if I just backed up a
  couple of very large tar files, while the crashes seem to occur when
  backing up a partition with multiple files. This difference is
  explained perhaps   by the extra overload of mastering multiple
  small files vs. a few large tar files.
  
  My system setup is as follows:
  * Brand new 24x10x40 Hi-Val CDR
  * CD recording software
    cdrtools-cdda2wav-1.11a23-1.i386.rpm
    cdrtools-mkisofs-1.11a23-1.i386.rpm
    cdrtools-cdrecord-1.11a23-1.i386.rpm  
    cdrtools-devel-1.11a23-1.i386.rpm
    xcdroast-0.98alpha10-1.i386.rpm
  * Relatively pristine RH 7.3 running kernel 2.4.18
  * System hardware is a bit old and slow (Pentium 200 MHz Overdrive
  in an old P100 Intel Aladding/Zappa PCI Motherboard)

  Even with the older system hardware, I would hope that we could get
  Xcdroast/cdrecord to at least die gracefully if things are too slow
  to master on-the-fly.

  Thanks,
  Jeff
