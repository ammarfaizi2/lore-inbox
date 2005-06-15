Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261464AbVFOOpC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261464AbVFOOpC (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Jun 2005 10:45:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261519AbVFOOpC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Jun 2005 10:45:02 -0400
Received: from ns.tasking.nl ([195.193.207.2]:38601 "EHLO ns.tasking.nl")
	by vger.kernel.org with ESMTP id S261464AbVFOOji (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Jun 2005 10:39:38 -0400
To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
X-Newsreader: knews 1.0b.1
Reply-To: dick.streefland@altium.nl (Dick Streefland)
Organization: Altium BV
X-Face: "`*@3nW;mP[=Z(!`?W;}cn~3M5O_/vMjX&Pe!o7y?xi@;wnA&Tvx&kjv'N\P&&5Xqf{2CaT 9HXfUFg}Y/TT^?G1j26Qr[TZY%v-1A<3?zpTYD5E759Q?lEoR*U1oj[.9\yg_o.~O.$wj:t(B+Q_?D XX57?U,#b,iM$[zX'I(!'VCQM)N)x~knSj>M*@l}y9(tK\rYwdv%~+&*jV"epphm>|q~?ys:g:K#R" 2PuAzy-N9cKM<Ml/%yPQxpq"Ttm{GzBn-*:;619QM2HLuRX4]~361+,[uFp6f"JF5R`y
References: <200506100811.17631.swsnyder@insightbb.com> <200506100811.17631.swsnyder@insightbb.com> <20050610122105.GA13931@isilmar.linta.de>
From: dick.streefland@altium.nl (Dick Streefland)
Subject: Re: PCMCIA still advised as modules?
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Host: 172.17.1.66
Message-ID: <5d84.42b03d92.77955@altium.nl>
Date: Wed, 15 Jun 2005 14:39:14 -0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dominik Brodowski <linux@dominikbrodowski.net> wrote:
| At least from 2.6.13 on, it will be much easier if you have the PCMCIA
| "modules" built into the kernel, as you won't need userspace interaction any
| longer (except on old yenta_socket bridges during startup, but that's a
| different story). Therefore, I do not see any drawbacks to having the PCMCIA
| modules built into the kernel.

At least the aha152x_cs module cannot be compiled into the kernel,
the Kconfig file says: depends on m. Does anybody known what the
problem with this driver is?

-- 
Dick Streefland                      ////                      Altium BV
dick.streefland@altium.nl           (@ @)          http://www.altium.com
--------------------------------oOO--(_)--OOo---------------------------

