Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265824AbRFYAgj>; Sun, 24 Jun 2001 20:36:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265822AbRFYAg3>; Sun, 24 Jun 2001 20:36:29 -0400
Received: from [12.36.4.15] ([12.36.4.15]:51188 "EHLO lydia")
	by vger.kernel.org with ESMTP id <S265819AbRFYAgO>;
	Sun, 24 Jun 2001 20:36:14 -0400
To: Guest section DW <dwguest@win.tue.nl>
Cc: linux-kernel@vger.kernel.org
Subject: broken 2.2 IDE CD-RW (was Re: plain 2.2.X: no ide CD-RW?)
In-Reply-To: <ut2hex7ej69.fsf@lydia.adaptive.net>
	<20010623183506.A23320@win.tue.nl>
From: somayaji@sprintmail.com (Anil B. Somayaji)
Date: 24 Jun 2001 18:36:01 -0600
In-Reply-To: <20010623183506.A23320@win.tue.nl> (Guest section DW's message of "Sat, 23 Jun 2001 18:35:06 +0200")
Message-ID: <ut21yo9e6q6.fsf_-_@lydia.adaptive.net>
User-Agent: Gnus/5.090003 (Oort Gnus v0.03) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Guest section DW <dwguest@win.tue.nl> writes:

> On Sat, Jun 23, 2001 at 01:42:38AM -0600, Anil B. Somayaji wrote:
> 
> > For a while now, I've been running a 2.4 kernel, but (for my research)
> > I need to now run a 2.2 kernel.  I was hoping to just run a stock
> > 2.2.19, but I've found that I can't use my CD-RW drive, either as a
> > plain IDE cdrom, or as a scsi-emulated one.  (I have ide-scsi, ide-cd,
> > and scsi all as modules.)
> > 
> > I have these problems with 2.2.1[7-9] & 2.2.20pre5.  However, if I add
> > one of the IDE patches, all is well.  2.4 kernels have never given me
> > these sorts of problems.
> 
> Probably easy to sort out if you tell us which ide patch (with URL)
> you apply to make it work.

Sorry, I was referring to the backport of the 2.4 IDE code to 2.2.
I'm currently using ide.2.2.19.05042001 successfully, which I got from:

  ftp://ftp.us.kernel.org:/pub/linux/kernel/people/hedrick/ide-2.2.19

I've used several similar patches, though.  Stock 2.4 kernels work
fine with my CD-RW as well; however, I've now discovered that plain
2.2 kernels do not.  This could easily be a long-standing problem,
probably at least a year old - I've only recently stumbled across it,
though.

Since I have a solution (use the 2.4 IDE backport), this isn't
critical; however, since many people still rely on 2.2, and I'd like
to use a stock 2.2 kernel if possible, I'm willing to spend some time
debugging this.

Thanks!

  --Anil

(A bit of background: Before I got my CD-RW drive last summer, I
bought an OnStream DI-30 drive.  This drive was then only supported on
2.2 with the 2.4 IDE backport, and so I've used this drive
successfully with 2.2.16 + 2.4 IDE patch, and a similar combination
since.  Since stock 2.2.19+ now support this drive through the osst
patch, I thought I'd try it out.  It does work, but at the cost of
losing my CD-RW.)

- -- 
Anil Somayaji (somayaji@sprintmail.com)
http://www.cs.unm.edu/~soma
+1 505 872 3150
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)

iEYEARECAAYFAjs2h2AACgkQXOpXEmNZ3SfOlwCfb+it3YQrmO2e9q14AZMhcdZo
M+0An3Mi8aoEkvjD5vhC3Hc6yaICrMDE
=cV6C
-----END PGP SIGNATURE-----
