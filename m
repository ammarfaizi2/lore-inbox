Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266513AbUBDVLD (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Feb 2004 16:11:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266509AbUBDVKu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Feb 2004 16:10:50 -0500
Received: from moutng.kundenserver.de ([212.227.126.183]:50665 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S266513AbUBDVKL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Feb 2004 16:10:11 -0500
Subject: strange error messages with ide-cd in 2.6.2
From: Julien Langer <jlanger@zigweb.de>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Message-Id: <1075929005.1311.11.camel@moeff>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Wed, 04 Feb 2004 22:10:06 +0100
Content-Transfer-Encoding: 7bit
X-Provags-ID: kundenserver.de abuse@kundenserver.de auth:b0db08a687644468549cd788b9c03e48
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Since 2.6.2 I get the following messages every time when I load the
ide-cd module:

hdd: status error: status=0x59 { DriveReady SeekComplete DataRequest
Error }
hdd: status error: error=0x20LastFailedSense 0x02 
hdd: drive not ready for command
hdd: status error: status=0x58 { DriveReady SeekComplete DataRequest }
hdd: status error: error=0x00
hdd: drive not ready for command
hdd: status error: status=0x58 { DriveReady SeekComplete DataRequest }
hdd: status error: error=0x00
hdd: drive not ready for command
hdd: status error: status=0x58 { DriveReady SeekComplete DataRequest }
hdd: status error: error=0x00
hdd: drive not ready for command
hdd: ATAPI reset complete
.
.
.
hdd: ATAPI 40X CD-ROM CD-R/RW drive, 2048kB Cache

These error messages repeat ca 10 times

What's wrong there? I didn't get these messages with 2.6.1.
My IDE controller is a VIA vt82c686a

Please CC me, I'm not on the list.

Thanks in advance
Julien Langer

