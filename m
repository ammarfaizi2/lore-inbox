Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289888AbSBFBCy>; Tue, 5 Feb 2002 20:02:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289889AbSBFBCo>; Tue, 5 Feb 2002 20:02:44 -0500
Received: from out006pub.verizon.net ([206.46.170.106]:8837 "EHLO
	out006.verizon.net") by vger.kernel.org with ESMTP
	id <S289888AbSBFBCe>; Tue, 5 Feb 2002 20:02:34 -0500
Date: Tue, 5 Feb 2002 19:59:57 -0500
From: Skip Ford <skip.ford@verizon.net>
To: linux-kernel@vger.kernel.org
Subject: Re: Warning, 2.5.3 eats filesystems
Mail-Followup-To: linux-kernel@vger.kernel.org
In-Reply-To: <20020205192826.GA112@elf.ucw.cz> <878za7wmg0.fsf@inanna.rimspace.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <878za7wmg0.fsf@inanna.rimspace.net>; from daniel@rimspace.net on Wed, Feb 06, 2002 at 10:14:39AM +1100
Message-Id: <20020206010219.YXFM10804.out006.verizon.net@pool-141-150-235-204.delv.east.verizon.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Daniel Pittman wrote:
> On Tue, 5 Feb 2002, Pavel Machek wrote:
> > Hi!
> > 
> > 2.5.3 managed to damage my ext2 filesystem (few lost directories);
> > beware.
> 
> I can confirm that there are filesystem corruption issues with 2.5.3;
> after this message I rebooted and did a forced fsck which turned up
> around a half dozen inodes where the block count in the inode itself was
> too high.

I can confirm inode errors also.  However, I can't be sure it's 2.5.3 that
did it.

All of the errors I've had all seemed to be files included in the
pre-patch that broke Configure.help into pieces.  I don't know the code
well enough, but if the errors could only have happened at file creation
then that would rule out 2.5.3.

- -- 
Skip  ID: 0x7EDDDB0A
-----BEGIN PGP SIGNATURE-----

iEYEARECAAYFAjxgf/EACgkQBMKxVH7d2wppeACg3g9HDKuibe/u0rpFlU4u+xrb
pzAAoKfOKnvXJTzGYfUzs+/YeVDDVyMP
=UhON
-----END PGP SIGNATURE-----
