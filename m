Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262216AbVCODXD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262216AbVCODXD (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Mar 2005 22:23:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262218AbVCODXD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Mar 2005 22:23:03 -0500
Received: from fire.osdl.org ([65.172.181.4]:43175 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262216AbVCODWw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Mar 2005 22:22:52 -0500
Date: Mon, 14 Mar 2005 19:21:40 -0800
From: Andrew Morton <akpm@osdl.org>
To: jmerkey <jmerkey@utah-nac.org>
Cc: adilger@shaw.ca, strombrg@dcs.nac.uci.edu, linux-kernel@vger.kernel.org
Subject: Re: huge filesystems
Message-Id: <20050314192140.1b3680da.akpm@osdl.org>
In-Reply-To: <4235C251.7000801@utah-nac.org>
References: <pan.2005.03.09.18.53.47.428199@dcs.nac.uci.edu>
	<20050314164137.GC1451@schnapps.adilger.int>
	<4235C251.7000801@utah-nac.org>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

jmerkey <jmerkey@utah-nac.org> wrote:
>
> I am running the DSFS file system as a 7 TB file system on 2.6.9.

On a 32-bit CPU?

> There are a host of problems with the current VFS,

I don't recall you reporting any of them.  How can we expect to fix
anything if we aren't told about it?

> ad I have gotten around most of them 
>  by **NOT** using the linux page cache interface.

Well that won't fly.


The VFS should support devices up to 16TB on 32-bit CPUs.  If you know of
scenarios in which it fails to do that, please send a bug report.

