Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266284AbUHCONj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266284AbUHCONj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Aug 2004 10:13:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266486AbUHCONj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Aug 2004 10:13:39 -0400
Received: from ns.tasking.nl ([195.193.207.2]:49164 "EHLO ns.tasking.nl")
	by vger.kernel.org with ESMTP id S266284AbUHCONi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Aug 2004 10:13:38 -0400
To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
X-Newsreader: knews 1.0b.1
Reply-To: dick.streefland@altium.nl (Dick Streefland)
Organization: Altium BV
X-Face: "`*@3nW;mP[=Z(!`?W;}cn~3M5O_/vMjX&Pe!o7y?xi@;wnA&Tvx&kjv'N\P&&5Xqf{2CaT 9HXfUFg}Y/TT^?G1j26Qr[TZY%v-1A<3?zpTYD5E759Q?lEoR*U1oj[.9\yg_o.~O.$wj:t(B+Q_?D XX57?U,#b,iM$[zX'I(!'VCQM)N)x~knSj>M*@l}y9(tK\rYwdv%~+&*jV"epphm>|q~?ys:g:K#R" 2PuAzy-N9cKM<Ml/%yPQxpq"Ttm{GzBn-*:;619QM2HLuRX4]~361+,[uFp6f"JF5R`y
References: <410F481C.9090408@bio.ifi.lmu.de>
From: spam@altium.nl (Dick Streefland)
Subject: Re: NFS-mounted, read-only /dev unusable in 2.6
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Host: 172.17.1.66
Message-ID: <64bf.410f9d6f.62af@altium.nl>
Date: Tue, 03 Aug 2004 14:13:03 -0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Frank Steiner <fsteiner-mail@bio.ifi.lmu.de> wrote:
| Or is there any other way to get an initial console or
| output any messages from an init script if one boots via nfsroot
| and  / (and thus, /dev) is only exported read-only from the
| server?

You can boot with a ramdisk as root, initialized with an initrd, and
then perform all NFS mounts manually in the init script. You can use
pivot_root to switch to an NFS root to get rid of the ramdisk.

-- 
Dick Streefland                      ////                      Altium BV
dick.streefland@altium.nl           (@ @)          http://www.altium.com
--------------------------------oOO--(_)--OOo---------------------------

