Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262245AbVAOIzS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262245AbVAOIzS (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 Jan 2005 03:55:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262246AbVAOIzS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 Jan 2005 03:55:18 -0500
Received: from main.gmane.org ([80.91.229.2]:63625 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S262245AbVAOIzN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 Jan 2005 03:55:13 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Pasi Savolainen <psavo@iki.fi>
Subject: Re: swapspace layout improvements advocacy
Date: Sat, 15 Jan 2005 08:55:08 +0000 (UTC)
Message-ID: <slrncuhmjb.19r.psavo@varg.dyndns.org>
References: <20050112123524.GA12843@lnx-holt.americas.sgi.com> <Pine.LNX.4.44.0501121758180.2765-100000@localhost.localdomain> <20050112105315.2ac21173.akpm@osdl.org> <Pine.LNX.4.53.0501141433000.7044@gockel.physik3.uni-rostock.de> <20050114225213.GA4841@ip68-4-98-123.oc.oc.cox.net>
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: a11a.mannikko1.ton.tut.fi
X-Face: $sk2zxhxVp'QPUj~kr+z:<m>#+84DO\Ab{4Hes1.P>]p=XhgsnwZM^[:"M?W#_x{W5[lu7i bqv7lOL`]5G%fH"Pgd5;+t"w)sOPDg::&T$Z9p#|xSMIb`$Udj6u14lh]imQ\z
User-Agent: slrn/0.9.8.1 (Debian)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Barry K. Nathan <barryn@pobox.com>:
> On Fri, Jan 14, 2005 at 02:55:27PM +0100, Tim Schmielau wrote:
>> 2.6 seems in due need of such a patch.
>> 
>> I recently found out that 2.6 kernels degrade horribly when going into 
>> swap. On my dual PIII-850 with as little as 256 mb ram, I can easily 
> [snip]
>
> I haven't tried the patch in question (unless it's in any Fedora
> kernels), but I've noticed that the single biggest step to improve
> swapping performance in 2.6 is to use the CFQ scheduler, not the AS
> scheduler. (That's also why Red Hat/Fedora kernels use CFQ as the
> default scheduler.)

I've not tried the patch yet, but with 1G mem / 1G swap when I finally
hit the swap and quit the program that uses it (straw, gimp..), machine
will stop responding for 10-15sec. 
I have 'elevator=cfq' in boot command and this is SMP. Last seen
yesterday when shutting down 2.6.10-rc2-mm4 to try out latest -mm.
I did vmstat runs a while ago, but didn't see anything really out of
line, maybe it didn't get data either (or I don't know what is normal).


-- 
   Psi -- <http://www.iki.fi/pasi.savolainen>

