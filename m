Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263178AbTKYV0f (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Nov 2003 16:26:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263221AbTKYV0f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Nov 2003 16:26:35 -0500
Received: from ns.tasking.nl ([195.193.207.2]:23300 "EHLO ns.tasking.nl")
	by vger.kernel.org with ESMTP id S263178AbTKYV0d (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Nov 2003 16:26:33 -0500
To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
X-Newsreader: knews 1.0b.1
Reply-To: dick.streefland@altium.nl (Dick Streefland)
Organization: Altium BV
X-Face: "`*@3nW;mP[=Z(!`?W;}cn~3M5O_/vMjX&Pe!o7y?xi@;wnA&Tvx&kjv'N\P&&5Xqf{2CaT 9HXfUFg}Y/TT^?G1j26Qr[TZY%v-1A<3?zpTYD5E759Q?lEoR*U1oj[.9\yg_o.~O.$wj:t(B+Q_?D XX57?U,#b,iM$[zX'I(!'VCQM)N)x~knSj>M*@l}y9(tK\rYwdv%~+&*jV"epphm>|q~?ys:g:K#R" 2PuAzy-N9cKM<Ml/%yPQxpq"Ttm{GzBn-*:;619QM2HLuRX4]~361+,[uFp6f"JF5R`y
References: <50220000.1069784804@flay>
From: spam@altium.nl (Dick Streefland)
Subject: Re: [Bug 1589] New: 2.6.0-test10 (SMP) hangs at boot during SCSI initialization  (fwd)
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Host: 172.17.1.66
Message-ID: <6be.3fc3c8b6.b78c9@altium.nl>
Date: Tue, 25 Nov 2003 21:25:10 -0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Martin J. Bligh" <mbligh@aracnet.com> wrote:
| http://bugme.osdl.org/show_bug.cgi?id=1589
| 
|            Summary: 2.6.0-test10 (SMP) hangs at boot during SCSI
|                     initialization
|     Kernel Version: 2.6.10-test10
|             Status: NEW
|           Severity: normal
|              Owner: andmike@us.ibm.com
|          Submitter: bevdv@yahoo.com
..
| and then completely hangs, nothing but a reset will break out. I have heard a
| report that someone else had this problem and their kernel would boot after they
| recompiled without SMP support.  I will try that tomorrow, but it is late now. 
| 
| Oh, and I should mention that 2.6.0-test9 has been working without a hitch.

Does the following patch fix your problem?

  http://marc.theaimsgroup.com/?l=linux-scsi&m=106965748506343&w=2

-- 
Dick Streefland                      ////                      Altium BV
dick.streefland@altium.nl           (@ @)          http://www.altium.com
--------------------------------oOO--(_)--OOo---------------------------

