Return-Path: <linux-kernel-owner+w=401wt.eu-S1030516AbXAHTWw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030516AbXAHTWw (ORCPT <rfc822;w@1wt.eu>);
	Mon, 8 Jan 2007 14:22:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030518AbXAHTWw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Jan 2007 14:22:52 -0500
Received: from smtp.osdl.org ([65.172.181.24]:37169 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030516AbXAHTWv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Jan 2007 14:22:51 -0500
Date: Mon, 8 Jan 2007 11:18:52 -0800
From: Andrew Morton <akpm@osdl.org>
To: "Josef 'Jeff' Sipek" <jsipek@cs.sunysb.edu>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
       hch@infradead.org, viro@ftp.linux.org.uk, torvalds@osdl.org,
       mhalcrow@us.ibm.com, David Quigley <dquigley@fsl.cs.sunysb.edu>,
       Erez Zadok <ezk@cs.sunysb.edu>
Subject: Re: [PATCH 01/24] Unionfs: Documentation
Message-Id: <20070108111852.ee156a90.akpm@osdl.org>
In-Reply-To: <1168229596875-git-send-email-jsipek@cs.sunysb.edu>
References: <1168229596580-git-send-email-jsipek@cs.sunysb.edu>
	<1168229596875-git-send-email-jsipek@cs.sunysb.edu>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun,  7 Jan 2007 23:12:53 -0500
"Josef 'Jeff' Sipek" <jsipek@cs.sunysb.edu> wrote:

> +Modifying a Unionfs branch directly, while the union is mounted, is
> +currently unsupported.

Does this mean that if I have /a/b/ and /c/d/ unionised under /mnt/union, I
am not allowed to alter anything under /a/b/ and /c/d/?  That I may only
alter stuff under /mnt/union?

If so, that sounds like a significant limitation.

> Any such change can cause Unionfs to oops, or stay
> silent and even RESULT IN DATA LOSS.

With a rather rough user interface ;)


Also, is it possible to add new branches to an existing union mount?  And
to take old ones away?
