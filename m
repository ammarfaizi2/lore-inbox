Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266708AbUFYK6P@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266708AbUFYK6P (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Jun 2004 06:58:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266357AbUFYK6P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Jun 2004 06:58:15 -0400
Received: from disk.smurf.noris.de ([192.109.102.53]:18324 "EHLO
	server.smurf.noris.de") by vger.kernel.org with ESMTP
	id S266709AbUFYK6N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Jun 2004 06:58:13 -0400
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: Matthias Urlichs <smurf@smurf.noris.de>
Newsgroups: smurf.list.linux.kernel
Subject: Re: 2.6.7 and khelper
Date: Fri, 25 Jun 2004 12:56:09 +0200
Organization: {M:U} IT Consulting
Message-ID: <pan.2004.06.25.10.56.09.276622@smurf.noris.de>
References: <40DB76F1.9010107@tequila.co.jp> <20040624184749.008358b0.akpm@osdl.org>
NNTP-Posting-Host: kiste.smurf.noris.de
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Trace: server.smurf.noris.de 1088160969 27098 192.109.102.35 (25 Jun 2004 10:56:09 GMT)
X-Complaints-To: smurf@noris.de
NNTP-Posting-Date: Fri, 25 Jun 2004 10:56:09 +0000 (UTC)
User-Agent: Pan/0.14.2.91 (As She Crawled Across the Table)
X-Face: '&-&kxR\8+Pqalw@VzN\p?]]eIYwRDxvrwEM<aSTmd'\`f#k`zKY&P_QuRa4EG?;#/TJ](:XL6B!-=9nyC9o<xEx;trRsW8nSda=-b|;BKZ=W4:TO$~j8RmGVMm-}8w.1cEY$X<B2+(x\yW1]Cn}b:1b<$;_?1%QKcvOFonK.7l[cos~O]<Abu4f8nbL15$"1W}y"5\)tQ1{HRR?t015QK&v4j`WaOue^'I)0d,{v*N1O
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Andrew Morton wrote:

>> I have a Debian/unstable box here (the same one that has these "fast
>> clock problems with 2.6.7-mm1) and every night after the syslog restart
>> the process with the id "4", which is khelper is reported to be
>> respawning to fast.
> 
> Strange.  I assume that what's happening is that the children of khelper
> are being created and are dying,

Umm, that ID refers to /etc/inittab, not to the process ID.

-- 
Matthias Urlichs
