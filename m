Return-Path: <linux-kernel-owner+w=401wt.eu-S1752881AbWLSQLk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752881AbWLSQLk (ORCPT <rfc822;w@1wt.eu>);
	Tue, 19 Dec 2006 11:11:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753052AbWLSQLk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Dec 2006 11:11:40 -0500
Received: from ns2.tasking.nl ([195.193.207.10]:10603 "EHLO ns2.tasking.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753015AbWLSQLk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Dec 2006 11:11:40 -0500
To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
X-Newsreader: knews 1.0b.1
Reply-To: dick.streefland@altium.nl (Dick Streefland)
Organization: Altium BV
X-Face: "`*@3nW;mP[=Z(!`?W;}cn~3M5O_/vMjX&Pe!o7y?xi@;wnA&Tvx&kjv'N\P&&5Xqf{2CaT 9HXfUFg}Y/TT^?G1j26Qr[TZY%v-1A<3?zpTYD5E759Q?lEoR*U1oj[.9\yg_o.~O.$wj:t(B+Q_?D XX57?U,#b,iM$[zX'I(!'VCQM)N)x~knSj>M*@l}y9(tK\rYwdv%~+&*jV"epphm>|q~?ys:g:K#R" 2PuAzy-N9cKM<Ml/%yPQxpq"Ttm{GzBn-*:;619QM2HLuRX4]~361+,[uFp6f"JF5R`y
References: <em0pdq$r7o$2@sea.gmane.org> <4586DF1D.6040501@cfl.rr.com> <3960.4587f434.9e684@altium.nl> <em915v$7h6$1@sea.gmane.org>
From: dick.streefland@altium.nl (Dick Streefland)
Subject: Re: Software RAID1 (with non-identical discs) performance
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Host: 172.17.1.66
Message-ID: <6c86.45880f3a.481de@altium.nl>
Date: Tue, 19 Dec 2006 16:11:38 -0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Wiebe Cazemier <halfgaar@gmx.net> wrote:
| And with one Maxtor 250 GB and one Seagate 250 GB, will that work? It can go
| wrong on two accounts; the geometry issue I desbribed (which, I understand,
| shouldn't be an issue at all), and if you're trying to clone the partition
| table on a smaller disk. The latter would be fixed by leaving some unpartioned
| space available.

Yes, that's what I usually do. I lookup the size a couple of disks of
that size, and make sure that the last partition ends before the size
of the smallest disk, by leaving some cylinders unused.

-- 
Dick Streefland                      ////                      Altium BV
dick.streefland@altium.nl           (@ @)          http://www.altium.com
--------------------------------oOO--(_)--OOo---------------------------

