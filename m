Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129257AbQLDXKW>; Mon, 4 Dec 2000 18:10:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129845AbQLDXKC>; Mon, 4 Dec 2000 18:10:02 -0500
Received: from aragorn.ics.muni.cz ([147.251.4.33]:4343 "EHLO
	aragorn.ics.muni.cz") by vger.kernel.org with ESMTP
	id <S129257AbQLDXJv>; Mon, 4 Dec 2000 18:09:51 -0500
Newsgroups: cz.muni.redir.linux-kernel
Path: news
From: Zdenek Kabelac <kabi@fi.muni.cz>
Subject: NOSMP kernel option doesn't work
Message-ID: <3A2C1D16.5A6BBB33@fi.muni.cz>
Date: Mon, 4 Dec 2000 22:39:18 GMT
X-Nntp-Posting-Host: dual.fi.muni.cz
Content-Transfer-Encoding: 7bit
X-Accept-Language: Czech, en
Content-Type: text/plain; charset=iso-8859-2
Mime-Version: 1.0
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.0-test12 i686)
Organization: unknown
To: unlisted-recipients:; (no To-header on input)@pop.zip.com.au
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi


I would like to nosmp kernel option to be working again.
In my case (Bp6) machine gets frozed while 

hda: 40088160 sectors (20525 MB) w/1961KiB Cache, CHS=2495/255/63,
UDMA(33)
hdf: 60036480 sectors (30739 MB) w/1916KiB Cache, CHS=59560/16/63,
UDMA(66)
Partition check:
 /dev/ide/host0/bus0/target0/lun0: p1 p2 p3 < p5 p6 p7 p8 p9 >
 /dev/ide/host2/bus0/target1/lun0: hdf: lost interrupt


>>>>this should be there [PTBL] [3737/255/63] p1 p2 p4 < p5 p6 p7 p8 p9 >

Also I would say there are some big trabbles which are higlly visible
when transferring files from ext2 to vfat partions from UDMA66 to UDMA33
disc - so I assume interrupt handling is not correct....
(ok I know hpt366 is broken and bla bla bla, but....)



-- 
             There are three types of people in the world:
               those who can count, and those who can't.
  Zdenek Kabelac  http://i.am/kabi/ kabi@i.am {debian.org; fi.muni.cz}

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
