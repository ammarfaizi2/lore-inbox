Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261739AbVAYAAu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261739AbVAYAAu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Jan 2005 19:00:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261735AbVAXXWi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Jan 2005 18:22:38 -0500
Received: from fw.osdl.org ([65.172.181.6]:20874 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261721AbVAXXEz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Jan 2005 18:04:55 -0500
Date: Mon, 24 Jan 2005 15:09:40 -0800
From: Andrew Morton <akpm@osdl.org>
To: Matt Mackall <mpm@selenic.com>
Cc: linux-kernel@vger.kernel.org, neilb@cse.unsw.edu.au,
       trond.myklebust@fys.uio.no, okir@suse.de, Andries.Brouwer@cwi.nl,
       agruen@suse.de
Subject: Re: [PATCH] lib/qsort
Message-Id: <20050124150940.26945fe3.akpm@osdl.org>
In-Reply-To: <20050124201527.GZ12076@waste.org>
References: <20050122203326.402087000@blunzn.suse.de>
	<20050122203618.962749000@blunzn.suse.de>
	<20050124201527.GZ12076@waste.org>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matt Mackall <mpm@selenic.com> wrote:
>
> This patch introduces an implementation of qsort to lib/.

It screws me over right proper.  Can we stick with Andreas's known-working
patch for now, and do the sorting stuff as a separate, later activity?

It would involve:

- Removal of the old sort code

- Introduction of the new sort code

- Migration of the NFS ACL code, XFS and group code over to the new
  implementation.


