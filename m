Return-Path: <linux-kernel-owner+w=401wt.eu-S1761841AbWLITVr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761841AbWLITVr (ORCPT <rfc822;w@1wt.eu>);
	Sat, 9 Dec 2006 14:21:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761842AbWLITVr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Dec 2006 14:21:47 -0500
Received: from smtp.osdl.org ([65.172.181.25]:42159 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1761835AbWLITVq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Dec 2006 14:21:46 -0500
Date: Sat, 9 Dec 2006 11:21:30 -0800
From: Andrew Morton <akpm@osdl.org>
To: Randy Dunlap <randy.dunlap@oracle.com>
Cc: Michael Halcrow <mhalcrow@us.ibm.com>, LKML <linux-kernel@vger.kernel.org>,
       trevor.highland@gmail.com, tyhicks@ou.edu
Subject: Re: [PATCH 1/2] eCryptfs: Public key; transport mechanism
Message-Id: <20061209112130.f3ba7f22.akpm@osdl.org>
In-Reply-To: <20061209110416.670170eb.randy.dunlap@oracle.com>
References: <20061206230638.GA9358@us.ibm.com>
	<20061206215555.85d584ca.akpm@osdl.org>
	<20061209110416.670170eb.randy.dunlap@oracle.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 9 Dec 2006 11:04:16 -0800
Randy Dunlap <randy.dunlap@oracle.com> wrote:

> > ecryptfs now has a dependency upon netlink.  There's no CONFIG_NETLINK.  If
> > CONFIG_NET=n && CONFIG_ECRYPTFS=y is possible, it won't build.
> 
> Then shouldn't ECRYPTFS depend on CONFIG_NET ?

yup, that's what I meant..
