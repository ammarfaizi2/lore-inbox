Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262367AbVCCVpG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262367AbVCCVpG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Mar 2005 16:45:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262421AbVCCVnh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Mar 2005 16:43:37 -0500
Received: from colin2.muc.de ([193.149.48.15]:27141 "HELO colin2.muc.de")
	by vger.kernel.org with SMTP id S262586AbVCCVcX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Mar 2005 16:32:23 -0500
Date: 3 Mar 2005 22:32:15 +0100
Date: Thu, 3 Mar 2005 22:32:15 +0100
From: Andi Kleen <ak@muc.de>
To: Bernd Schubert <bernd-schubert@web.de>
Cc: linux-kernel@vger.kernel.org, Trond Myklebust <trond.myklebust@fys.uio.no>,
       Andreas Schwab <schwab@suse.de>
Subject: Re: x86_64: 32bit emulation problems
Message-ID: <20050303213215.GA96478@muc.de>
References: <200502282154.08009.bernd.schubert@pci.uni-heidelberg.de> <1109782387.9667.11.camel@lade.trondhjem.org> <20050303091908.GC5215@muc.de> <200503032216.31859.bernd-schubert@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200503032216.31859.bernd-schubert@web.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> So what do you actually suggest? On the one hand you say even 32bit userspace 
> supports 64bit inodes, if it wants. On the other hand you say the truncation 
> needs to be done on file system level. 
> To my mind this is contradicting, the first statement suggests to do the 
> truncation in userspace, the second says it can only be done in the kernel?

We have to live with glibc not supporting this, so it would be probably
best to always do the truncation in NFS.

-Andi
