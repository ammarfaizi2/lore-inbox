Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750832AbWE1Rwm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750832AbWE1Rwm (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 May 2006 13:52:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750833AbWE1Rwm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 May 2006 13:52:42 -0400
Received: from mustang.oldcity.dca.net ([216.158.38.3]:41708 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S1750832AbWE1Rwl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 May 2006 13:52:41 -0400
Subject: Re: How to check if kernel sources are installed on a system?
From: Lee Revell <rlrevell@joe-job.com>
To: Arjan van de Ven <arjan@infradead.org>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>,
       devmazumdar <dev@opensound.com>, linux-kernel@vger.kernel.org
In-Reply-To: <1148835799.3074.41.camel@laptopd505.fenrus.org>
References: <e55715+usls@eGroups.com> <1148596163.31038.30.camel@mindpipe>
	 <1148653797.3579.18.camel@laptopd505.fenrus.org>
	 <20060528130320.GA10385@osiris.ibm.com>
	 <1148835799.3074.41.camel@laptopd505.fenrus.org>
Content-Type: text/plain
Date: Sun, 28 May 2006 13:52:17 -0400
Message-Id: <1148838738.21094.65.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2006-05-28 at 19:03 +0200, Arjan van de Ven wrote:
> On Sun, 2006-05-28 at 15:03 +0200, Heiko Carstens wrote:
> > > > > How does one check the existence of the kernel source RPM (or deb) on
> > > > > every single distribution?.
> > > > > 
> > > > > We know that rpm -qa | grep kernel-source works on Redhat, Fedora,
> > > > > SuSE, Mandrake and CentOS - how about other RPM based distros? How
> > > > > about debian based distros?. There doesn't seem to be a a single
> > > > > conherent naming scheme.  
> > > > 
> > > > I'd really like to see a distro-agnostic way to retrieve the kernel
> > > > configuration.  /proc/config.gz has existed for soem time but many
> > > > distros inexplicably don't enable it.
> > > 
> > > /boot/config-`uname -r`
> > 
> > What's the reason for distros to disable /proc/config.gz?
> 
> what would be a reason to ENable it???
> it's double functionality that does take memory away...
> 

It sounds like there is in fact no distro agnostic way to retrieve the
kernel config (the solutions posted involve using rpm for "sanity
checking" etc).

Why was /proc/config.gz merged then?  If no distro uses it shouldn't it
be removed?

Lee

