Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932912AbWKLOQt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932912AbWKLOQt (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Nov 2006 09:16:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932914AbWKLOQt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Nov 2006 09:16:49 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:58542 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932912AbWKLOQt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Nov 2006 09:16:49 -0500
Subject: Re: [Bugme-new] [Bug 7495] New: Kernel periodically hangs.
From: Arjan van de Ven <arjan@infradead.org>
Reply-To: arjan@infradead.org
To: Adrian Bunk <bunk@stusta.de>
Cc: Andrew Morton <akpm@osdl.org>, David Howells <dhowells@redhat.com>,
       Neil Brown <neilb@cse.unsw.edu.au>,
       "bugme-daemon@kernel-bugs.osdl.org" 
	<bugme-daemon@bugzilla.kernel.org>,
       linux-kernel@vger.kernel.org, alex@hausnet.ru, mingo@redhat.com
In-Reply-To: <20061112141016.GA5297@stusta.de>
References: <200611111129.kABBTWgp014081@fire-2.osdl.org>
	 <20061111100038.6277efd4.akpm@osdl.org>
	 <1163268603.3293.45.camel@laptopd505.fenrus.org>
	 <20061111101942.5f3f2537.akpm@osdl.org>
	 <1163332237.3293.100.camel@laptopd505.fenrus.org>
	 <20061112125357.GH25057@stusta.de>
	 <1163337376.3293.120.camel@laptopd505.fenrus.org>
	 <20061112133759.GK25057@stusta.de>
	 <1163339868.3293.126.camel@laptopd505.fenrus.org>
	 <20061112141016.GA5297@stusta.de>
Content-Type: text/plain
Organization: Intel International BV
Date: Sun, 12 Nov 2006 15:16:38 +0100
Message-Id: <1163340998.3293.131.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1.1 (2.8.1.1-3.fc6) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > We KNOW it can't work on a sizable amount of machines.  This is why it
> > is a config option; you can enable it if YOUR machine is KNOWN to work,
> > and you get some gains. But it's also understood that it often it won't
> > work. So any sensible distro (since they have to aim for a wide
> > audience) disables this option ...
> 
> Nowadays, many distributions only ship CONFIG_SMP=y kernels...

that's a calculated risk on their side (and they know that); they're
balancing not functioning on a set of machines off against needing more
kernels.


> You miss my point.
> 
> You said you'd suspect it to be turned off automatic most of the time, 
> and that's the point I think you might be wrong at.

it won't be turned off on machines that support dual core processors
etc, since those DO get validated and designed for APIC use.. even if
you only stick a single core processor in. So yes you're right, that
nowadays is a pretty large group. But it's the safe group I guess:)

-- 
if you want to mail me at work (you don't), use arjan (at) linux.intel.com
Test the interaction between Linux and your BIOS via http://www.linuxfirmwarekit.org

