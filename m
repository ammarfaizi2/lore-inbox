Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932381AbWEBFyK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932381AbWEBFyK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 May 2006 01:54:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932382AbWEBFyK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 May 2006 01:54:10 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:57002
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S932381AbWEBFyJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 May 2006 01:54:09 -0400
Date: Mon, 01 May 2006 22:53:55 -0700 (PDT)
Message-Id: <20060501.225355.111911333.davem@davemloft.net>
To: linux-kernel@vger.kernel.org, akpm@osdl.org
Cc: y-goto@jp.fujitsu.com
Subject: Re: + fix-compile-error-undefined-reference-for-sparc64.patch
 added to -mm tree
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <200605020544.k425iQmh023190@shell0.pdx.osdl.net>
References: <200605020544.k425iQmh023190@shell0.pdx.osdl.net>
X-Mailer: Mew version 4.2.53 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: akpm@osdl.org
Date: Mon, 01 May 2006 22:44:26 -0700

> From: Yasunori Goto <y-goto@jp.fujitsu.com>
> 
> Fix "undefined reference to `arch_add_memory'" on sparc64 allmodconfig.
> 
> sparc64 doesn't support memory hotplug.  But we want it to support
> sparsemem.
> 
> Signed-off-by: Yasunori Goto <y-goto@jp.fujitsu.com>
> Cc: "David S. Miller" <davem@davemloft.net>
> Signed-off-by: Andrew Morton <akpm@osdl.org>

I haven't seen any problems in Linus's tree, so I'm assuming
this is only a problem in -mm?
