Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946622AbWJSWwS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946622AbWJSWwS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Oct 2006 18:52:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946621AbWJSWwS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Oct 2006 18:52:18 -0400
Received: from smtp.osdl.org ([65.172.181.4]:54976 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1946622AbWJSWwS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Oct 2006 18:52:18 -0400
Date: Thu, 19 Oct 2006 15:52:13 -0700
From: Andrew Morton <akpm@osdl.org>
To: Andreas Gruenbacher <agruen@suse.de>
Cc: Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Remove superfluous lock_super() in ext2 and ext3 xattr
 code
Message-Id: <20061019155213.d8d2417a.akpm@osdl.org>
In-Reply-To: <200610192034.24129.agruen@suse.de>
References: <200610192034.24129.agruen@suse.de>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 19 Oct 2006 20:34:24 +0200
Andreas Gruenbacher <agruen@suse.de> wrote:

> Index: linux-2.6.19-rc2/fs/ext2/xattr.c
> Index: linux-2.6.19-rc2/fs/ext3/xattr.c

You forgot ext4 ;)

I updated the patch, thanks.
