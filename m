Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262604AbREVKKa>; Tue, 22 May 2001 06:10:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262605AbREVKKU>; Tue, 22 May 2001 06:10:20 -0400
Received: from mx0.gmx.net ([213.165.64.100]:24004 "HELO mx0.gmx.net")
	by vger.kernel.org with SMTP id <S262604AbREVKKG>;
	Tue, 22 May 2001 06:10:06 -0400
Date: Tue, 22 May 2001 12:06:52 +0200 (MEST)
From: Thomas Palm <palm4711@gmx.de>
To: Lorenzo Marcantonio <lomarcan@tin.it>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
In-Reply-To: <Pine.LNX.4.31.0105212209480.845-100000@eris.discordia.loc>
Subject: Re: your mail
X-Priority: 3 (Normal)
X-Authenticated-Sender: #0009482897@gmx.net
X-Authenticated-IP: [193.159.61.153]
Message-ID: <2567.990526012@www38.gmx.net>
X-Mailer: WWW-Mail 1.5 (Global Message Exchange)
X-Flags: 0001
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

1. The corrupted files have the same length but differ (I cannot say on what
bit-position)
2. I reproduced the problem while burning CD from SCSI-Disk to
SCSI-CD-Burner!!!
-> It´s definetly not a (single?) IDE-Problem

Burning CD (on slow 4x speed) seems to initialize many small transfers
(instead of a smooth stream)(same as copying many small files) on PCI/DMA wich
generate the same problems!!!



> On Mon, 21 May 2001, Thomas Palm wrote:
> 
> > there ist still file-corruption. I use an ASUS A7V133 (Revision 1.05,
> > including Sound + Raid). My tests:
> > 1st run of "diff -r srcdir destdir" -> no differs
> > 2nd run of "diff -r srcdir destdir" -> 2 files differ
> > 3rd run of "diff -r srcdir destdir" -> 1 file differs
> > 4th run of "diff -r srcdir destdir" -> 1 file differs
> > 5th run of "diff -r srcdir destdir" -> no differs
> 
> Could you check WHERE the file differ and WHERE the data come from ?
> 
> I've got the same mobo AND some nasty DAT tape corruption problems...
> (also, VERY rarely, on the CD burner). I've got all on SCSI, but if it's
> the DMA troubling us...
> 
> 				-- Lorenzo Marcantonio
> 
> 

-- 
Machen Sie Ihr Hobby zu Geld bei unserem Partner 1&1!
http://profiseller.de/info/index.php3?ac=OM.PS.PS003K00596T0409a

--
GMX - Die Kommunikationsplattform im Internet.
http://www.gmx.net

