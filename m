Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262079AbUF0MDS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262079AbUF0MDS (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Jun 2004 08:03:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262329AbUF0MDR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Jun 2004 08:03:17 -0400
Received: from disk.smurf.noris.de ([192.109.102.53]:28048 "EHLO
	server.smurf.noris.de") by vger.kernel.org with ESMTP
	id S262079AbUF0MDO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Jun 2004 08:03:14 -0400
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: Matthias Urlichs <smurf@smurf.noris.de>
Newsgroups: smurf.list.linux.kernel
Subject: Re: [parisc-linux] Re: [PATCH] Fix the cpumask rewrite
Date: Sun, 27 Jun 2004 14:00:03 +0200
Organization: {M:U} IT Consulting
Message-ID: <pan.2004.06.27.12.00.03.857572@smurf.noris.de>
References: <1088266111.1943.15.camel@mulgrave> <Pine.LNX.4.58.0406260924570.14449@ppc970.osdl.org> <20040626221802.GA12296@taniwha.stupidest.org> <Pine.LNX.4.58.0406261536590.16079@ppc970.osdl.org> <1088290477.3790.2.camel@localhost.localdomain> <20040627000541.GA13325@taniwha.stupidest.org>
NNTP-Posting-Host: kiste.smurf.noris.de
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Trace: server.smurf.noris.de 1088337604 30999 192.109.102.35 (27 Jun 2004 12:00:04 GMT)
X-Complaints-To: smurf@noris.de
NNTP-Posting-Date: Sun, 27 Jun 2004 12:00:04 +0000 (UTC)
User-Agent: Pan/0.14.2.91 (As She Crawled Across the Table)
X-Face: '&-&kxR\8+Pqalw@VzN\p?]]eIYwRDxvrwEM<aSTmd'\`f#k`zKY&P_QuRa4EG?;#/TJ](:XL6B!-=9nyC9o<xEx;trRsW8nSda=-b|;BKZ=W4:TO$~j8RmGVMm-}8w.1cEY$X<B2+(x\yW1]Cn}b:1b<$;_?1%QKcvOFonK.7l[cos~O]<Abu4f8nbL15$"1W}y"5\)tQ1{HRR?t015QK&v4j`WaOue^'I)0d,{v*N1O
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Chris Wedgwood wrote:

> On Sat, Jun 26, 2004 at 11:54:38PM +0100, Alan Cox wrote:
> 
>> For most uses jiffies should die. If drivers could not access jiffies
>> except by a (possibly trivial) helper then it would be a huge step
>> closer to being able to run embedded linux without a continually running
>> timer.
> 
> I'm all for that, except last I counted there are about 5000 users of
> jiffies.  What do you suggest as a replacement API?

<heretic>

#define jiffies __get_jiffies()

</heretic>

-- 
Matthias Urlichs

