Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261708AbUCPMPi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Mar 2004 07:15:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261756AbUCPMPi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Mar 2004 07:15:38 -0500
Received: from gprs214-17.eurotel.cz ([160.218.214.17]:15749 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S261708AbUCPMPh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Mar 2004 07:15:37 -0500
Date: Tue, 16 Mar 2004 13:15:24 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Nigel Cunningham <ncunningham@users.sourceforge.net>,
       Patrick Mochel <mochel@digitalimplant.org>
Cc: Andrew Morton <akpm@digeo.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Suspend development list <swsusp-devel@lists.sourceforge.net>
Subject: Re: The verdict on the future of suspending to disk?
Message-ID: <20040316121524.GI2175@elf.ucw.cz>
References: <1079408330.3403.5.camel@calvin.wpcb.org.au> <20040316113717.GB2282@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040316113717.GB2282@elf.ucw.cz>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > - Apply patches making swsusp into suspend2, leaving out freezer changes
> > until people are convinced the current solution is insufficient.
> 
> Could you prepare some "swsusp2 without freezer" patch, so that we can
> see how it looks like? 

Or.. if you prefer. Would it be possible to get "two stage
refrigerator but without intrusive changes"? That should still be
better than what is there just now, and it should be mostly
independend change (right?). It will not give us suspend when nfs
server dies, but at least it will not have problems with mysqld...

								Pavel-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
