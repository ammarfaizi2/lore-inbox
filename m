Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964839AbWJIUjZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964839AbWJIUjZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Oct 2006 16:39:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964838AbWJIUjZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Oct 2006 16:39:25 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:43159 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S964839AbWJIUjY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Oct 2006 16:39:24 -0400
Date: Mon, 9 Oct 2006 21:39:25 +0100
From: Al Viro <viro@ftp.linux.org.uk>
To: Josef Sipek <jsipek@fsl.cs.sunysb.edu>
Cc: linux-kernel@vger.kernel.org, notting@redhat.com, akpm@osdl.org,
       torvalds@osdl.org, hch@infradead.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] Introduce vfs_listxattr
Message-ID: <20061009203925.GY29920@ftp.linux.org.uk>
References: <20061009201048.GA4707@filer.fsl.cs.sunysb.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061009201048.GA4707@filer.fsl.cs.sunysb.edu>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 09, 2006 at 04:10:48PM -0400, Josef Sipek wrote:
> From: Bill Nottingham <notting@redhat.com>
> 
> This patch moves code out of fs/xattr.c:listxattr into a new function -
> vfs_listxattr. The code for vfs_listxattr was originally submitted by Bill
> Nottingham <notting@redhat.com> to Unionfs.

Makes sense, regardless of unionfs.

ACKed-by: Al Viro <viro@zeniv.linux.org.uk>
