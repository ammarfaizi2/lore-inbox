Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964836AbWJIUei@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964836AbWJIUei (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Oct 2006 16:34:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964835AbWJIUei
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Oct 2006 16:34:38 -0400
Received: from smtp.osdl.org ([65.172.181.4]:43432 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964834AbWJIUeh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Oct 2006 16:34:37 -0400
Date: Mon, 9 Oct 2006 13:33:32 -0700
From: Andrew Morton <akpm@osdl.org>
To: Josef Sipek <jsipek@fsl.cs.sunysb.edu>
Cc: linux-kernel@vger.kernel.org, notting@redhat.com, torvalds@osdl.org,
       hch@infradead.org, viro@ftp.linux.org.uk, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] Introduce vfs_listxattr
Message-Id: <20061009133332.5c8285ce.akpm@osdl.org>
In-Reply-To: <20061009201048.GA4707@filer.fsl.cs.sunysb.edu>
References: <20061009201048.GA4707@filer.fsl.cs.sunysb.edu>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 9 Oct 2006 16:10:48 -0400
Josef Sipek <jsipek@fsl.cs.sunysb.edu> wrote:

> This patch moves code out of fs/xattr.c:listxattr into a new function -
> vfs_listxattr. The code for vfs_listxattr was originally submitted by Bill
> Nottingham <notting@redhat.com> to Unionfs.

That tells us what the patch does.  In general, please be sure to also tell
us *why* you prepared a patch.

Does this patch allow unionfs to be loaded into an otherwise unpatched
kernel.org kernel?  If so, that seems to be a good reason for including
this patch into the mainline kernel.
