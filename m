Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750767AbWE1Np3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750767AbWE1Np3 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 May 2006 09:45:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750768AbWE1Np3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 May 2006 09:45:29 -0400
Received: from mtagate3.uk.ibm.com ([195.212.29.136]:36163 "EHLO
	mtagate3.uk.ibm.com") by vger.kernel.org with ESMTP
	id S1750767AbWE1Np2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 May 2006 09:45:28 -0400
Date: Sun, 28 May 2006 15:45:20 +0200
From: Heiko Carstens <heiko.carstens@de.ibm.com>
To: Arjan van de Ven <arjan@infradead.org>, Lee Revell <rlrevell@joe-job.com>,
       devmazumdar <dev@opensound.com>, linux-kernel@vger.kernel.org
Subject: Re: How to check if kernel sources are installed on a system?
Message-ID: <20060528134520.GB10385@osiris.ibm.com>
References: <e55715+usls@eGroups.com> <1148596163.31038.30.camel@mindpipe> <1148653797.3579.18.camel@laptopd505.fenrus.org> <20060528130320.GA10385@osiris.ibm.com> <20060528131257.GN13513@lug-owl.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060528131257.GN13513@lug-owl.de>
User-Agent: mutt-ng/devel-r802 (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > > > I'd really like to see a distro-agnostic way to retrieve the kernel
> > > > configuration.  /proc/config.gz has existed for soem time but many
> > > > distros inexplicably don't enable it.
> > > 
> > > /boot/config-`uname -r`
> > 
> > What's the reason for distros to disable /proc/config.gz?
> 
> To save memory?  The config can be placed as a plain file, so why
> waste non-swappable kernel memory for a task that can easily be done
> with a simple file?

As long as you know which of the config files to pick, no problem.
At least for me /proc/config.gz is the much more comfortable way. Anyway,
thanks for clarification!
