Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129167AbRBZWJh>; Mon, 26 Feb 2001 17:09:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129183AbRBZWJ1>; Mon, 26 Feb 2001 17:09:27 -0500
Received: from ns1.whiterose.net ([208.155.122.237]:61970 "HELO
	ns1.whiterose.net") by vger.kernel.org with SMTP id <S129167AbRBZWJJ>;
	Mon, 26 Feb 2001 17:09:09 -0500
Date: Mon, 26 Feb 2001 17:05:19 -0500 (EST)
From: M Sweger <mikesw@ns1.whiterose.net>
To: linux-kernel@vger.kernel.org
Subject: linux 2.2.19pre14 is marked as pre13, plus some config/other problems.
 (fwd)
Message-ID: <Pine.BSF.4.21.0102261704570.37304-100000@ns1.whiterose.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org




Alan,
    See below for a list of problems with the linux
    2.2.19pre14 patch. The errors should be apparent.
     I have a Dell optiplex 333mhz Intel with a 9gig SCSI
     card.

A). The version of the linux 2.2.19pre14 on 2.2.18
    is compiling and saying it is pre13. Thus the
    make file has the wrong version.

B). After doing "make menuconfig". The textboxes
    displayed for the menu options "Processor family"
    and "Maximum Physical memory" are displayed
    incorrectly (half missing). 
    If I move the keyboard cursor arrow up and down
    for each of the above menus, then the display is
    redrawn with all of the missing menu options, color
    and graphics. Note: I have libcurses v5.0beta1 which
    didn't have problems in linux 2.2.19pre5 or earlier.


C). Errors during "make dep". 
    note: I have md5sum from textutils v1.22.
    If my config file will help here, I can send it.


md5sum: MD5 check failed for 'isac.c'
md5sum: MD5 check failed for 'isdnl1.c'
md5sum: MD5 check failed for 'isdnl2.c'
md5sum: MD5 check failed for 'isdnl3.c'
md5sum: MD5 check failed for 'tei.c'
md5sum: MD5 check failed for 'callc.c'
md5sum: MD5 check failed for 'l3dss1.c'
md5sum: MD5 check failed for 'l3_1tr6.c'
md5sum: MD5 check failed for 'elsa.c'
md5sum: MD5 check failed for 'diva.c'
md5sum: MD5 check failed for 'sedlbauer.c'




