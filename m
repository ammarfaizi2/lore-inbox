Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262361AbUFSB2R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262361AbUFSB2R (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jun 2004 21:28:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261582AbUFSB2R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jun 2004 21:28:17 -0400
Received: from disk.smurf.noris.de ([192.109.102.53]:41920 "EHLO
	server.smurf.noris.de") by vger.kernel.org with ESMTP
	id S262361AbUFSB2P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jun 2004 21:28:15 -0400
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: Matthias Urlichs <smurf@smurf.noris.de>
Newsgroups: smurf.list.linux.kernel
Subject: Re: [PATCH] Stop printk printing non-printable chars
Date: Sat, 19 Jun 2004 03:23:35 +0200
Organization: {M:U} IT Consulting
Message-ID: <pan.2004.06.19.01.23.34.471323@smurf.noris.de>
References: <20040618205355.GA5286@newtoncomputing.co.uk> <Pine.LNX.4.58.0406181407330.6178@ppc970.osdl.org> <Pine.LNX.4.56.0406190032290.17899@jjulnx.backbone.dif.dk>
NNTP-Posting-Host: kiste.smurf.noris.de
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Trace: server.smurf.noris.de 1087608215 21297 192.109.102.35 (19 Jun 2004 01:23:35 GMT)
X-Complaints-To: smurf@noris.de
NNTP-Posting-Date: Sat, 19 Jun 2004 01:23:35 +0000 (UTC)
User-Agent: Pan/0.14.2.91 (As She Crawled Across the Table)
X-Face: '&-&kxR\8+Pqalw@VzN\p?]]eIYwRDxvrwEM<aSTmd'\`f#k`zKY&P_QuRa4EG?;#/TJ](:XL6B!-=9nyC9o<xEx;trRsW8nSda=-b|;BKZ=W4:TO$~j8RmGVMm-}8w.1cEY$X<B2+(x\yW1]Cn}b:1b<$;_?1%QKcvOFonK.7l[cos~O]<Abu4f8nbL15$"1W}y"5\)tQ1{HRR?t015QK&v4j`WaOue^'I)0d,{v*N1O
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Jesper Juhl wrote:

> [ printing control characters as "meaningful" C escapes ]
> or am I not making sense?

No, you're not. ;-)

Reason: They're not intended to be meaningful. If the kernel prints them,
the reason isn't that somebody actually used an \a or \v in there, so
doing that isn't helpful. (Quick, what's the ASCII for \v?)

-- 
Matthias Urlichs
