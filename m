Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161835AbWKPFIy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161835AbWKPFIy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Nov 2006 00:08:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161838AbWKPFIy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Nov 2006 00:08:54 -0500
Received: from smtp.osdl.org ([65.172.181.4]:28848 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1161835AbWKPFIx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Nov 2006 00:08:53 -0500
Date: Wed, 15 Nov 2006 21:05:01 -0800
From: Andrew Morton <akpm@osdl.org>
To: Andi Kleen <ak@suse.de>
Cc: Linus Torvalds <torvalds@osdl.org>, discuss@x86-64.org,
       William Cohen <wcohen@redhat.com>, Eric Dumazet <dada1@cosmosbay.com>,
       Komuro <komurojun-mbn@nifty.com>, Ernst Herzberg <earny@net4u.de>,
       Andre Noll <maan@systemlinux.org>, oprofile-list@lists.sourceforge.net,
       Jens Axboe <jens.axboe@oracle.com>,
       linux-usb-devel@lists.sourceforge.net, phil.el@wanadoo.fr,
       Adrian Bunk <bunk@stusta.de>, Ingo Molnar <mingo@redhat.com>,
       Alan Stern <stern@rowland.harvard.edu>,
       linux-pci@atrey.karlin.mff.cuni.cz,
       Stephen Hemminger <shemminger@osdl.org>,
       Prakash Punnoor <prakash@punnoor.de>, Len Brown <len.brown@intel.com>,
       Alex Romosan <romosan@sycorax.lbl.gov>, gregkh@suse.de,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       Andrey Borzenkov <arvidjaar@mail.ru>
Subject: Re: [discuss] Re: 2.6.19-rc5: known regressions (v3)
Message-Id: <20061115210501.feaf230c.akpm@osdl.org>
In-Reply-To: <20061116032109.GG9579@bingen.suse.de>
References: <Pine.LNX.4.64.0611071829340.3667@g5.osdl.org>
	<200611151945.31535.ak@suse.de>
	<Pine.LNX.4.64.0611151105560.3349@woody.osdl.org>
	<200611152023.53960.ak@suse.de>
	<20061115122118.14fa2177.akpm@osdl.org>
	<20061116032109.GG9579@bingen.suse.de>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 16 Nov 2006 04:21:09 +0100
Andi Kleen <ak@suse.de> wrote:

> > 
> > If it's really true that oprofile is simply busted then that's a serious
> > problem and we should find some way of unbusting it.  If that means just
> > adding a dummy "0" entry which always returns zero or something like that,
> > then fine.
> 
> That could be probably done.

I'm told that this is exactly what it was doing before it got changed.

> > But we can't just go and bust it.
> 
> It just did something unbelievable broken before.

What did it do?

> I would say it busted
> itself.

It gave profiles, which was fairly handy.
