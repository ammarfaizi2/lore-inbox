Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292087AbSCDHfX>; Mon, 4 Mar 2002 02:35:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292092AbSCDHfN>; Mon, 4 Mar 2002 02:35:13 -0500
Received: from basfegw1.basf-ag.de ([141.6.1.21]:57832 "EHLO
	basfegw1.basf-ag.de") by vger.kernel.org with ESMTP
	id <S292087AbSCDHfA>; Mon, 4 Mar 2002 02:35:00 -0500
Subject: Antwort: Re: Kernel Hangs 2.4.16 on heay io Oracle and Tivolie TSM
To: Alessandro Suardi <alessandro.suardi@oracle.com>, use-oracle@suse.com,
        suse-linux-e@suse.com, mason@suse.com, linux-kernel@vger.kernel.org
X-Mailer: Lotus Notes Version 5.0 (Intl)   14. April 1999
Message-ID: <OFE7517866.AA039B23-ONC1256B72.0027B52F@bcs.de>
From: Oliver.Schersand@BASF-IT-Services.com
Date: Mon, 4 Mar 2002 08:35:36 +0100
X-MIMETrack: Serialize by Router on EUROPE-Gw03/EUROPE/BASF(Release 5.0.8 |June 18, 2001) at
 04/03/2002 08:34:52
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

on saturday a had a nice day with 16 houre to find a workaround to bring
linux stable.
I had moved the server from reiserfs to ext2 for all datafile areas. The
move with tar
runs without any crash. I had an about 60 to 75 MB/second transfer ( read +
write) on the
move of the oracle datafiles.

After startup of oracle and backup the open datafiles ( i know this is
nonsens but its a good stress test)
i get a crash. On a reiserfs this would crash immediately. On ext2 crash
happend after about 2.5houres of backup ( about 80GB datafiles).
After this i switched backup to kernel version 2.2.19. ---> The system runs
now without crash.
On other server without oracle but which are have tsm backup we had no
problems with 2.4.16 ( at the moment  only about 15 Servers)

Its seems that you are right an we have a serious vm bug. This bug is only
viewable if you user oracle and tsm (tivoli storage manager) .... Strange.

Kinds regards

Oliver Schersand

