Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313083AbSEPOHr>; Thu, 16 May 2002 10:07:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313118AbSEPOHq>; Thu, 16 May 2002 10:07:46 -0400
Received: from krusty.dt.E-Technik.Uni-Dortmund.DE ([129.217.163.1]:18442 "EHLO
	mail.dt.e-technik.uni-dortmund.de") by vger.kernel.org with ESMTP
	id <S313083AbSEPOHo>; Thu, 16 May 2002 10:07:44 -0400
Date: Thu, 16 May 2002 16:07:38 +0200
From: Matthias Andree <matthias.andree@gmx.de>
To: Linux-Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Changelogs and Bitkeeper: lk-changelog.pl v0.7 released
Message-ID: <20020516140738.GA6554@merlin.emma.line.org>
Mail-Followup-To: Linux-Kernel mailing list <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.99i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----

Hello,

After catastrophic loss of my lk-changelog.pl work of Tuesday (my XEmacs
VC wasn't careful when checking out and I forgot to check things in
before pressing C-x C-q), I have now merged (again) some of the works of
Marcus Alanen and Tomas Szepe, but dropped others because I found it was
to Perl-ish (write once and never touch again). I hope the current works
are more maintainable.

My current lk-changelog.pl version does not implement the single-line
modes yet (like Alan uses them for his 2.2.21rc logs), I will do that
later.

I dropped the 0.9x version tags because we are not that far yet. I think
it should have satisfied all common need before we stamp it "inclusion
candidate".

It does support reading arguments from environment, from command line.

It supports "full" and "grouped" mode.  "full" means full entries,
grouped by author "grouped" means first line, grouped by author.

The current version also ships with some built-in online help and word
wrapping feature and, in "grouped" mode, can compress identical log
entries.

I'm no longer attaching it uncompressed because it's too large.

To be found at:  http://mandree.home.pages.de/linux/kernel/

sha1sum:
dab1d784b628737fb452b3906e6652b742fc7507  lk-changelog-0.7.pl

Use uudeview or uudecode and then gunzip to get the program:
begin 644 lk-changelog.pl.gz
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
.TG:RM/8_J4LE,<LP````
`
end

- -- 
Matthias Andree
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iQCVAwUBPOO80CdEoB0mv1ypAQGJfAQAm9lciN37+ywoi5VPHsG5jADiD5AsZH5U
nmKYYTLjuBFPBnc4eFw4NVBUxsIf26+KyPVsL6/yTMDXaq/dTPQgV26cxZbz+0RV
+z1cV0G3dM1QlFoeLb9upB3f2aeH5IDgcegyA6LN3pP1MHe+aXP61L/RlAdgmbBN
aX+iTtRFrKI=
=ipl8
-----END PGP SIGNATURE-----
