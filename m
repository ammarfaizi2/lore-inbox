Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268340AbUJGWvd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268340AbUJGWvd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Oct 2004 18:51:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269852AbUJGWSo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Oct 2004 18:18:44 -0400
Received: from run.smurf.noris.de ([192.109.102.41]:7808 "EHLO
	server.smurf.noris.de") by vger.kernel.org with ESMTP
	id S269856AbUJGWRw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Oct 2004 18:17:52 -0400
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: Matthias Urlichs <smurf@smurf.noris.de>
Newsgroups: smurf.list.linux.kernel
Subject: Re: lsm: add bsdjail documentation
Date: Fri, 08 Oct 2004 00:17:09 +0200
Organization: {M:U} IT Consulting
Message-ID: <pan.2004.10.07.22.17.09.105723@smurf.noris.de>
References: <1097094103.6939.5.camel@serge.austin.ibm.com> <1097094358.6939.13.camel@serge.austin.ibm.com>
NNTP-Posting-Host: kiste.smurf.noris.de
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Trace: server.smurf.noris.de 1097187429 31272 192.109.102.35 (7 Oct 2004 22:17:09 GMT)
X-Complaints-To: smurf@noris.de
NNTP-Posting-Date: Thu, 7 Oct 2004 22:17:09 +0000 (UTC)
User-Agent: Pan/0.14.2.91 (As She Crawled Across the Table)
X-Face: '&-&kxR\8+Pqalw@VzN\p?]]eIYwRDxvrwEM<aSTmd'\`f#k`zKY&P_QuRa4EG?;#/TJ](:XL6B!-=9nyC9o<xEx;trRsW8nSda=-b|;BKZ=W4:TO$~j8RmGVMm-}8w.1cEY$X<B2+(x\yW1]Cn}b:1b<$;_?1%QKcvOFonK.7l[cos~O]<Abu4f8nbL15$"1W}y"5\)tQ1{HRR?t015QK&v4j`WaOue^'I)0d,{v*N1O
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Serge Hallyn wrote:

> +       echo -n "ip 2.2.2.2" > /proc/$$/attr/exec (optional)

Please use RFC private addresses in example code.

That being said, bsdjail is a very good idea (which is why we're stealing
it from BSD after all ...). It affords lightweight compartmentalization,
in other words a chroot-on-steroids, which is exactly what I need to split
one box into a couple of mostly-independent realms, and I assume that many
ISP/ASP/whatever hosting people will agree.

Anyway, that's my vote for adding it to the kernel.

-- 
Matthias Urlichs
