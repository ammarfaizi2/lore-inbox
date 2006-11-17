Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1755681AbWKQKaF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755681AbWKQKaF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Nov 2006 05:30:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933515AbWKQKaF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Nov 2006 05:30:05 -0500
Received: from mx2.suse.de ([195.135.220.15]:61617 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1755680AbWKQKaB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Nov 2006 05:30:01 -0500
From: Andi Kleen <ak@suse.de>
To: Mikael Pettersson <mikpe@it.uu.se>
Subject: Re: [discuss] Re: 2.6.19-rc5: known regressions (v3)
Date: Fri, 17 Nov 2006 11:29:25 +0100
User-Agent: KMail/1.9.5
Cc: Andrew Morton <akpm@osdl.org>, "Eric W. Biederman" <ebiederm@xmission.com>,
       Linus Torvalds <torvalds@osdl.org>, discuss@x86-64.org,
       William Cohen <wcohen@redhat.com>, Komuro <komurojun-mbn@nifty.com>,
       Ernst Herzberg <earny@net4u.de>, Andre Noll <maan@systemlinux.org>,
       oprofile-list@lists.sourceforge.net, Jens Axboe <jens.axboe@oracle.com>,
       linux-usb-devel@lists.sourceforge.net, phil.el@wanadoo.fr,
       Adrian Bunk <bunk@stusta.de>, Ingo Molnar <mingo@redhat.com>,
       Alan Stern <stern@rowland.harvard.edu>,
       linux-pci@atrey.karlin.mff.cuni.cz,
       Stephen Hemminger <shemminger@osdl.org>,
       Prakash Punnoor <prakash@punnoor.de>, Len Brown <len.brown@intel.com>,
       Alex Romosan <romosan@sycorax.lbl.gov>, gregkh@suse.de,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrey Borzenkov <arvidjaar@mail.ru>
References: <Pine.LNX.4.64.0611071829340.3667@g5.osdl.org> <20061116122358.996fdbb3.akpm@osdl.org> <17757.34795.689658.106603@alkaid.it.uu.se>
In-Reply-To: <17757.34795.689658.106603@alkaid.it.uu.se>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200611171129.26014.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 17 November 2006 10:59, Mikael Pettersson wrote:

> It certainly worked when I originally implemented it. 

I don't think so. NMI watchdog never recovered no matter if oprofile
used the counter or not.

-Andi
