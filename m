Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264535AbUEJGOr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264535AbUEJGOr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 May 2004 02:14:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264537AbUEJGOr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 May 2004 02:14:47 -0400
Received: from disk.smurf.noris.de ([192.109.102.53]:5611 "EHLO
	server.smurf.noris.de") by vger.kernel.org with ESMTP
	id S264535AbUEJGOq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 May 2004 02:14:46 -0400
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: Matthias Urlichs <smurf@smurf.noris.de>
Newsgroups: smurf.list.linux.kernel
Subject: Re: get_cmos_time() takes up to a second on boot
Date: Mon, 10 May 2004 08:05:33 +0200
Organization: {M:U} IT Consulting
Message-ID: <pan.2004.05.10.06.05.33.308791@smurf.noris.de>
References: <409C2CBA.8040709@am.sony.com> <Pine.LNX.4.58.0405071908060.3271@ppc970.osdl.org>
NNTP-Posting-Host: kiste.smurf.noris.de
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Trace: server.smurf.noris.de 1084169133 29396 192.109.102.35 (10 May 2004 06:05:33 GMT)
X-Complaints-To: smurf@noris.de
NNTP-Posting-Date: Mon, 10 May 2004 06:05:33 +0000 (UTC)
User-Agent: Pan/0.14.2.91 (As She Crawled Across the Table)
X-Face: '&-&kxR\8+Pqalw@VzN\p?]]eIYwRDxvrwEM<aSTmd'\`f#k`zKY&P_QuRa4EG?;#/TJ](:XL6B!-=9nyC9o<xEx;trRsW8nSda=-b|;BKZ=W4:TO$~j8RmGVMm-}8w.1cEY$X<B2+(x\yW1]Cn}b:1b<$;_?1%QKcvOFonK.7l[cos~O]<Abu4f8nbL15$"1W}y"5\)tQ1{HRR?t015QK&v4j`WaOue^'I)0d,{v*N1O
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Linus Torvalds wrote:

> These days, I think we do the write-back only if we use an external clock 
> (NTP), so we probably _could_ just remove the synchronization at 
> read-time (removing it at write-time doesn't sound like a good idea).
> 
> Does anybody remember better?

No. ;-)   Do it.

-- 
Matthias Urlichs
