Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262166AbREUTnu>; Mon, 21 May 2001 15:43:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262171AbREUTnk>; Mon, 21 May 2001 15:43:40 -0400
Received: from mx0.gmx.net ([213.165.64.100]:4854 "HELO mx0.gmx.net")
	by vger.kernel.org with SMTP id <S262166AbREUTnh>;
	Mon, 21 May 2001 15:43:37 -0400
Date: Mon, 21 May 2001 21:43:34 +0200 (MEST)
From: Thomas Palm <palm4711@gmx.de>
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
X-Priority: 3 (Normal)
X-Authenticated-Sender: #0009482897@gmx.net
X-Authenticated-IP: [62.155.159.178]
Message-ID: <19729.990474214@www36.gmx.net>
X-Mailer: WWW-Mail 1.5 (Global Message Exchange)
X-Flags: 0001
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-> moved from comp.os.linux.hardware:

Hi,

I still have problems with the VIA Apollo southbridge (Kernel 2.4.2 (Redhat
7.1) and Kernel 2.4.4).

In rare circumstances,
there ist still file-corruption. I use an ASUS A7V133 (Revision 1.05,
including Sound + Raid). My tests:

- copying 4 GB of CD-ISO-Files from Promise Secondary Master to Promise
Secondary Slave. After that "diff -r srcdir destdir". Test was
succesfull, no differs, even after 15 executions

-  (same test with small files)
copying 4GB of small files (50 to 500 KB) from Promise Secondary Master
to Promise Secondary Slave.
1st run of "diff -r srcdir destdir" -> no differs
2nd run of "diff -r srcdir destdir" -> 2 files differ
3rd run of "diff -r srcdir destdir" -> 1 file differs
4th run of "diff -r srcdir destdir" -> 1 file differs
5th run of "diff -r srcdir destdir" -> no differs

- I d did the same tests on the Promise Primary, same results. Also on
the the VIA Secondary but my feeling is that there are even more
corruptions.

I stripped the machine to the bone, PCI-VGA only, same results.

I cannot say for sure, but before I stripped my adaptec SCSI-Card, there
may even been "differs" after copying from SCSI-Disk to SCSI-Disk. Off
course I thought other parts of my Hardware was flacky (e.g. RAM...),
but I swapped everything: RAM from different manufacturers, IDE-Cables,
CPU (Duron 900 -> Duron 850), VGA-Card, I tried the most conservative
Setting in the A7V-Bios, Bios-Update 1003 -> 1004 -> 1004 beta3,
UDMA6->UDMA2 all to no avail.

Any hints?
 <TP>

Post a follow-up to this message

Message 2 in thread 
Von:Bobby D. Bryant (bdbryant@mail.utexas.edu)
Betrifft:Re: VIA Apollo Southbridge again 
Newsgroups:comp.os.linux.hardware
Datum:2001-05-20 09:45:08 PST 
 



Thomas Palm wrote:

> I still have problems with the VIA Apollo southbridge (Kernel 2.4.2
(Redhat 7.1) and Kernel 2.4.4).

There are known to be bugs in the VIA chipsets, but you might want to report
this to
linux-kernel@vger.kernel.org anyway.

Bobby Bryant
Austin, Texas




-- 
Machen Sie Ihr Hobby zu Geld bei unserem Partner 1&1!
http://profiseller.de/info/index.php3?ac=OM.PS.PS003K00596T0409a

--
GMX - Die Kommunikationsplattform im Internet.
http://www.gmx.net

