Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265149AbUBINlG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Feb 2004 08:41:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265203AbUBINlF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Feb 2004 08:41:05 -0500
Received: from disk.smurf.noris.de ([192.109.102.53]:41384 "EHLO
	server.smurf.noris.de") by vger.kernel.org with ESMTP
	id S265149AbUBINk6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Feb 2004 08:40:58 -0500
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: Matthias Urlichs <smurf@smurf.noris.de>
Newsgroups: smurf.list.linux.kernel
Subject: Re: UTF-8 in file systems? xfs/extfs/etc.
Date: Mon, 09 Feb 2004 14:36:24 +0100
Organization: {M:U} IT Consulting
Message-ID: <pan.2004.02.09.13.36.23.911729@smurf.noris.de>
References: <20040209115852.GB877@schottelius.org>
NNTP-Posting-Host: kiste.smurf.noris.de
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Trace: server.smurf.noris.de 1076333784 26630 192.109.102.35 (9 Feb 2004 13:36:24 GMT)
X-Complaints-To: smurf@noris.de
NNTP-Posting-Date: Mon, 9 Feb 2004 13:36:24 +0000 (UTC)
User-Agent: Pan/0.14.2.91 (As She Crawled Across the Table)
X-Face: '&-&kxR\8+Pqalw@VzN\p?]]eIYwRDxvrwEM<aSTmd'\`f#k`zKY&P_QuRa4EG?;#/TJ](:XL6B!-=9nyC9o<xEx;trRsW8nSda=-b|;BKZ=W4:TO$~j8RmGVMm-}8w.1cEY$X<B2+(x\yW1]Cn}b:1b<$;_?1%QKcvOFonK.7l[cos~O]<Abu4f8nbL15$"1W}y"5\)tQ1{HRR?t015QK&v4j`WaOue^'I)0d,{v*N1O
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Nico Schottelius wrote:

> What Linux supported filesystems support UTF-8 filenames?

Filenames, to the kernel, are a sequence of 8-bit things commonly
called "bytes" or "octets", excluding '/' and '\0'.

=> Answer: "All of them". (Or at least ext2/reiser ;-)

> Looks like at least xfs and reiserfs are not able of handling them, as
> Apache with UTF-8 as default charset delievers wrong names, when accessing
> files with German umlauts.

That's an Apache bug, and/or a problem with your Apache configuration.
Talk to Apache people.

-- 
Matthias Urlichs
