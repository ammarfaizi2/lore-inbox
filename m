Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751121AbVIBIYN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751121AbVIBIYN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Sep 2005 04:24:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751120AbVIBIYN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Sep 2005 04:24:13 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:35723 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S1751121AbVIBIYM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Sep 2005 04:24:12 -0400
Date: Fri, 2 Sep 2005 10:24:04 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Andrew Morton <akpm@osdl.org>
cc: linux-kernel@vger.kernel.org, viro@parcelfarce.linux.theplanet.co.uk
Subject: Re: [PATCH 0/10] m68k/thread_info merge
In-Reply-To: <20050901171738.49d8893d.akpm@osdl.org>
Message-ID: <Pine.LNX.4.61.0509021018300.3728@scrub.home>
References: <Pine.LNX.4.61.0509012211010.8099@scrub.home>
 <20050901171621.33d41b3c.akpm@osdl.org> <20050901171738.49d8893d.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, 1 Sep 2005, Andrew Morton wrote:

> Andrew Morton <akpm@osdl.org> wrote:
> >
> > Can I assume that the five m68k patches can be split apart from the five
> > patches which dink with task_struct?  ie: if the task_struct patches go in
> > later, does anything bad happen?
> 
> eh, forget I asked that.  They're interdependent.

Actually they shouldn't be, unless I missed something.
Especially if there should be a conflict in the last three patches with 
some other patch, you can drop the conflicting part in my patch and I'll 
fix it up later.

bye, Roman
