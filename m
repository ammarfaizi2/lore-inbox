Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261576AbVDURul@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261576AbVDURul (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Apr 2005 13:50:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261584AbVDURuV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Apr 2005 13:50:21 -0400
Received: from fire.osdl.org ([65.172.181.4]:9178 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261559AbVDURtu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Apr 2005 13:49:50 -0400
Date: Thu, 21 Apr 2005 10:39:57 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: davidm@hpl.hp.com
Cc: davidm@napali.hpl.hp.com, tony.luck@intel.com, akpm@osdl.org,
       Andreas.Hirstius@cern.ch, Bartlomiej.Zolnierkiewicz@cern.ch,
       gelato-technical@gelato.unsw.edu.au, linux-kernel@vger.kernel.org
Subject: Re: [Gelato-technical] Re: Serious performance degradation on a
 RAID with kernel 2.6.10-bk7 and later
Message-Id: <20050421103957.1f789c23.rddunlap@osdl.org>
In-Reply-To: <16999.58345.464613.343890@napali.hpl.hp.com>
References: <B8E391BBE9FE384DAA4C5C003888BE6F0350B393@scsmsx401.amr.corp.intel.com>
	<16999.58345.464613.343890@napali.hpl.hp.com>
Organization: OSDL
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Face: SvC&!/v_Hr`MvpQ*|}uez16KH[#EmO2Tn~(r-y+&Jb}?Zhn}c:Eee&zq`cMb_[5`tT(22ms
 (.P84,bq_GBdk@Kgplnrbj;Y`9IF`Q4;Iys|#3\?*[:ixU(UR.7qJT665DxUP%K}kC0j5,UI+"y-Sw
 mn?l6JGvyI^f~2sSJ8vd7s[/CDY]apD`a;s1Wf)K[,.|-yOLmBl0<axLBACB5o^ZAs#&m?e""k/2vP
 E#eG?=1oJ6}suhI%5o#svQ(LvGa=r
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 Apr 2005 10:33:29 -0700 David Mosberger wrote:

| >>>>> On Thu, 21 Apr 2005 10:19:28 -0700, "Luck, Tony" <tony.luck@intel.com> said:
| 
|   >> I just checked 2.6.12-rc3 and the fls() fix is indeed missing.
|   >> Do you know what happened?
| 
|   Tony> If BitKeeper were still in use, I'd have dropped that patch
|   Tony> into my "release" tree and asked Linus to "pull" ... but it's
|   Tony> not, and I was stalled.  I should have a "git" tree up and
|   Tony> running in the next couple of days.  I'll make sure that the
|   Tony> fls fix goes in early.
| 
| Yeah, I'm facing the same issue.  I started playing with git last
| night.  Apart from disk-space usage, it's very nice, though I really
| hope someone puts together a web-interface on top of git soon so we
| can seek what changed when and by whom.

2 people have already done that.  Examples:
http://ehlo.org/~kay/gitweb.pl
and
http://grmso.net:8090/

and the commits mailing list is now working.
A script to show nightly (or daily:) commits and make
a daily patch tarball is also close to ready.

---
~Randy
