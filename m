Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261957AbVBPAGp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261957AbVBPAGp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Feb 2005 19:06:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261958AbVBPAGp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Feb 2005 19:06:45 -0500
Received: from ozlabs.org ([203.10.76.45]:14019 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S261957AbVBPAGo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Feb 2005 19:06:44 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16914.36495.380920.489673@cargo.ozlabs.ibm.com>
Date: Wed, 16 Feb 2005 11:06:39 +1100
From: Paul Mackerras <paulus@samba.org>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: LKML <linux-kernel@vger.kernel.org>, anton@samba.org, davem@davemloft.net,
       ralf@linux-mips.org, tony.luck@intel.com, ak@suse.de, willy@debian.org,
       schwidefsky@de.ibm.com
Subject: Re: [PATCH] Consolidate compat_sys_waitid
In-Reply-To: <20050215140149.0b06c96b.sfr@canb.auug.org.au>
References: <20050215140149.0b06c96b.sfr@canb.auug.org.au>
X-Mailer: VM 7.19 under Emacs 21.3.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stephen Rothwell writes:

> This patch does:
> 	- consolidate the three implementations of compat_sys_waitid
> 	  (some were called sys32_waitid).
> 	- adds sys_waitid syscall to ppc
> 	- adds sys_waitid and compat_sys_waitid syscalls to ppc64

Looks good to me.  Are you going to submit it to Andrew?

Paul.
