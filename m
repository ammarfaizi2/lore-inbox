Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932688AbWKLQHU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932688AbWKLQHU (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Nov 2006 11:07:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932943AbWKLQHU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Nov 2006 11:07:20 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:51381 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932688AbWKLQHT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Nov 2006 11:07:19 -0500
Subject: Re: [Bugme-new] [Bug 7495] New: Kernel periodically hangs.
From: Arjan van de Ven <arjan@infradead.org>
To: Patrick McFarland <diablod3@gmail.com>
Cc: Adrian Bunk <bunk@stusta.de>, Andrew Morton <akpm@osdl.org>,
       David Howells <dhowells@redhat.com>, Neil Brown <neilb@cse.unsw.edu.au>,
       "bugme-daemon@kernel-bugs.osdl.org" 
	<bugme-daemon@bugzilla.kernel.org>,
       linux-kernel@vger.kernel.org, alex@hausnet.ru, mingo@redhat.com
In-Reply-To: <200611121059.55454.diablod3@gmail.com>
References: <20061111100038.6277efd4.akpm@osdl.org>
	 <1163340998.3293.131.camel@laptopd505.fenrus.org>
	 <20061112152154.GA3382@stusta.de>  <200611121059.55454.diablod3@gmail.com>
Content-Type: text/plain
Organization: Intel International BV
Date: Sun, 12 Nov 2006 17:07:02 +0100
Message-Id: <1163347622.15249.10.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1.1 (2.8.1.1-3.fc6) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2006-11-12 at 10:59 -0500, Patrick McFarland wrote:
> On Sunday 12 November 2006 10:21, Adrian Bunk wrote:
> > On Sun, Nov 12, 2006 at 03:16:38PM +0100, Arjan van de Ven wrote:
> > > > > We KNOW it can't work on a sizable amount of machines.  This is why
> > > > > it is a config option; you can enable it if YOUR machine is KNOWN to
> > > > > work, and you get some gains. But it's also understood that it often
> > > > > it won't work. So any sensible distro (since they have to aim for a
> > > > > wide audience) disables this option ...
> > > >
> > > > Nowadays, many distributions only ship CONFIG_SMP=y kernels...
> > >
> > > that's a calculated risk on their side (and they know that); they're
> > > balancing not functioning on a set of machines off against needing more
> > > kernels.
> >
> > This might soon affect the majority of Linux users, so it's a case that
> > has to be handled...
> 
> I actually agree here. Linux needs to be easier for people to use, not harder. 
> Isn't there a way for bootloaders or the kernel early on figure out if the 
> machine supports SMP, and if it doesnt, load a uniproc kernel instead?

this is what OS installers have been doing for a decade or so.

-- 
if you want to mail me at work (you don't), use arjan (at) linux.intel.com
Test the interaction between Linux and your BIOS via http://www.linuxfirmwarekit.org

