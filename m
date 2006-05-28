Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750754AbWE1NDa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750754AbWE1NDa (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 May 2006 09:03:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750756AbWE1NDa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 May 2006 09:03:30 -0400
Received: from mtagate4.uk.ibm.com ([195.212.29.137]:33116 "EHLO
	mtagate4.uk.ibm.com") by vger.kernel.org with ESMTP
	id S1750754AbWE1ND3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 May 2006 09:03:29 -0400
Date: Sun, 28 May 2006 15:03:20 +0200
From: Heiko Carstens <heiko.carstens@de.ibm.com>
To: Arjan van de Ven <arjan@infradead.org>
Cc: Lee Revell <rlrevell@joe-job.com>, devmazumdar <dev@opensound.com>,
       linux-kernel@vger.kernel.org
Subject: Re: How to check if kernel sources are installed on a system?
Message-ID: <20060528130320.GA10385@osiris.ibm.com>
References: <e55715+usls@eGroups.com> <1148596163.31038.30.camel@mindpipe> <1148653797.3579.18.camel@laptopd505.fenrus.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1148653797.3579.18.camel@laptopd505.fenrus.org>
User-Agent: mutt-ng/devel-r802 (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > > How does one check the existence of the kernel source RPM (or deb) on
> > > every single distribution?.
> > > 
> > > We know that rpm -qa | grep kernel-source works on Redhat, Fedora,
> > > SuSE, Mandrake and CentOS - how about other RPM based distros? How
> > > about debian based distros?. There doesn't seem to be a a single
> > > conherent naming scheme.  
> > 
> > I'd really like to see a distro-agnostic way to retrieve the kernel
> > configuration.  /proc/config.gz has existed for soem time but many
> > distros inexplicably don't enable it.
> 
> /boot/config-`uname -r`

What's the reason for distros to disable /proc/config.gz?
