Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263136AbTCLKaj>; Wed, 12 Mar 2003 05:30:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263138AbTCLKaj>; Wed, 12 Mar 2003 05:30:39 -0500
Received: from pop.gmx.de ([213.165.64.20]:8291 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id <S263136AbTCLKai> convert rfc822-to-8bit;
	Wed, 12 Mar 2003 05:30:38 -0500
Content-Type: text/plain; charset=US-ASCII
From: Torsten Foertsch <torsten.foertsch@gmx.net>
To: Christoph Hellwig <hch@infradead.org>
Subject: Re: [2.4.19] How to get the path name of a struct dentry
Date: Wed, 12 Mar 2003 11:38:27 +0100
User-Agent: KMail/1.4.3
Cc: linux-kernel@vger.kernel.org
References: <200303121033.08560.torsten.foertsch@gmx.net> <20030312101133.A9312@infradead.org>
In-Reply-To: <20030312101133.A9312@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200303121138.31387.torsten.foertsch@gmx.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Wednesday 12 March 2003 11:11, Christoph Hellwig wrote:
> On Wed, Mar 12, 2003 at 10:33:05AM +0100, Torsten Foertsch wrote:
> > Assuming I have got a particular (struct dentry*)dp, how can I get it's
> > full path name.
>
> You can't.  See d_path() for the information needed to get an absolute
> path.

Thanks, that helped.

Next question, is there a way to get the dentry and vfsmount of /? I mean not 
current->fs->root and current->fs->rootmnt. They can be chrooted. I mean the 
real /.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQE+bw4nwicyCTir8T4RAkc3AJ9W1k9rwLF44E5dVawOeePbNcf1pACfR/J7
giuLC13yRuO+z/wPLpCbtNs=
=UcIU
-----END PGP SIGNATURE-----
