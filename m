Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313419AbSERRIO>; Sat, 18 May 2002 13:08:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313492AbSERRIN>; Sat, 18 May 2002 13:08:13 -0400
Received: from krusty.dt.E-Technik.Uni-Dortmund.DE ([129.217.163.1]:60941 "EHLO
	mail.dt.e-technik.uni-dortmund.de") by vger.kernel.org with ESMTP
	id <S313419AbSERRIM>; Sat, 18 May 2002 13:08:12 -0400
Date: Sat, 18 May 2002 19:08:06 +0200
From: Matthias Andree <matthias.andree@gmx.de>
To: Linux-Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Changelogs and Bitkeeper: lk-changelog.pl v0.12 released
Message-ID: <20020518170806.GA22055@merlin.emma.line.org>
Mail-Followup-To: Linux-Kernel mailing list <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.99i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----

Hello,

I am announcing a new development release of the lk-changelog.pl
ChangeLog formatting script. It's not yet complete, some bugs and
missing features remain, but I believe it meets all of Linus'
requirements.

The highlight is most certainly the "terse" mode which formats similar
to the 2.2.21rc-style ChangeLogs and the 2.5.16 ChangeLog summery Linus
sent to this list. Also, some dozens new addresses have been added to
the script.

As to the formatting bug with the "[ARM PATCH]" tag resulting in "[ARM
1110/1: ...]": this bug does not exist in either v0.7 or v0.12 of my
lk-changelog.pl script.

There is now a --swap option for terse mode that prepends the address to
the change rather than formatting the log first, then the address or
name.

Try: lk-changelog.pl --width=80 --mode=terse --count ChangeLog-2.5.1[56]

lk-changelog.pl v0.12 is available from
http://mandree.home.pages.de/linux/kernel/

sha1sum digests:
dab1d784b628737fb452b3906e6652b742fc7507  lk-changelog-0.7.pl
a20b0e33f29de29311a75a20343f7eea0b501298  lk-changelog-0.12.pl

Note the programs contain national characters in the ISO-8859-15 (or
ISO-8859-1, the currently used characters are identical in either one)
character set.

Here's the gzipped version, use uudecode or uudeview to extract and
gunzip to uncompress (I will stop posting this once gzip+uuencode
reaches 16 kByte):

begin 644 lk-changelog.pl.gz
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
A'MT!=+D9O=M,Y-T.+&HB>@U,V\Y4,*3WWYOY%DY14```
`
end

- -- 
Matthias Andree
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iQCVAwUBPOaKWydEoB0mv1ypAQFCWQP9GzQ6loOpn/0E0iy/al7ipV/H08ZMahWa
aJougM+DqT56BiFMKqqS7QD6k0OLE0c3RnziSZA8CrtxQ188sS/2OjkbbFj8NrFj
cSgo9PeoHLBv1PuDLyCCoYd1mkuBieGqauYgu82LwE7TraRVcobBfKhxFYh+MoXK
2zueZ/Jas5U=
=TN7f
-----END PGP SIGNATURE-----
