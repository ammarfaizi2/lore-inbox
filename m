Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266573AbUHOKmP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266573AbUHOKmP (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Aug 2004 06:42:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266575AbUHOKmO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Aug 2004 06:42:14 -0400
Received: from out012pub.verizon.net ([206.46.170.137]:20156 "EHLO
	out012.verizon.net") by vger.kernel.org with ESMTP id S266573AbUHOKmN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Aug 2004 06:42:13 -0400
From: Gene Heskett <gene.heskett@verizon.net>
Reply-To: gene.heskett@verizon.net
Organization: Organization: None, detectable by casual observers
To: linux-kernel@vger.kernel.org
Subject: Re: Possible dcache BUG
Date: Sun, 15 Aug 2004 06:42:11 -0400
User-Agent: KMail/1.6.82
Cc: viro@parcelfarce.linux.theplanet.co.uk,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
References: <Pine.LNX.4.44.0408020911300.10100-100000@franklin.wrl.org> <200408150610.28139.gene.heskett@verizon.net> <20040815103743.GF12308@parcelfarce.linux.theplanet.co.uk>
In-Reply-To: <20040815103743.GF12308@parcelfarce.linux.theplanet.co.uk>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200408150642.12007.gene.heskett@verizon.net>
X-Authentication-Info: Submitted using SMTP AUTH at out012.verizon.net from [151.205.53.77] at Sun, 15 Aug 2004 05:42:12 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 15 August 2004 06:37, viro@parcelfarce.linux.theplanet.co.uk 
wrote:
>On Sun, Aug 15, 2004 at 06:10:28AM -0400, Gene Heskett wrote:
>> all in one line of text, its a bit hard to locate real duplicates.
>> But I think I see some right now!  Can this line be modified to
>> spit them out, one entry per line with all dups sorted to be
>> adjacent?
>
>Sure, just add \n in format here.  Sorry, hadn't noticed that...
>
>> >+	seq_printf(m, "%d:%d:%lu:%o",

Can do, assume it would then be seq_printf(m, "%d:%d:%lu:%o\n"?

-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
99.24% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com attorneys please note, additions to this message
by Gene Heskett are:
Copyright 2004 by Maurice Eugene Heskett, all rights reserved.
