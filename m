Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264992AbSKJSX1>; Sun, 10 Nov 2002 13:23:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265008AbSKJSX1>; Sun, 10 Nov 2002 13:23:27 -0500
Received: from fantomas.webnet.pl ([195.205.113.35]:37253 "EHLO
	fantomas.webnet.pl") by vger.kernel.org with ESMTP
	id <S264992AbSKJSX0>; Sun, 10 Nov 2002 13:23:26 -0500
Message-ID: <3DCEA5B2.5050609@wfmh.org.pl>
Date: Sun, 10 Nov 2002 19:30:10 +0100
From: Miloslaw Smyk <thorgal@wfmh.org.pl>
Organization: W.F.M.H.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3a) Gecko/20021109
X-Accept-Language: en-us, pl
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Serious HPT370 driver problem
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

I'd like to report a serious problem I've observed with versions of
drivers/ide/hpt366.c newer than 0.18, namely the boot process hanging when
trying to perform a "partition check" on a drive connected to HPT370.

My controller is HPT370 mounted on ABIT KT7A-RAID. I've two IBM
IC35L040AVER07-0 drives connected to it, which are recognized as hdf and hdh.

With version 0.18 of hpt366.c everything works flawlessly (I've been using
this config since March 2001). However, both 0.22 and 0.33 just stop when
trying to read partition info from hdf drive, which is the first one to be
accessed on HPT370.

I am not sure what other information you need to investigate this problem,
but I am ready to provide whatever is required. From my perspective the
problem is rather serious as I am unable to use kernels newer than 2.4.17.


Thank you and best regards,
Milek
-- 
mailto:thorgal@wfmh.org.pl    |  "Man in the Moon and other weird things" -
http://wfmh.org.pl/~thorgal/  |  see it at http://wfmh.org.pl/~thorgal/Moon/
         PLEASE UPDATE YOUR ADDRESS BOOK WITH MY NEW EMAIL ADDRESS.



