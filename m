Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313172AbSC1Owc>; Thu, 28 Mar 2002 09:52:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313174AbSC1OwW>; Thu, 28 Mar 2002 09:52:22 -0500
Received: from thebsh.namesys.com ([212.16.7.65]:62473 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP
	id <S313172AbSC1OwD>; Thu, 28 Mar 2002 09:52:03 -0500
From: Nikita Danilov <Nikita@Namesys.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15523.11788.516552.132449@laputa.namesys.com>
Date: Thu, 28 Mar 2002 17:51:56 +0300
X-Fnord: +++ath
X-WebTV-Stationery: Standard; BGColor=black; TextColor=black
X-Message-Flag: Message text blocked: ADULT LANGUAGE/SITUATIONS
X-BeenThere: crackmonkey@crackmonkey.org
X-PGP-Fingerprint: 43CE 9384 5A1D CD75 5087  A876 A1AA 84D0 CCAA AC92
X-PGP-Key-ID: CCAAAC92
X-PGP-Key-At: http://wwwkeys.pgp.net:11371/pks/lookup?op=get&search=0xCCAAAC92
To: Alexander Viro <viro@math.psu.edu>
Cc: Nikita Danilov <Nikita@Namesys.COM>, Andrew Morton <akpm@zip.com.au>,
        lkml <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@transmeta.com>
Subject: Re: [patch] ext2_fill_super breakage
In-Reply-To: <Pine.GSO.4.21.0203280946230.24447-100000@weyl.math.psu.edu>
X-Mailer: VM 7.00 under 21.4 (patch 3) "Academic Rigor" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alexander Viro writes:
 > 
 > 
 > On Thu, 28 Mar 2002, Nikita Danilov wrote:
 > 
 > > Explicit initialization always leaves room for some "pad" field inserted
 > > by compiler for alignment to be left with garbage. This is more than
 > > just annoyance when structure is something that will be written to the
 > > disk. Reiserfs had such problems.
 > 
 > If your structure will be written on disk you'd better have full control
 > over alignment - otherwise you are risking incompatibilities between
 > platforms and compiler versions.

Yes, but such experience frequently is only gained after format is
already carved in stone^Wdisk.

 > 
 > 

Nikita.
