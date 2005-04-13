Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261175AbVDMS3Q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261175AbVDMS3Q (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Apr 2005 14:29:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261176AbVDMS3Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Apr 2005 14:29:16 -0400
Received: from colin2.muc.de ([193.149.48.15]:58898 "EHLO colin2.muc.de")
	by vger.kernel.org with ESMTP id S261175AbVDMS3O (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Apr 2005 14:29:14 -0400
Date: 13 Apr 2005 20:29:13 +0200
Date: Wed, 13 Apr 2005 20:29:13 +0200
From: Andi Kleen <ak@muc.de>
To: Matt Tolentino <metolent@snoqualmie.dp.intel.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [patch] minor syctl fix in vsyscall_init
Message-ID: <20050413182913.GE50241@muc.de>
References: <200504131745.j3DHjIVE017612@snoqualmie.dp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200504131745.j3DHjIVE017612@snoqualmie.dp.intel.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 13, 2005 at 10:45:18AM -0700, Matt Tolentino wrote:
> 
> Andi,
> 
> If CONFIG_SYCTL is not enabled then the x86-64 tree
> fails to build due to use of a symbol that is not 
> compiled in.  Don't bother compiling in the sysctl
> register call if not building with sysctl.  

Thanks. Actually it would be better to fix up sysctl.h
to define dummy functions in this case. I thought it did
that already in fact....

-Andi

