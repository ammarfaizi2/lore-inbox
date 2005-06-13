Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261440AbVFMJQK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261440AbVFMJQK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Jun 2005 05:16:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261445AbVFMJQK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Jun 2005 05:16:10 -0400
Received: from outpost.ds9a.nl ([213.244.168.210]:26817 "EHLO outpost.ds9a.nl")
	by vger.kernel.org with ESMTP id S261440AbVFMJQE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Jun 2005 05:16:04 -0400
Date: Mon, 13 Jun 2005 11:16:01 +0200
From: bert hubert <bert.hubert@netherlabs.nl>
To: Ulrich Drepper <drepper@redhat.com>
Cc: Linus Torvalds <torvalds@osdl.org>, jnf <jnf@innocence-lost.net>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       David Woodhouse <dwmw2@infradead.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, akpm@osdl.org
Subject: Re: Add pselect, ppoll system calls.
Message-ID: <20050613091600.GA32364@outpost.ds9a.nl>
Mail-Followup-To: bert hubert <bert.hubert@netherlabs.nl>,
	Ulrich Drepper <drepper@redhat.com>,
	Linus Torvalds <torvalds@osdl.org>, jnf <jnf@innocence-lost.net>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	David Woodhouse <dwmw2@infradead.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	akpm@osdl.org
References: <1118444314.4823.81.camel@localhost.localdomain> <1118616499.9949.103.camel@localhost.localdomain> <Pine.LNX.4.58.0506121725250.2286@ppc970.osdl.org> <Pine.LNX.4.62.0506121815070.24789@fhozvffvba.vaabprapr-ybfg.arg> <Pine.LNX.4.58.0506122018230.2286@ppc970.osdl.org> <42AD2640.5040601@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42AD2640.5040601@redhat.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 12, 2005 at 11:22:56PM -0700, Ulrich Drepper wrote:
> pselect is portable, just not to current and old Linux systems.  It's in
> POSIX for a while and the other Unixes have the interface.

Indeed - it has been documented since the days of Stevens at least. All
unixes that matter have it.

>From the application side, I pretty much really want pselect to work. It is
an embarassment to have a broken implementation, if we really think pselect
sucks we should deprecate it in glibc.

So, please, consider merging the patches.. ppoll is something else, I never
heard about it, but pselect is widely known.

Thanks.

-- 
http://www.PowerDNS.com      Open source, database driven DNS Software 
http://netherlabs.nl              Open and Closed source services
