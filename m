Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318764AbSICMel>; Tue, 3 Sep 2002 08:34:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318768AbSICMel>; Tue, 3 Sep 2002 08:34:41 -0400
Received: from iris.mc.com ([192.233.16.119]:23682 "EHLO mc.com")
	by vger.kernel.org with ESMTP id <S318764AbSICMek>;
	Tue, 3 Sep 2002 08:34:40 -0400
Message-Id: <200209031237.IAA27024@mc.com>
Content-Type: text/plain; charset=US-ASCII
From: mbs <mbs@mc.com>
To: Andre Hedrick <andre@linux-ide.org>, Mike Isely <isely@pobox.com>
Subject: 2.4.20-pre4-ac1 trashed my system
Date: Tue, 3 Sep 2002 08:41:40 -0400
X-Mailer: KMail [version 1.3.1]
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.10.10208302313040.1033-100000@master.linux-ide.org>
In-Reply-To: <Pine.LNX.4.10.10208302313040.1033-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

it trashed mine also.

supermicro p4dp8-g2 mobo
2x 2.2 Xeon
e7500 chipset
wd400 40gb hd

2.4.20-pre4-ac2 + RML preempt patch (applied cleanly)

boot it and eveything runs fine for a short while, then I start getting "bad 
CRC" errors and "seek failure" errors.

I have had this problem with both ext2 and ext3

initially I thought it was a bad HD, so I installed a new one on a new cable 
and did a complete rh7.3 install ran for a while eith no problems then built 
the same kernel over again, rebooted into the new kernel and within seconds 
was having problems again.

2.4.19-rc3-ac4 +rml preempt has been dead stable, as has (so far) 2.4.29-ac4 
+rml and RH 2.4.18-3 and -5

I am not doing anything funky with hd setup, not even specifying idebus= 

this has happened with 40 and 80 wire cables.

if there is any additional info I can provide please let me know.
-- 
/**************************************************
**   Mark Salisbury       ||      mbs@mc.com     **
** If you would like to sponsor me for the       **
** Mass Getaway, a 150 mile bicycle ride to for  **
** MS, contact me to donate by cash or check or  **
** click the link below to donate by credit card **
**************************************************/
https://www.nationalmssociety.org/pledge/pledge.asp?participantid=86736
