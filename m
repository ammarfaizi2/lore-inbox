Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314034AbSDKMkU>; Thu, 11 Apr 2002 08:40:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314035AbSDKMkU>; Thu, 11 Apr 2002 08:40:20 -0400
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:32012 "EHLO
	Port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with ESMTP
	id <S314034AbSDKMkT>; Thu, 11 Apr 2002 08:40:19 -0400
Message-Id: <200204111236.g3BCaMX10247@Port.imtp.ilyichevsk.odessa.ua>
Content-Type: text/plain;
  charset="us-ascii"
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Reply-To: vda@port.imtp.ilyichevsk.odessa.ua
To: Jens Axboe <axboe@suse.de>, Martin Dalecki <martin@dalecki.de>,
        Vojtech Pavlik <vojtech@suse.cz>
Subject: New IDE code and DMA failures
Date: Thu, 11 Apr 2002 15:39:33 -0200
X-Mailer: KMail [version 1.3.2]
Cc: linux-kernel@vger.kernel.org
X-Chameleon-Return-To: vda@port.imtp.ilyichevsk.odessa.ua
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jens, Martin, Vojtech,

I have a flaky IDE subsystem in one box. Reads work fine,
writes sometimes don't work and hang either IDE/block device
sybsystem or entire box. For example, I dumped ~40 MB file to
the disk and now I have additional power led (i.e. hdd activity
led is constantly on) and a bunch of "D" state processes
(kupdated, mount, umount).

This is happening since I decided to try 2.5.7.
2.4.18 reported DMA failures and reverted to PIO.

I did send a detailed report of similar event with
ksymoopsed stack traces of hung prosesses to lkml.

Since you are working on IDE subsystem, I will be glad to
*retain* my flaky IDE setup and test future kernels
for correct operation in this failure mode.

Please inform me whenever you want me to test your patches.
--
vda
