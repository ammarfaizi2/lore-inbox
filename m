Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265048AbUGSM5v@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265048AbUGSM5v (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jul 2004 08:57:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265086AbUGSM5v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jul 2004 08:57:51 -0400
Received: from wombat.indigo.net.au ([202.0.185.19]:57098 "EHLO
	wombat.indigo.net.au") by vger.kernel.org with ESMTP
	id S265048AbUGSM5u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jul 2004 08:57:50 -0400
Date: Mon, 19 Jul 2004 20:43:59 +0800 (WST)
From: raven@themaw.net
To: Carl Spalletta <cspalletta@yahoo.com>
cc: lkml <linux-kernel@vger.kernel.org>, autofs@linux.kernel.org
Subject: Re: [PATCH] Remove prototypes of nonexistent functions from fs/autofs4
 files
In-Reply-To: <20040718185909.22648.qmail@web53801.mail.yahoo.com>
Message-ID: <Pine.LNX.4.58.0407192042330.1373@donald.themaw.net>
References: <20040718185909.22648.qmail@web53801.mail.yahoo.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-MailScanner: Found to be clean
X-MailScanner-SpamCheck: not spam, SpamAssassin (score=-0.7, required 8,
	EMAIL_ATTRIBUTION, IN_REP_TO, NO_REAL_NAME, RCVD_IN_ORBS, REFERENCES,
	REPLY_WITH_QUOTES, USER_AGENT_PINE)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Thanks Carl.

I'll have a quick check and get this to Andrew soonish.

On Sun, 18 Jul 2004, Carl Spalletta wrote:

> diff -ru linux-2.6.7-orig/fs/autofs4/autofs_i.h linux-2.6.7-new/fs/autofs4/autofs_i.h
> --- linux-2.6.7-orig/fs/autofs4/autofs_i.h      2004-06-15 22:19:42.000000000 -0700
> +++ linux-2.6.7-new/fs/autofs4/autofs_i.h       2004-07-18 08:49:11.000000000 -0700
> @@ -138,7 +138,6 @@
>  }
> 
>  struct inode *autofs4_get_inode(struct super_block *, struct autofs_info *);
> -struct autofs_info *autofs4_init_inf(struct autofs_sb_info *, mode_t mode);
>  void autofs4_free_ino(struct autofs_info *);
> 
>  /* Expiration */
> 

