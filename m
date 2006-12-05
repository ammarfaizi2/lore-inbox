Return-Path: <linux-kernel-owner+willy=40w.ods.org-S936892AbWLEWtT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936892AbWLEWtT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Dec 2006 17:49:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S937005AbWLEWtT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Dec 2006 17:49:19 -0500
Received: from smtp.osdl.org ([65.172.181.25]:44295 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S936892AbWLEWtS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Dec 2006 17:49:18 -0500
Date: Tue, 5 Dec 2006 14:49:13 -0800
From: Andrew Morton <akpm@osdl.org>
To: Josef Sipek <jsipek@fsl.cs.sunysb.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] fsstack: Fix up ecryptfs's fsstack usage
Message-Id: <20061205144913.fea98946.akpm@osdl.org>
In-Reply-To: <20061205223807.GA7300@filer.fsl.cs.sunysb.edu>
References: <20061204204024.2401148d.akpm@osdl.org>
	<20061205191824.GB2240@filer.fsl.cs.sunysb.edu>
	<20061205192231.GD2240@filer.fsl.cs.sunysb.edu>
	<20061205142831.9cb3e91c.akpm@osdl.org>
	<20061205223807.GA7300@filer.fsl.cs.sunysb.edu>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 5 Dec 2006 17:38:07 -0500
Josef Sipek <jsipek@fsl.cs.sunysb.edu> wrote:

> > When your patches are queued in -mm please do test them there, and review
> > others' changes to them, and raise patches against them.  Raising patches
> > against one's private tree and not testing the code which is planned to be
> > merged can introduce errors.
> 
> Sorry about that. I noticed your fix, and the one by Adrian. And I did add
> them to my fsstack queue.

you don't have an fsstack queue any more ;)

Please, I really do want developers to test their code in -mm once I've
merged it.  What happens if there's some nasty interaction between your
patch and someone else's?  We'll not find out about it and it'll get
merged.
