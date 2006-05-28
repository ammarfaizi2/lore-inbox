Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750850AbWE1STa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750850AbWE1STa (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 May 2006 14:19:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750851AbWE1STa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 May 2006 14:19:30 -0400
Received: from xenotime.net ([66.160.160.81]:15523 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1750849AbWE1ST3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 May 2006 14:19:29 -0400
Date: Sun, 28 May 2006 11:22:04 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: Arjan van de Ven <arjan@infradead.org>
Cc: rlrevell@joe-job.com, heiko.carstens@de.ibm.com, dev@opensound.com,
       linux-kernel@vger.kernel.org
Subject: Re: How to check if kernel sources are installed on a system?
Message-Id: <20060528112204.93c92b07.rdunlap@xenotime.net>
In-Reply-To: <1148839964.3074.52.camel@laptopd505.fenrus.org>
References: <e55715+usls@eGroups.com>
	<1148596163.31038.30.camel@mindpipe>
	<1148653797.3579.18.camel@laptopd505.fenrus.org>
	<20060528130320.GA10385@osiris.ibm.com>
	<1148835799.3074.41.camel@laptopd505.fenrus.org>
	<1148838738.21094.65.camel@mindpipe>
	<1148839964.3074.52.camel@laptopd505.fenrus.org>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 28 May 2006 20:12:44 +0200 Arjan van de Ven wrote:

> On Sun, 2006-05-28 at 13:52 -0400, Lee Revell wrote:
> > On Sun, 2006-05-28 at 19:03 +0200, Arjan van de Ven wrote:
> > > On Sun, 2006-05-28 at 15:03 +0200, Heiko Carstens wrote:
> > > > > > > How does one check the existence of the kernel source RPM (or deb) on
> > > > > > > every single distribution?.
> > > > > > > 
> > > > > > > We know that rpm -qa | grep kernel-source works on Redhat, Fedora,
> > > > > > > SuSE, Mandrake and CentOS - how about other RPM based distros? How
> > > > > > > about debian based distros?. There doesn't seem to be a a single
> > > > > > > conherent naming scheme.  
> > > > > > 
> > > > > > I'd really like to see a distro-agnostic way to retrieve the kernel
> > > > > > configuration.  /proc/config.gz has existed for soem time but many
> > > > > > distros inexplicably don't enable it.
> > > > > 
> > > > > /boot/config-`uname -r`
> > > > 
> > > > What's the reason for distros to disable /proc/config.gz?
> > > 
> > > what would be a reason to ENable it???
> > > it's double functionality that does take memory away...
> > > 
> > 
> > It sounds like there is in fact no distro agnostic way to retrieve the
> > kernel config 
> 
> /boot/config-`uname -r` goes a long way, and yes I'm ignoring the "but
> users CAN clobber the file if they use enough violence against their
> packaging system" argument entirely. That's just a bogus one.
> 
> Also... why would there really be a need for such a way? Not for
> building anything for sure.... it's for the human. And the human seems
> to just find it already (and again the boot file works well in practice
> it seems)

You may be correct now but a few years ago when /proc/config.gz
was developed, there were lots of distros that did not provide
/boot/config* files.

---
~Randy
