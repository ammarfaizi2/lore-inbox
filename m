Return-Path: <linux-kernel-owner+w=401wt.eu-S932506AbWLSOlG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932506AbWLSOlG (ORCPT <rfc822;w@1wt.eu>);
	Tue, 19 Dec 2006 09:41:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932573AbWLSOlG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Dec 2006 09:41:06 -0500
Received: from ns2.tasking.nl ([195.193.207.10]:25931 "EHLO ns2.tasking.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932506AbWLSOlF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Dec 2006 09:41:05 -0500
X-Greylist: delayed 1481 seconds by postgrey-1.27 at vger.kernel.org; Tue, 19 Dec 2006 09:41:05 EST
To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
X-Newsreader: knews 1.0b.1
Reply-To: dick.streefland@altium.nl (Dick Streefland)
Organization: Altium BV
X-Face: "`*@3nW;mP[=Z(!`?W;}cn~3M5O_/vMjX&Pe!o7y?xi@;wnA&Tvx&kjv'N\P&&5Xqf{2CaT 9HXfUFg}Y/TT^?G1j26Qr[TZY%v-1A<3?zpTYD5E759Q?lEoR*U1oj[.9\yg_o.~O.$wj:t(B+Q_?D XX57?U,#b,iM$[zX'I(!'VCQM)N)x~knSj>M*@l}y9(tK\rYwdv%~+&*jV"epphm>|q~?ys:g:K#R" 2PuAzy-N9cKM<Ml/%yPQxpq"Ttm{GzBn-*:;619QM2HLuRX4]~361+,[uFp6f"JF5R`y
References: <em0pdq$r7o$2@sea.gmane.org> <em0pdq$r7o$2@sea.gmane.org> <4586DF1D.6040501@cfl.rr.com>
From: dick.streefland@altium.nl (Dick Streefland)
Subject: Re: Software RAID1 (with non-identical discs) performance
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Host: 172.17.1.66
Message-ID: <3960.4587f434.9e684@altium.nl>
Date: Tue, 19 Dec 2006 14:16:20 -0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Phillip Susi <psusi@cfl.rr.com> wrote:
| The entire concept of geometry is a a carryover from days gone by. 
| These days it is just a farse maintained for backwards compatibility. 
| You can put fdisk into sector mode with the 'u' command and create 
| partitions of any number of sectors you desire, regardless of the 
| perceived geometry.

An easy way to clone a partition table is:

  sfdisk -d /dev/sdX | sfdisk /dev/sdY

-- 
Dick Streefland                      ////                      Altium BV
dick.streefland@altium.nl           (@ @)          http://www.altium.com
--------------------------------oOO--(_)--OOo---------------------------

