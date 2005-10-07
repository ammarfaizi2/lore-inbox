Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932294AbVJGJuo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932294AbVJGJuo (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Oct 2005 05:50:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932275AbVJGJun
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Oct 2005 05:50:43 -0400
Received: from mail.suse.de ([195.135.220.2]:12715 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932274AbVJGJun (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Oct 2005 05:50:43 -0400
Date: Fri, 7 Oct 2005 11:50:41 +0200
From: Andi Kleen <ak@suse.de>
To: Brian Gerst <bgerst@didntduck.org>
Cc: lkml <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       Andi Kleen <ak@suse.de>
Subject: Re: [PATCH] Fix hotplug cpu on x86_64
Message-ID: <20051007095041.GK6642@verdi.suse.de>
References: <43437DEB.4080405@didntduck.org> <434414C4.8020109@didntduck.org> <4345F656.9020601@didntduck.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4345F656.9020601@didntduck.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

A similar patch is already queued with Linus.

I also have a followon patch to avoid the extreme memory wastage
currently caused by hotplug CPUs (e.g. with NR_CPUS==128 you currently
lose 4MB of memory just for preallocated per CPU data). But that is
something for post 2.6.14.

See ftp://ftp.firstfloor.org/pub/ak/x86_64/quilt-current/patches/* 
for the current queue.

-Andi
