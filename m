Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265275AbUAJStf (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Jan 2004 13:49:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265282AbUAJStf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Jan 2004 13:49:35 -0500
Received: from fw.osdl.org ([65.172.181.6]:6343 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265275AbUAJSte (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Jan 2004 13:49:34 -0500
Date: Sat, 10 Jan 2004 10:42:47 -0800
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Unhork ymfpci broken by hasty janitors
Message-Id: <20040110104247.072131cd.rddunlap@osdl.org>
In-Reply-To: <20040110102912.78ef218b.rddunlap@osdl.org>
References: <200401101805.i0AI50x8012960@hera.kernel.org>
	<20040110102912.78ef218b.rddunlap@osdl.org>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 10 Jan 2004 10:29:12 -0800 "Randy.Dunlap" <rddunlap@osdl.org> wrote:

| On Sat, 10 Jan 2004 17:49:31 +0000 Linux Kernel Mailing List <linux-kernel@vger.kernel.org> wrote:
| 
| | ChangeSet 1.1391, 2004/01/10 15:49:31-02:00, zaitcev@redhat.com
| | 
| | 	[PATCH] Unhork ymfpci broken by hasty janitors
| | 	
| | 	- Do not use schedule_timeout with spinlocks taken.
| | 	- Restore missing kfree's.
| 
| some janitors maybe.  but "hasty janitors" != "kernel-janitors project".
| 
| BK shows previous changes here by "alan", "patch", and "torvalds",
| so they must have been made by "patch".  8:)

Sorry, I meant to also say:

Yes, we (the KJ project) [or I] do make mistakes, but we haven't
been making patches to 2.4.x kernels.

--
~Randy
