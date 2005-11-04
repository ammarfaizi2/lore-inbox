Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161148AbVKDPzZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161148AbVKDPzZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Nov 2005 10:55:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161151AbVKDPzY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Nov 2005 10:55:24 -0500
Received: from 238-193.adsl.pool.ew.hu ([193.226.238.193]:4868 "EHLO
	dorka.pomaz.szeredi.hu") by vger.kernel.org with ESMTP
	id S1161149AbVKDPzY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Nov 2005 10:55:24 -0500
To: jblunck@suse.de
CC: viro@ftp.linux.org.uk, linux-kernel@vger.kernel.org
In-reply-to: <20051104154610.GB23962@hasse.suse.de> (jblunck@suse.de)
Subject: Re: [RFC,PATCH] libfs dcache_readdir() and dcache_dir_lseek() bugfix
References: <20051104113851.GA4770@hasse.suse.de> <20051104115101.GH7992@ftp.linux.org.uk> <20051104122021.GA15061@hasse.suse.de> <E1EY16w-0004HC-00@dorka.pomaz.szeredi.hu> <20051104131858.GA16622@hasse.suse.de> <E1EY1fi-0004LB-00@dorka.pomaz.szeredi.hu> <20051104151104.GA22322@hasse.suse.de> <E1EY3Y8-0004XX-00@dorka.pomaz.szeredi.hu> <20051104154610.GB23962@hasse.suse.de>
Message-Id: <E1EY3uI-0004cC-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Fri, 04 Nov 2005 16:55:10 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > > 
> > > Well, glibc is that stupid and triggers the bug.
> > 
> > Seems to me, the simple solution is to upgrade your glibc.
> > 
> 
> This is SLES8. You don't want to update the glibc.

OK, but then it's basically a SLES8 kernel issue, not a mainline
kernel issue.

Probably very few people are using brand new kernels with glibc from
the last millennium ;)

Miklos

