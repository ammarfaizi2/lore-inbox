Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135404AbRDMEyg>; Fri, 13 Apr 2001 00:54:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135405AbRDMEy0>; Fri, 13 Apr 2001 00:54:26 -0400
Received: from tomts7.bellnexxia.net ([209.226.175.40]:33216 "EHLO
	tomts7-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id <S135404AbRDMEyV>; Fri, 13 Apr 2001 00:54:21 -0400
Content-Type: text/plain; charset=US-ASCII
From: Ed Tomlinson <tomlins@cam.org>
Organization: me
To: linux-kernel@vger.kernel.org
Subject: [BUG] ide-tape is readonly here
Date: Fri, 13 Apr 2001 00:54:18 -0400
X-Mailer: KMail [version 1.2]
MIME-Version: 1.0
Message-Id: <01041300541802.06447@oscar>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Upgraded to ac5 tonight.  Problems with 8139too.o
caused a few crashes and scrambled a few files.
Restoring them was fun.  Seems that while ide-tape
can write to my 'HP Colorado 20G' drive, it gets
an I/O error when it trys to read...  If I flip to 
ide-scsi and friends (much slower for backups btw)
the restore works.

What is needed to debug this?

Ed Tomlinson <tomlins@cam.org>
