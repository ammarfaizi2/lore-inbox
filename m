Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262656AbTFXUcZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Jun 2003 16:32:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262687AbTFXUcZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Jun 2003 16:32:25 -0400
Received: from keetweej.xs4all.nl ([213.84.46.114]:44430 "EHLO
	muur.intranet.vanheusden.com") by vger.kernel.org with ESMTP
	id S262656AbTFXUcX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Jun 2003 16:32:23 -0400
From: Folkert van Heusden <folkert@vanheusden.com>
Reply-To: folkert@vanheusden.com
To: linux-kernel@vger.kernel.org
Subject: contents of a cd-rom disappearing and re-appearing! 2.4.21
Date: Tue, 24 Jun 2003 22:46:31 +0200
User-Agent: KMail/1.5.2
References: <UTC200306242031.h5OKVJL12231.aeb@smtp.cwi.nl>
In-Reply-To: <UTC200306242031.h5OKVJL12231.aeb@smtp.cwi.nl>
WebSite: http://www.vanheusden.com/
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200306242246.31826.folkert@vanheusden.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I had this really strange experience with a cd-rom.
I was in it's mountpoint, did ls, all fine.
Did nothing for a while, then did ls again: everything gone!
I then cd'd to home and back to the mountpoint and ls: everything's
back.
I never had this while running 2.4.20.

folkert@boemboem:/cdrom$ ls
folkert@boemboem:/cdrom$ mount
/dev/hda2 on / type ext3 (rw,errors=remount-ro)
proc on /proc type proc (rw)
devpts on /dev/pts type devpts (rw,gid=5,mode=620)
/dev/hdd on /cdrom type iso9660 (ro,uid=1000)
folkert@boemboem:/cdrom$ ls
folkert@boemboem:/cdrom$ cd
folkert@boemboem:~$ cd /cdrom/
folkert@boemboem:/cdrom$ ls
DATA1.MSI  MSI          PFILES      SETUP.EXE  SP   SYSTEM    SYSTEMNT  
autorun.inf  msowc.cab  setup.ini
IE5        OFFICE1.CAB  README.DOC  SETUP.HLP  SQL  SYSTEM95  WINDOWS   
license.txt  msowc.msi


Greetings,

Folkert van Heusden

+-> www.vanheusden.com       folkert@vanheusden.com       +31-6-41278122 <-+
+--------------------------------------------------------------------------+
| UNIX sysop? Then give MultiTail ( http://www.vanheusden.com/multitail/ ) |
| a try, it brings monitoring logfiles (and such) to a different level!    |
+--------------------------------------------------------------------------+

