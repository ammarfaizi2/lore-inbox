Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266833AbUJNQ5l@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266833AbUJNQ5l (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Oct 2004 12:57:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266835AbUJNQ5l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Oct 2004 12:57:41 -0400
Received: from run.smurf.noris.de ([192.109.102.41]:46491 "EHLO
	server.smurf.noris.de") by vger.kernel.org with ESMTP
	id S266833AbUJNQ5g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Oct 2004 12:57:36 -0400
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: Matthias Urlichs <smurf@smurf.noris.de>
Newsgroups: smurf.list.linux.kernel
Subject: Re: 4level page tables for Linux II
Date: Thu, 14 Oct 2004 18:57:24 +0200
Organization: {M:U} IT Consulting
Message-ID: <pan.2004.10.14.16.57.23.884792@smurf.noris.de>
References: <1097638599.2673.9668.camel@cube> <20041013092221.471f7232.ak@suse.de>
NNTP-Posting-Host: kiste.smurf.noris.de
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Trace: server.smurf.noris.de 1097773044 9955 192.109.102.35 (14 Oct 2004 16:57:24 GMT)
X-Complaints-To: smurf@noris.de
NNTP-Posting-Date: Thu, 14 Oct 2004 16:57:24 +0000 (UTC)
User-Agent: Pan/0.14.2.91 (As She Crawled Across the Table)
X-Face: '&-&kxR\8+Pqalw@VzN\p?]]eIYwRDxvrwEM<aSTmd'\`f#k`zKY&P_QuRa4EG?;#/TJ](:XL6B!-=9nyC9o<xEx;trRsW8nSda=-b|;BKZ=W4:TO$~j8RmGVMm-}8w.1cEY$X<B2+(x\yW1]Cn}b:1b<$;_?1%QKcvOFonK.7l[cos~O]<Abu4f8nbL15$"1W}y"5\)tQ1{HRR?t015QK&v4j`WaOue^'I)0d,{v*N1O
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Andi Kleen wrote:

> And when you cannot remember the few names for the level you 
> better shouldn't touch VM at all.

Disagree. Rather strongly in fact.

It's probably OK if you already know the stuff and have been hacking
Linux' mm for years already, but if you try to learn how things work by
actually looking at the code..?

Just number them. Let pd1 point to pages, pd2 to pd1 entries, and so on.
(Level zero is the actual pages.)

-- 
Matthias Urlichs
