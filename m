Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932399AbWEBG04@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932399AbWEBG04 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 May 2006 02:26:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932402AbWEBG04
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 May 2006 02:26:56 -0400
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35]:53648 "EHLO
	fgwmail5.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S932399AbWEBG0z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 May 2006 02:26:55 -0400
Date: Tue, 02 May 2006 15:25:50 +0900
From: Yasunori Goto <y-goto@jp.fujitsu.com>
To: "David S. Miller" <davem@davemloft.net>
Subject: Re: + fix-compile-error-undefined-reference-for-sparc64.patch added to -mm tree
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org
In-Reply-To: <20060501.225355.111911333.davem@davemloft.net>
References: <200605020544.k425iQmh023190@shell0.pdx.osdl.net> <20060501.225355.111911333.davem@davemloft.net>
X-Mailer-Plugin: BkASPil for Becky!2 Ver.2.063
Message-Id: <20060502152234.CF10.Y-GOTO@jp.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Becky! ver. 2.24.02 [ja]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> From: akpm@osdl.org
> Date: Mon, 01 May 2006 22:44:26 -0700
> 
> > From: Yasunori Goto <y-goto@jp.fujitsu.com>
> > 
> > Fix "undefined reference to `arch_add_memory'" on sparc64 allmodconfig.
> > 
> > sparc64 doesn't support memory hotplug.  But we want it to support
> > sparsemem.
> > 
> > Signed-off-by: Yasunori Goto <y-goto@jp.fujitsu.com>
> > Cc: "David S. Miller" <davem@davemloft.net>
> > Signed-off-by: Andrew Morton <akpm@osdl.org>
> 
> I haven't seen any problems in Linus's tree, so I'm assuming
> this is only a problem in -mm?

Yes. this patch is for 2.6.17-rc3-mm1.


-- 
Yasunori Goto 


