Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265455AbUFSKXW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265455AbUFSKXW (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Jun 2004 06:23:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265474AbUFSKXW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Jun 2004 06:23:22 -0400
Received: from disk.smurf.noris.de ([192.109.102.53]:58799 "EHLO
	server.smurf.noris.de") by vger.kernel.org with ESMTP
	id S265455AbUFSKXU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Jun 2004 06:23:20 -0400
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: Matthias Urlichs <smurf@smurf.noris.de>
Newsgroups: smurf.list.linux.kernel
Subject: Re: [PATCH] Stop printk printing non-printable chars
Date: Sat, 19 Jun 2004 12:20:44 +0200
Organization: {M:U} IT Consulting
Message-ID: <pan.2004.06.19.10.20.44.592230@smurf.noris.de>
References: <20040618205355.GA5286@newtoncomputing.co.uk> <Pine.LNX.4.58.0406181407330.6178@ppc970.osdl.org> <Pine.LNX.4.56.0406190032290.17899@jjulnx.backbone.dif.dk> <pan.2004.06.19.01.23.34.471323@smurf.noris.de> <Pine.LNX.4.56.0406190337110.17899@jjulnx.backbone.dif.dk>
NNTP-Posting-Host: kiste.smurf.noris.de
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Trace: server.smurf.noris.de 1087640444 23382 192.109.102.35 (19 Jun 2004 10:20:44 GMT)
X-Complaints-To: smurf@noris.de
NNTP-Posting-Date: Sat, 19 Jun 2004 10:20:44 +0000 (UTC)
User-Agent: Pan/0.14.2.91 (As She Crawled Across the Table)
X-Face: '&-&kxR\8+Pqalw@VzN\p?]]eIYwRDxvrwEM<aSTmd'\`f#k`zKY&P_QuRa4EG?;#/TJ](:XL6B!-=9nyC9o<xEx;trRsW8nSda=-b|;BKZ=W4:TO$~j8RmGVMm-}8w.1cEY$X<B2+(x\yW1]Cn}b:1b<$;_?1%QKcvOFonK.7l[cos~O]<Abu4f8nbL15$"1W}y"5\)tQ1{HRR?t015QK&v4j`WaOue^'I)0d,{v*N1O
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Jesper Juhl wrote:

> But I did not intend them to be
> printed as '"meaningful" C escapes', I meant "why filter out \v or \f,
> someone might find a clever use for them and they do no real harm
> otherwhise"...

On the console, from the kernel? No such use exists today.

IMHO: Filter them out. If (big IF, methinks) somebody thinks of something
that actually makes sense, they can add an exception.

-- 
Matthias Urlichs
