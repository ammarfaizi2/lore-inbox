Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261772AbUCLLKu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Mar 2004 06:10:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261848AbUCLLKu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Mar 2004 06:10:50 -0500
Received: from disk.smurf.noris.de ([192.109.102.53]:3206 "EHLO
	server.smurf.noris.de") by vger.kernel.org with ESMTP
	id S261772AbUCLLKt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Mar 2004 06:10:49 -0500
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: Matthias Urlichs <smurf@smurf.noris.de>
Newsgroups: smurf.list.linux.kernel
Subject: Re: [PATCH] 2.6.4-rc2-mm1: vm-split-active-lists
Date: Fri, 12 Mar 2004 12:08:03 +0100
Organization: {M:U} IT Consulting
Message-ID: <pan.2004.03.12.11.08.02.700169@smurf.noris.de>
References: <404FACF4.3030601@cyberone.com.au> <200403111825.22674@WOLK> <40517E47.3010909@cyberone.com.au> <20040312012703.69f2bb9b.akpm@osdl.org>
NNTP-Posting-Host: kiste.smurf.noris.de
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Trace: server.smurf.noris.de 1079089683 22676 192.109.102.35 (12 Mar 2004 11:08:03 GMT)
X-Complaints-To: smurf@noris.de
NNTP-Posting-Date: Fri, 12 Mar 2004 11:08:03 +0000 (UTC)
User-Agent: Pan/0.14.2.91 (As She Crawled Across the Table)
X-Face: '&-&kxR\8+Pqalw@VzN\p?]]eIYwRDxvrwEM<aSTmd'\`f#k`zKY&P_QuRa4EG?;#/TJ](:XL6B!-=9nyC9o<xEx;trRsW8nSda=-b|;BKZ=W4:TO$~j8RmGVMm-}8w.1cEY$X<B2+(x\yW1]Cn}b:1b<$;_?1%QKcvOFonK.7l[cos~O]<Abu4f8nbL15$"1W}y"5\)tQ1{HRR?t015QK&v4j`WaOue^'I)0d,{v*N1O
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Andrew Morton wrote:

> That effect is to cause the whole world to be swapped out when people
> return to their machines in the morning.

The correct solution to this problem is "suspend-to-disk" --
if the machine isn't doing anything anyway, TURN IT OFF.

One slightly more practical solution from the "you-now-who gets angry
mails" POV anyway, would be to tie the reduced-rate scanning to the load
average -- if nothing at all happens, swap-out doesn't need to happen
either.

-- 
Matthias Urlichs
