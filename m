Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261791AbUJYNC7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261791AbUJYNC7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Oct 2004 09:02:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261792AbUJYNC6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Oct 2004 09:02:58 -0400
Received: from run.smurf.noris.de ([192.109.102.41]:61406 "EHLO
	server.smurf.noris.de") by vger.kernel.org with ESMTP
	id S261791AbUJYNCb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Oct 2004 09:02:31 -0400
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: Matthias Urlichs <smurf@smurf.noris.de>
Newsgroups: smurf.list.linux.kernel
Subject: Re: BK kernel workflow
Date: Mon, 25 Oct 2004 15:01:50 +0200
Organization: {M:U} IT Consulting
Message-ID: <pan.2004.10.25.13.01.49.824742@smurf.noris.de>
References: <41752E53.8060103@pobox.com> <20041019153126.GG18939@work.bitmover.com> <41753B99.5090003@pobox.com> <4d8e3fd304101914332979f86a@mail.gmail.com> <20041019213803.GA6994@havoc.gtf.org> <4d8e3fd3041019145469f03527@mail.gmail.com> <20041019232710.GA10841@kroah.com>
NNTP-Posting-Host: kiste.smurf.noris.de
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Trace: server.smurf.noris.de 1098709310 8152 192.109.102.35 (25 Oct 2004 13:01:50 GMT)
X-Complaints-To: smurf@noris.de
NNTP-Posting-Date: Mon, 25 Oct 2004 13:01:50 +0000 (UTC)
User-Agent: Pan/0.14.2.91 (As She Crawled Across the Table)
X-Face: '&-&kxR\8+Pqalw@VzN\p?]]eIYwRDxvrwEM<aSTmd'\`f#k`zKY&P_QuRa4EG?;#/TJ](:XL6B!-=9nyC9o<xEx;trRsW8nSda=-b|;BKZ=W4:TO$~j8RmGVMm-}8w.1cEY$X<B2+(x\yW1]Cn}b:1b<$;_?1%QKcvOFonK.7l[cos~O]<Abu4f8nbL15$"1W}y"5\)tQ1{HRR?t015QK&v4j`WaOue^'I)0d,{v*N1O
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Greg KH wrote:

> On Tue, Oct 19, 2004 at 11:54:16PM +0200, Paolo Ciarrocchi wrote:
>> I know I'm pedantic but can we all see the list of bk trees ("patches
>> ready for mainstream" and "patches eventually ready for mainstream")
>> that we'll be used by Linus ?
> 
> The -mm releases has these as a big patch, starting with bk-*

Umm, yeah, but it's *one* big patch (or, if you use my -mm import tree
from bk://smurf.bkbits.net/linux-2.6.X-rcY-mmZ, one BK pull which has
that as a subtree).

Paolo wants to see two distinct ones.

Andrew also does things like

bk-netdev.patch
e1000-module_param-fix.patch
ne2k-pci-pci-build-fix.patch
r8169-module_param-fix.patch

which my mind translates as "there's something stupid, incomplete or
outdated in the bk-netdev tree", or "that tree's maintainer should apply
these patches. Now." (Ideally, of course, my import script should do the
same thing.)

-- 
Matthias Urlichs   |   {M:U} IT Design @ m-u-it.de   |  smurf@smurf.noris.de

