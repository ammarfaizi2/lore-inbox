Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262472AbSK0NPl>; Wed, 27 Nov 2002 08:15:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262480AbSK0NPl>; Wed, 27 Nov 2002 08:15:41 -0500
Received: from thebsh.namesys.com ([212.16.7.65]:55044 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP
	id <S262472AbSK0NPl>; Wed, 27 Nov 2002 08:15:41 -0500
From: Nikita Danilov <Nikita@Namesys.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15844.50995.61298.126680@laputa.namesys.com>
Date: Wed, 27 Nov 2002 16:22:59 +0300
X-PGP-Fingerprint: 43CE 9384 5A1D CD75 5087  A876 A1AA 84D0 CCAA AC92
X-PGP-Key-ID: CCAAAC92
X-PGP-Key-At: http://wwwkeys.pgp.net:11371/pks/lookup?op=get&search=0xCCAAAC92
To: Ed Tomlinson <tomlins@cam.org>
Cc: reiserfs-list@namesys.com, linux-kernel@vger.kernel.org
Subject: Re: Reiserfs fs corruption with 2.5.49 
In-Reply-To: <200211270810.06553.tomlins@cam.org>
References: <200211270810.06553.tomlins@cam.org>
X-Mailer: VM 7.07 under 21.5  (beta6) "bok choi" XEmacs Lucid
Emacs: because one operating system isn't enough.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ed Tomlinson writes:
 > Hi,
 > 
 > I am seeing reiserfs (3.6 r5 hash) fs corruption in 2.5.49
 > 
 > oscar% ls alsa*
 > zsh: no matches found: alsa*
 > oscar% ls mod*
 > alsa-driver-0.9+0beta4-4
 > oscar% rm "alsa-driver-0.9+0beta4-4"
 > rm: cannot remove `alsa-driver-0.9+0beta4-4': No such file or directory

This can be explained if you have file alsa-driver-0.9+0beta4-4 within
directory named modSOMETHING, right? Can you try 

$ ls -d ls mod*

?

 > 
 > The fs with the above error passed an reiserfsck (3.6.4) 2 and a half days 
 > ago (just before the last reboot) - when I had to do a rebuild tree after 
 > booting 2.5.49-mm1, which did oops.  Looks like the bug is not just in -mm1 
 > though.
 > 
 > 
 > What info can I gather before fixing this fs?
 > 
 > Ed Tomlinson
 > 

Nikita.
