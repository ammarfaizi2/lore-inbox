Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261722AbTKANmH (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 Nov 2003 08:42:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263816AbTKANmH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 Nov 2003 08:42:07 -0500
Received: from ns.tasking.nl ([195.193.207.2]:21009 "EHLO ns.tasking.nl")
	by vger.kernel.org with ESMTP id S261722AbTKANmF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 Nov 2003 08:42:05 -0500
To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
X-Newsreader: knews 1.0b.1
Reply-To: dick.streefland@xs4all.nl (Dick Streefland)
Organization: none
X-Face: "`*@3nW;mP[=Z(!`?W;}cn~3M5O_/vMjX&Pe!o7y?xi@;wnA&Tvx&kjv'N\P&&5Xqf{2CaT 9HXfUFg}Y/TT^?G1j26Qr[TZY%v-1A<3?zpTYD5E759Q?lEoR*U1oj[.9\yg_o.~O.$wj:t(B+Q_?D XX57?U,#b,iM$[zX'I(!'VCQM)N)x~knSj>M*@l}y9(tK\rYwdv%~+&*jV"epphm>|q~?ys:g:K#R" 2PuAzy-N9cKM<Ml/%yPQxpq"Ttm{GzBn-*:;619QM2HLuRX4]~361+,[uFp6f"JF5R`y
References: <1067654148.19557.409.camel@up>
From: spam@streefland.xs4all.nl (Dick Streefland)
Subject: Re: md wierdness with 2.6.0test9
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Host: 172.17.1.66
Message-ID: <281b.3fa3b808.d7ab2@altium.nl>
Date: Sat, 01 Nov 2003 13:41:29 -0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Brad Langhorst <brad@langhorst.com> wrote:
| array syncs up but i see this wierdness (it exists across reboots)
| from mdadm --details /dev/md0
| 
| Number 	Major 	Minor 	RaidDevice	State
| 0	22	1	0		active sync /dev/hdc1
| 1	0	0	-1		removed
| 2	3	1	1		spare /dev/hda1
| 
| rebooting to a 2.4 series kernel appears to fix this problem...

Mmm, this looks familiar to me. See my email to linux-raid:

  http://www.spinics.net/lists/raid/msg03610.html

The patch in one of the replies fixed the problem for me.
However, this patch hasn't been included in Linus' kernel yet.

-- 
Dick Streefland                    ////               De Bilt
dick.streefland@xs4all.nl         (@ @)       The Netherlands
------------------------------oOO--(_)--OOo------------------

