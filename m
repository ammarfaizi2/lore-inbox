Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262202AbVCBSeI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262202AbVCBSeI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Mar 2005 13:34:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262273AbVCBSeI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Mar 2005 13:34:08 -0500
Received: from hs-grafik.net ([80.237.205.72]:57068 "EHLO
	ds80-237-205-72.dedicated.hosteurope.de") by vger.kernel.org
	with ESMTP id S262202AbVCBSdI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Mar 2005 13:33:08 -0500
From: Alexander Gran <alex@zodiac.dnsalias.org>
To: linux-kernel@vger.kernel.org
Subject: 2.6.11-rc5-mm1 reiser4,USB,crpyto: Something BAD happend
Date: Wed, 2 Mar 2005 19:32:56 +0100
User-Agent: KMail/1.7.2
X-Need-Girlfriend: always
X-Ignorant-User: yes
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200503021932.56330@zodiac.zodiac.dnsalias.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

i''ve got an external USB 2.0 HDD. First 120GB Partition is AES encrypted 
reiser4. I just got LOADS of errors. syslogd is still writing them to disk. 
I have no idea whats happening here.
reiser4 paniced, usb told me "ehci_hcd 0000:00:1d.7: devpath 4 ep2out 
3strikes" and SCSI emulation had ioerrors.unmounting the reiser4 isn't 
possible, umount segfaults. Whatever happens here, we need - at least - lower 
the amount of log generatet. This is not really handy...
lsusb still lists the disk
syslog can be found (as soon as syslogd finished...;) at
http://zodiac.dnsalias.org/misc/crashlog
I have used swsp and suspend to ram some times before, if that matters.
Please tell me if you need additional log. 

regards
Alex

-- 
Encrypted Mails welcome.
PGP-Key at http://zodiac.dnsalias.org/misc/pgpkey.asc | Key-ID: 0x6D7DD291
