Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261740AbVBOO41@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261740AbVBOO41 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Feb 2005 09:56:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261743AbVBOO41
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Feb 2005 09:56:27 -0500
Received: from mail.charite.de ([160.45.207.131]:51607 "EHLO mail.charite.de")
	by vger.kernel.org with ESMTP id S261740AbVBOO4Y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Feb 2005 09:56:24 -0500
Date: Tue, 15 Feb 2005 15:56:18 +0100
From: Ralf Hildebrandt <Ralf.Hildebrandt@charite.de>
To: linux-kernel@vger.kernel.org
Subject: Oops in 2.6.10-ac12 in kjournald (journal_commit_transaction)
Message-ID: <20050215145618.GP24211@charite.de>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Today our mailserver froze after just one day of uptime. I was able to
capture the Oops on the screen using my digital camera:

http://www.stahl.bau.tu-bs.de/~hildeb/bugreport/

Keywords: EIP is at journal_commit_transaction, process kjournald

# mount
/dev/cciss/c0d0p6 on / type ext3 (rw,errors=remount-ro)
proc on /proc type proc (rw)
sysfs on /sys type sysfs (rw)
devpts on /dev/pts type devpts (rw,gid=5,mode=620)
tmpfs on /dev/shm type tmpfs (rw)
/dev/cciss/c0d0p5 on /boot type ext3 (rw)
/dev/shm on /var/amavis type tmpfs (rw,noatime,size=200m,mode=770,uid=104,gid=108)

-- 
Ralf Hildebrandt (i.A. des IT-Zentrum)          Ralf.Hildebrandt@charite.de
Charite - Universitätsmedizin Berlin            Tel.  +49 (0)30-450 570-155
Gemeinsame Einrichtung von FU- und HU-Berlin    Fax.  +49 (0)30-450 570-962
IT-Zentrum Standort CBF                 send no mail to spamtrap@charite.de
