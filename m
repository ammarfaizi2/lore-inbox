Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282654AbRLBBeY>; Sat, 1 Dec 2001 20:34:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282655AbRLBBeO>; Sat, 1 Dec 2001 20:34:14 -0500
Received: from AFontenayssB-103-1-2-9.abo.wanadoo.fr ([193.253.44.9]:60952
	"EHLO emeraude") by vger.kernel.org with ESMTP id <S282654AbRLBBeI>;
	Sat, 1 Dec 2001 20:34:08 -0500
Date: Sun, 2 Dec 2001 02:31:45 +0100
From: Stephane Jourdois <stephane@tuxfinder.org>
To: Jeff Merkey <jmerkey@timpanogas.org>
Cc: J Sloan <jjs@pobox.com>, Charles-Edouard Ruault <ce@ruault.com>,
        linux-kernel@vger.kernel.org
Subject: Re: File system Corruption with 2.4.16
Message-ID: <20011202023145.A1628@emeraude.kwisatz.net>
Reply-To: stephane@tuxfinder.org
In-Reply-To: <3C0954D5.6AA3532B@ruault.com> <3C09580F.5F323195@pobox.com> <3C095B0B.7EA478C1@ruault.com> <003601c17ac2$7a8dec10$f5976dcf@nwfs> <3C096DB3.204CE41C@pobox.com> <001e01c17acb$a44b69c0$f5976dcf@nwfs>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <001e01c17acb$a44b69c0$f5976dcf@nwfs>
User-Agent: Mutt/1.3.23i
X-Operating-System: Linux 2.4.17-pre2
X-Send-From: emeraude
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 01, 2001 at 05:52:39PM -0700, Jeff Merkey wrote:
> ----- Original Message ----- From: "J Sloan" <jjs@pobox.com>
> > Just to be positive, can you reproduce the problem without nwfs?
> Yes. The problem shows up on ext2 partitions only.
I destroyed a  hard  disk  yesterday  with  2.4.16,  using  ext3.  A  heavy load
(compiling The gimp and several other things)  and everything came bad, symlinks
didn't work... (for exemple ln -s linux-2.4.17-pre2  linux did a link from linux
to linux either using linux-2.4.17-pre2 and /usr/src/linux-2.4.17-pre2.
> I see this lockup when I have more than  one file system mounted at a time. It
> does not happen when only a single  volume (superblock) has been mounted, only
> with multiples. Ditto the ext2 corruption. It only shows up when more than one
> superblock is active.
I had only one partition mounted at the moment (/dev/hda1 on / type ext3)

Just in case : debian sid, gcc 2.95.4, everything up to date.


We're living in a dangerous world, since 2.4.10...

Ciao,

--
 ///  Stephane Jourdois        	/"\  ASCII RIBBON CAMPAIGN \\\
(((    Ingénieur développement 	\ /    AGAINST HTML MAIL    )))
 \\\   6, av. de la Belle Image	 X                         ///
  \\\  94440 Marolles en Brie  	/ \    +33 6 8643 3085    ///
