Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267483AbUG2ROH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267483AbUG2ROH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jul 2004 13:14:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267479AbUG2ROF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jul 2004 13:14:05 -0400
Received: from run.smurf.noris.de ([192.109.102.41]:7872 "EHLO
	server.smurf.noris.de") by vger.kernel.org with ESMTP
	id S267481AbUG2RNO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jul 2004 13:13:14 -0400
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: Matthias Urlichs <smurf@smurf.noris.de>
Newsgroups: smurf.list.linux.kernel
Subject: Re: [Fastboot] Re: Announce: dumpfs v0.01 - common RAS output API
Date: Thu, 29 Jul 2004 19:12:28 +0200
Organization: {M:U} IT Consulting
Message-ID: <pan.2004.07.29.17.12.28.316565@smurf.noris.de>
References: <16734.1090513167@ocs3.ocs.com.au> <20040725235705.57b804cc.akpm@osdl.org> <m1r7qw7v9e.fsf@ebiederm.dsl.xmission.com> <200407280903.37860.jbarnes@engr.sgi.com> <25870000.1091042619@flay> <m14qnr7u7b.fsf@ebiederm.dsl.xmission.com> <20040728133337.06eb0fca.akpm@osdl.org> <1091044742.31698.3.camel@localhost.localdomain> <m1llh367s4.fsf@ebiederm.dsl.xmission.com> <20040728164457.732c2f1d.akpm@osdl.org>
NNTP-Posting-Host: kiste.smurf.noris.de
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Trace: server.smurf.noris.de 1091121149 21302 192.109.102.35 (29 Jul 2004 17:12:29 GMT)
X-Complaints-To: smurf@noris.de
NNTP-Posting-Date: Thu, 29 Jul 2004 17:12:29 +0000 (UTC)
User-Agent: Pan/0.14.2.91 (As She Crawled Across the Table)
X-Face: '&-&kxR\8+Pqalw@VzN\p?]]eIYwRDxvrwEM<aSTmd'\`f#k`zKY&P_QuRa4EG?;#/TJ](:XL6B!-=9nyC9o<xEx;trRsW8nSda=-b|;BKZ=W4:TO$~j8RmGVMm-}8w.1cEY$X<B2+(x\yW1]Cn}b:1b<$;_?1%QKcvOFonK.7l[cos~O]<Abu4f8nbL15$"1W}y"5\)tQ1{HRR?t015QK&v4j`WaOue^'I)0d,{v*N1O
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Andrew Morton wrote:

> We really want to get into the new kernel ASAP and clean stuff up from
> in there.

Besides: when I want a crash dump, I want to dump the system state as of
the moment it crashed and not as of $RANDOM_STUFF later, well-intentioned
or not.

Let's reset the devices to a known state from within that kernel. If it
can't do that for some reason, it should reboot the system through the
BIOS (which had better be able to do it), and we're no worse off than
before.

-- 
Matthias Urlichs
