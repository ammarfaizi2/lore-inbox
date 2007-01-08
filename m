Return-Path: <linux-kernel-owner+w=401wt.eu-S932163AbXAHVkP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932163AbXAHVkP (ORCPT <rfc822;w@1wt.eu>);
	Mon, 8 Jan 2007 16:40:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932160AbXAHVkO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Jan 2007 16:40:14 -0500
Received: from smtp.osdl.org ([65.172.181.24]:45578 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932147AbXAHVkM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Jan 2007 16:40:12 -0500
Date: Mon, 8 Jan 2007 13:29:58 -0800
From: Andrew Morton <akpm@osdl.org>
To: "Josef 'Jeff' Sipek" <jsipek@cs.sunysb.edu>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
       hch@infradead.org, viro@ftp.linux.org.uk, torvalds@osdl.org,
       mhalcrow@us.ibm.com, David Quigley <dquigley@fsl.cs.sunysb.edu>,
       Erez Zadok <ezk@cs.sunysb.edu>
Subject: Re: [PATCH 18/24] Unionfs: Superblock operations
Message-Id: <20070108132958.ec9f2481.akpm@osdl.org>
In-Reply-To: <11682295992885-git-send-email-jsipek@cs.sunysb.edu>
References: <1168229596580-git-send-email-jsipek@cs.sunysb.edu>
	<11682295992885-git-send-email-jsipek@cs.sunysb.edu>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun,  7 Jan 2007 23:13:10 -0500
"Josef 'Jeff' Sipek" <jsipek@cs.sunysb.edu> wrote:

> +	if (tmp_page)
> +		free_page((unsigned long) tmp_page);

free_page(0) is legal.
