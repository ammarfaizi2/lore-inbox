Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263295AbUEGI64@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263295AbUEGI64 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 May 2004 04:58:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263370AbUEGI64
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 May 2004 04:58:56 -0400
Received: from ns.tasking.nl ([195.193.207.2]:61964 "EHLO ns.tasking.nl")
	by vger.kernel.org with ESMTP id S263295AbUEGI6y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 May 2004 04:58:54 -0400
To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
X-Newsreader: knews 1.0b.1
Reply-To: dick.streefland@altium.nl (Dick Streefland)
Organization: Altium BV
X-Face: "`*@3nW;mP[=Z(!`?W;}cn~3M5O_/vMjX&Pe!o7y?xi@;wnA&Tvx&kjv'N\P&&5Xqf{2CaT 9HXfUFg}Y/TT^?G1j26Qr[TZY%v-1A<3?zpTYD5E759Q?lEoR*U1oj[.9\yg_o.~O.$wj:t(B+Q_?D XX57?U,#b,iM$[zX'I(!'VCQM)N)x~knSj>M*@l}y9(tK\rYwdv%~+&*jV"epphm>|q~?ys:g:K#R" 2PuAzy-N9cKM<Ml/%yPQxpq"Ttm{GzBn-*:;619QM2HLuRX4]~361+,[uFp6f"JF5R`y
References: <409B4494.5253316B@melbourne.sgi.com> <013001c4340d$e9860470$d50110ac@sbp.uptime.at>
From: spam@altium.nl (Dick Streefland)
Subject: Re: Strange Linux behaviour!?
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Host: 172.17.1.66
Message-ID: <4548.409b4f94.a95cd@altium.nl>
Date: Fri, 07 May 2004 08:57:56 -0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[Posted and mailed]

"Oliver Pitzeier" <oliver@linux-kernel.at> wrote:
| We have a machine with five partitions mounted. One of those partitions
| is /usr. We can created files on /usr, but we cannot created
| directories. mkdir says, that there is no space left on device, but
| there actually IS space as you can see and files can be created, so why
| NO directories? Is it the kernel, is it the filesystem, is it the full
| moon high in the sky? :-) I have no clue, but maybe you have... Any
| help/idea is welcome!

You probably ran out of inodes. Check "df -i".

-- 
Dick Streefland                      ////                      Altium BV
dick.streefland@altium.nl           (@ @)          http://www.altium.com
--------------------------------oOO--(_)--OOo---------------------------

