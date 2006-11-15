Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966615AbWKOMHh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966615AbWKOMHh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Nov 2006 07:07:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966635AbWKOMHh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Nov 2006 07:07:37 -0500
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:48590 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S966615AbWKOMHg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Nov 2006 07:07:36 -0500
Date: Wed, 15 Nov 2006 12:07:44 +0000
From: Alan <alan@lxorguk.ukuu.org.uk>
To: Adrian Bunk <bunk@stusta.de>
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Stephen Hemminger <shemminger@osdl.org>, gregkh@suse.de,
       linux-pci@atrey.karlin.mff.cuni.cz, Komuro <komurojun-mbn@nifty.com>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       Ingo Molnar <mingo@redhat.com>, Ernst Herzberg <earny@net4u.de>,
       Len Brown <len.brown@intel.com>, Andre Noll <maan@systemlinux.org>,
       Andi Kleen <ak@suse.de>, discuss@x86-64.org,
       Prakash Punnoor <prakash@punnoor.de>, phil.el@wanadoo.fr,
       oprofile-list@lists.sourceforge.net,
       Alex Romosan <romosan@sycorax.lbl.gov>,
       Jens Axboe <jens.axboe@oracle.com>,
       Andrey Borzenkov <arvidjaar@mail.ru>,
       Alan Stern <stern@rowland.harvard.edu>,
       linux-usb-devel@lists.sourceforge.net
Subject: Re: 2.6.19-rc5: known regressions (v3)
Message-ID: <20061115120744.41a01185@localhost.localdomain>
In-Reply-To: <20061115102122.GQ22565@stusta.de>
References: <Pine.LNX.4.64.0611071829340.3667@g5.osdl.org>
	<20061115102122.GQ22565@stusta.de>
X-Mailer: Sylpheed-Claws 2.6.0 (GTK+ 2.8.20; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Subject    : PCI MSI setting corrupted during resume
> References : http://bugzilla.kernel.org/show_bug.cgi?id=7479
> Submitter  : Stephen Hemminger <shemminger@osdl.org>
> Status     : unknown

This is one of the minor resume problems as far as I can tell. I believe
the patches I posted for having a resume quirk run on each device if
appropriate should correctly resolve these. See the patch I sent to l/k.

There are a variety of other resume quirks we definitely require.

Alan
