Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263766AbRFRIXS>; Mon, 18 Jun 2001 04:23:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263780AbRFRIXI>; Mon, 18 Jun 2001 04:23:08 -0400
Received: from at18.tphys.uni-linz.ac.at ([140.78.103.18]:1540 "EHLO
	at18.tphys.uni-linz.ac.at") by vger.kernel.org with ESMTP
	id <S263766AbRFRIWw>; Mon, 18 Jun 2001 04:22:52 -0400
Content-Type: text/plain;
  charset="iso-8859-1"
From: Alexander Puchmayr <alexander.puchmayr@jk.uni-linz.ac.at>
Reply-To: alexander.puchmayr@jk.uni-linz.ac.at
Organization: University Linz, Austria
To: linux-kernel@vger.kernel.org
Subject: Memory leak in 2.4.5??
Date: Mon, 18 Jun 2001 10:22:15 +0200
X-Mailer: KMail [version 1.2]
MIME-Version: 1.0
Message-Id: <01061810221500.01280@at18>
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi folks!

When I try to copy large files (let say some iso-image or disk image) over 
the network (regardless if nfs, ftp, whatever), the system starts to swap 
until it stucks - RESET required.

It is impossible for me to get one large 300MB file to my local harddrive!!

Observations I made: 
* No process seems to allocate the memory, buffered/cached memory is very 
low. So I assume that the kernel "eats" the memory.

* I tried my tests with a 100 MBit card (3c905) and a 10 MBit card (rtl-8029 
based), and it appeared only with the 100MBps card.

The kernel I'm using is a vanilla 2.4.5 with knfsd-patch (from namesys).

Thanks
	Alexander Puchmayr

-- 
---
Alexander Puchmayr 
Institut für Theoretische Physik     Altenbergerstr. 69, A-4040 Linz
Johannes-Kepler Universitaet         Phone: ++43 732/2468-8633
A-4040 Linz, Austria                 Fax:   ++43 732/2468-8585
E-Mail: alexander.puchmayr@jk.uni-linz.ac.at


