Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750803AbWE1RD2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750803AbWE1RD2 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 May 2006 13:03:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750804AbWE1RD2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 May 2006 13:03:28 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:31648 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1750803AbWE1RD2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 May 2006 13:03:28 -0400
Subject: Re: How to check if kernel sources are installed on a system?
From: Arjan van de Ven <arjan@infradead.org>
To: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: Lee Revell <rlrevell@joe-job.com>, devmazumdar <dev@opensound.com>,
       linux-kernel@vger.kernel.org
In-Reply-To: <20060528130320.GA10385@osiris.ibm.com>
References: <e55715+usls@eGroups.com> <1148596163.31038.30.camel@mindpipe>
	 <1148653797.3579.18.camel@laptopd505.fenrus.org>
	 <20060528130320.GA10385@osiris.ibm.com>
Content-Type: text/plain
Date: Sun, 28 May 2006 19:03:19 +0200
Message-Id: <1148835799.3074.41.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2006-05-28 at 15:03 +0200, Heiko Carstens wrote:
> > > > How does one check the existence of the kernel source RPM (or deb) on
> > > > every single distribution?.
> > > > 
> > > > We know that rpm -qa | grep kernel-source works on Redhat, Fedora,
> > > > SuSE, Mandrake and CentOS - how about other RPM based distros? How
> > > > about debian based distros?. There doesn't seem to be a a single
> > > > conherent naming scheme.  
> > > 
> > > I'd really like to see a distro-agnostic way to retrieve the kernel
> > > configuration.  /proc/config.gz has existed for soem time but many
> > > distros inexplicably don't enable it.
> > 
> > /boot/config-`uname -r`
> 
> What's the reason for distros to disable /proc/config.gz?

what would be a reason to ENable it???
it's double functionality that does take memory away...

