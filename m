Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751945AbWFUDHZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751945AbWFUDHZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jun 2006 23:07:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751949AbWFUDHZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jun 2006 23:07:25 -0400
Received: from smtp.osdl.org ([65.172.181.4]:1714 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751945AbWFUDHY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jun 2006 23:07:24 -0400
Date: Tue, 20 Jun 2006 20:07:00 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Stefan Richter <stefanr@s5r6.in-berlin.de>
cc: Jody McIntyre <scjody@modernduck.com>, Andrew Morton <akpm@osdl.org>,
       linux1394-devel@lists.sourceforge.net,
       Ben Collins <bcollins@ubuntu.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [git pull] ieee1394 tree for 2.6.18
In-Reply-To: <4497D014.1050704@s5r6.in-berlin.de>
Message-ID: <Pine.LNX.4.64.0606202001520.5498@g5.osdl.org>
References: <44954102.3090901@s5r6.in-berlin.de> <Pine.LNX.4.64.0606191902350.5498@g5.osdl.org>
 <4497D014.1050704@s5r6.in-berlin.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 20 Jun 2006, Stefan Richter wrote:
> 
> Here are stat and shortlog; not from the actual git tree but from patches as
> they went in. Side notes: The spike in the diffstat is whitespace formatting.
> Sem2mutex and kthread conversions as well as suspend/resume fixes are not
> complete yet.

Ok, I pulled, and pushed out, but this tree is really problematic: the 
authorship info has been dropped entirely, it looks.

Git tries to make it very easy to attribute patches properly (with command 
line switches to do it manually, but also with automated tools like git-am 
etc to do it automatically from emails), and has separate "committer" and 
"author" fields, exactly so that you can see both who did the actual 
patch, and who actually merged it.

The ieee1394 tree doesn't actually do that. Ben Collins shows up as the 
author for all of it.

Yes, the sign-offs look fine, but still, attribution and credit is 
_important_.

So for next time, please spend the effort to get attribution right, ok?

		Linus
